package gaia3d.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.APIServerConfig;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIURL;
import gaia3d.domain.ImageDataType;
import gaia3d.domain.ImageMosaic;
import lombok.extern.slf4j.Slf4j;

/**
 * RestAPI 호출 클래스 
 * @author jskim
 *
 */
@Slf4j
@Component
public class APIUtil {
	
	@Autowired
	APIServerConfig aPIServerConfig;
	
	// TODO 로그 저장
	/**
	 * 영상 처리 결과 및 오류 전송 
	 */
	public void insertProcessInfo() {
		
	}
	
	/**
	 * GeoServer를 위한 이미지 정보 입력
	 */
	public ResponseEntity<APIResult> insertImageInfoForGeoServer(ImageMosaic imageMosaic) {
		String url = aPIServerConfig.getRootUrl() + APIURL.GEOSERVER_IMAGES.getUrl();
		log.info("url = {}", url);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.postForEntity(url, imageMosaic, APIResult.class);
	}
	
	// TODO GeoServer 작업공간 생성
	/**
	 * GeoServer 작업공간 생성
	 */
	public void createWorkspace() {
		
	}
	
	// TODO GeoServer 저장소 생성
	/**
	 * GeoServer 저장소 생성
	 */
	public void createStore() {
		
	}
	
	/**
	 * GeoServer 레이어 생성
	 */
	public ResponseEntity<APIResult> createLayer(ImageMosaic imageMosaic) {
		String url = null;
		if (imageMosaic.getData_type().equals(ImageDataType.ORTHO_IMAGE.getDataType())) {
			url = aPIServerConfig.getRootUrl() + APIURL.GEOSERVER_LAYERS_ORTHO_IMAGES.getUrl();
		} else {
			url = aPIServerConfig.getRootUrl() + APIURL.GEOSERVER_LAYERS_POSTPROCESSING_IMAGES.getUrl();
		}
		log.info("url = {}", url);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.postForEntity(url, imageMosaic, APIResult.class);
	}

	/**
	 * GeoServer 레이어 확인 
	 */
	public ResponseEntity<APIResult> checkGeoServerInfo(ImageMosaic imageMosaic) {
		String url = null;
		if (imageMosaic.getData_type().equals(ImageDataType.ORTHO_IMAGE.getDataType())) {
			url = aPIServerConfig.getRootUrl() 
					+ String.format("%s/%d", APIURL.GEOSERVER_LAYERS_ORTHO_IMAGES.getUrl(), imageMosaic.getProject_id());
		} else {
			url = aPIServerConfig.getRootUrl() 
					+ String.format("%s/%d", APIURL.GEOSERVER_LAYERS_POSTPROCESSING_IMAGES.getUrl(), imageMosaic.getProject_id());
		}
		log.info("url = {}", url);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.getForEntity(url, APIResult.class);
	}
}
