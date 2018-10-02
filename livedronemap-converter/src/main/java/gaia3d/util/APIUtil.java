package gaia3d.util;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

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
	
	// TODO 로그 저장
	/**
	 * 영상 처리 결과 및 오류 전
	 */
	public void insertProcessInfo() {
		
	}
	
	// TODO GeoServer 정보 저장 요청 / DB insert 
	/**
	 * GeoServer를 위한 이미지 정보 입력
	 */
	public APIResult insertImageInfoForGeoServer(ImageMosaic imageMosaic) {
		// TODO config 연결 
		String url = "http://localhost:9999/geoserver" + "/images";
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.postForObject(url, imageMosaic, APIResult.class);
	}
	
	// TODO GeoServer 작업공간 생성
	/**
	 * GeoServer 작업공간 (없으면) 생성
	 */
	public void createWorkspace() {
		
	}
	
	// TODO GeoServer 저장소 생성
	/**
	 * GeoServer 저장소 (없으면) 생성
	 */
	public void createStore() {
		
	}
	
	// TODO GeoServer 레이어 발행
	/**
	 * GeoServer 레이어 생성
	 */
	public APIResult createLayer(ImageMosaic imageMosaic) {
		// TODO config 연결 
		String url = "http://localhost:9999/geoserver" + "/layers";
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.postForObject(url, imageMosaic, APIResult.class);
	}
	
	// TODO GeoServer 정보 확인
	/**
	 * GeoServer 레이어 확인 
	 */
	public APIResult checkGeoServerInfo(int projectId) {
		String url = "http://localhost:9999/geoserver" + String.format("/layers/%d", projectId);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.getForObject(url, APIResult.class);
	}
}
