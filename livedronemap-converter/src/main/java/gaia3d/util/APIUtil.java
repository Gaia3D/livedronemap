package gaia3d.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.APIServerConfig;
import gaia3d.domain.APIResult;
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
	
	// TODO GeoServer 정보 저장 요청 / DB insert 
	/**
	 * GeoServer를 위한 이미지 정보 입력
	 */
	public ResponseEntity<APIResult> insertImageInfoForGeoServer(ImageMosaic imageMosaic) {
		// TODO config 연결 
		String url = aPIServerConfig.getRootUrl() +"/geoserver/images";
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
	
	// TODO GeoServer 레이어 발행
	/**
	 * GeoServer 레이어 생성
	 */
	public ResponseEntity<APIResult> createLayer(ImageMosaic imageMosaic) {
		// TODO config 연결 
		String url = aPIServerConfig.getRootUrl() + "/geoserver/layers";
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.postForEntity(url, imageMosaic, APIResult.class);
	}
	
	// TODO GeoServer 정보 확인
	/**
	 * GeoServer 레이어 확인 
	 */
	public ResponseEntity<APIResult> checkGeoServerInfo(Long projectId) {
		String url = aPIServerConfig.getRootUrl() + String.format("/geoserver/layers/%d", projectId);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.getForEntity(url, APIResult.class);
	}
}
