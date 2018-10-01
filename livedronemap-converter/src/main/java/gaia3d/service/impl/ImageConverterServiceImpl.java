package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gaia3d.config.GdalConfig;
import gaia3d.domain.APIResult;
import gaia3d.domain.ImageInfo;
import gaia3d.service.ImageConverterService;
import gaia3d.util.ImageConvertUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 이미지 변환 클래스
 * @author Kim JeaSeon
 *
 */
@Slf4j
@Service
public class ImageConverterServiceImpl implements ImageConverterService {
	
	@Autowired
	private GdalConfig gdalConfig;
	
	@Override
	public APIResult createConvertedImage(ImageInfo imageInfo) {
		log.info("Start converting : {}", imageInfo.getImagePath());
		APIResult aPIResult = new APIResult();
		
		try {
			Runnable imageConvertUtil = new ImageConvertUtil(gdalConfig, imageInfo);
			Thread thread = new Thread(imageConvertUtil);
			thread.start();
			
			aPIResult.setResult("success");
			aPIResult.setStatusCode(200);
			
		} catch (Exception e) {
			aPIResult.setResult("fail");
			aPIResult.setStatusCode(500);
			aPIResult.setMessage(e.getMessage());
		}
		
		return aPIResult;
		
	}
	
}
