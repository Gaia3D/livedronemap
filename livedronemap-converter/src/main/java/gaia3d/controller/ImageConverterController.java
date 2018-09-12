package gaia3d.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.persistence.ImageInfo;
import gaia3d.service.ImageConverterService;

@RestController
public class ImageConverterController {
	
	@Autowired
	private ImageConverterService imageConverterService;
	
	/**
	 * 이미지 선처리 작업 실행 
	 */
	@PostMapping("/convert/images")
	public String createConvertedImage(@RequestBody ImageInfo imageInfo) {
		
		imageConverterService.createConvertedImage(imageInfo);
		
		return "api test";
	}
	
}
