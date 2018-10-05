package gaia3d.service;

import org.springframework.http.ResponseEntity;

import gaia3d.domain.APIResult;

/**
 * 결과 처리 API 호출 
 * @author jskim
 *
 */
public interface LogService {
	
	/**
	 * 영상 처리 결과 전송 
	 * @return
	 */
	public ResponseEntity<APIResult> updateImageProcessingStatus();
	
}
