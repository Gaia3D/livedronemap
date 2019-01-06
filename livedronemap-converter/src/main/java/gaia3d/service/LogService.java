package gaia3d.service;

import gaia3d.domain.ImageInfo;
import gaia3d.domain.ProcessingResult;

/**
 * 결과 처리 API 호출 
 * @author jskim
 *
 */
public interface LogService {
	
	/**
	 * 영상 처리 결과 전송 
	 * @param imageInfo
	 * @param processingResult
	 * @return
	 */
	public void updateImageProcessingStatus(ImageInfo imageInfo, ProcessingResult processingResult);
	
}
