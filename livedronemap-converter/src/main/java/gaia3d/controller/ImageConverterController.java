package gaia3d.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.APIResult;
import gaia3d.domain.ImageInfo;
import gaia3d.service.ImageConverterService;

@RestController
public class ImageConverterController {
	
	@Autowired
	private ImageConverterService imageConverterService;
	
	/**
	 * 이미지 선처리 작업 실행 
	 */
	@PostMapping("/convert/images")
	public APIResult createConvertedImage(@RequestBody ImageInfo imageInfo) {
		APIResult aPIResult = new APIResult();
		
		if (imageInfo.getProjectId() == null || imageInfo.getImageId() == null || imageInfo.getImagePath() == null) {
			aPIResult.setResult("fail");
			aPIResult.setStatusCode(400);
			aPIResult.setMessage("Parameters is invalid.");
		} else {
			aPIResult = imageConverterService.createConvertedImage(imageInfo);
		}
		
		return aPIResult;
	}
	
}
