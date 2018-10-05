package gaia3d.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.config.GdalConfig;
import gaia3d.domain.APIResult;
import gaia3d.domain.ImageInfo;
import gaia3d.service.GeoserverService;
import gaia3d.util.ImageProcessing;

/**
 * 영상 컨버터 
 * @author jskim
 *
 */
@RequestMapping("/converter/")
@RestController
public class ImageConverterController {
	
	@Autowired
	private GeoserverService geoserverService;
	@Autowired
	private GdalConfig gdalConfig;
	
	/**
	 * 이미지 선처리 요청 처리 
	 * @param imageInfo
	 * @return
	 */
	@PostMapping("images")
	public ResponseEntity<APIResult> createConvertedImage(@RequestBody ImageInfo imageInfo) {
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null; 
		
		try {
			if (imageInfo.getProjectId() == null || imageInfo.getImageId() == null 
					|| imageInfo.getImagePath() == null || imageInfo.getImageDate() == null
					|| imageInfo.getDataType() == null) {
				httpStatus = HttpStatus.BAD_REQUEST;
				aPIResult.setStatusCode(httpStatus.value());
				aPIResult.setValidationCode("Required field is null.");
				
				return new ResponseEntity<APIResult>(aPIResult, httpStatus);
			} 
			
			Runnable imageConvertUtil = new ImageProcessing(geoserverService, gdalConfig, imageInfo);
			Thread thread = new Thread(imageConvertUtil);
			thread.start();
			
			httpStatus = HttpStatus.OK;
			aPIResult.setStatusCode(httpStatus.value());
			
		} catch (Exception e) {
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			aPIResult.setStatusCode(httpStatus.value());
			aPIResult.setMessage(e.getMessage());
		}
		
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
	
	// TODO 테스트 실행
	// TODO 헬스 체크 ?!
}
