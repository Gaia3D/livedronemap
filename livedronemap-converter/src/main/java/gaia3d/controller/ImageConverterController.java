package gaia3d.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.APIResult;
import gaia3d.domain.ImageInfo;
import gaia3d.service.ImageConverterService;

@RequestMapping("/convert/")
@RestController
public class ImageConverterController {
	
	@Autowired
	private ImageConverterService imageConverterService;
	
	/**
	 * 이미지 선처리 작업 실행 
	 */
	@PostMapping("images")
	public ResponseEntity<APIResult> createConvertedImage(@RequestBody ImageInfo imageInfo) {
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null; 
		
		if (imageInfo.getProjectId() == null || imageInfo.getImageId() == null || imageInfo.getImagePath() == null) {
			httpStatus = HttpStatus.BAD_REQUEST;
			aPIResult.setStatusCode(httpStatus.value());
			aPIResult.setValidationCode("Required field is null.");
		} else {
			imageConverterService.createConvertedImage(imageInfo);
			
			httpStatus = HttpStatus.OK;
			aPIResult.setStatusCode(httpStatus.value());
		}
		
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
	
	// TODO 테스트 실행
	
	// TODO 헬스 체크 ?!
}
