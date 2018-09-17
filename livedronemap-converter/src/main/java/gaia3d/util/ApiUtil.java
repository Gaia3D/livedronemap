package gaia3d.util;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

/**
 * RestAPI 호출 클래스 
 * @author jskim
 *
 */
@Slf4j
@Component
public class ApiUtil {
	
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
	public void insertImageInfoForGeoServer() {
		
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
	 * GeoServer 레이어 (없으면) 생성
	 */
	public void createLayer() {
		
	}
	
	// TODO GeoServer 정보 확인
	/**
	 * GeoServer 작업공간, 저장소, 레이어 확인 
	 */
	public void checkGeoServerInfo() {
		
	}
}
