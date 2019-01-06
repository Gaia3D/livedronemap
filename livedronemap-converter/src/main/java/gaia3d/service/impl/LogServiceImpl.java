package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.APIServerConfig;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIURL;
import gaia3d.domain.ImageInfo;
import gaia3d.domain.ProcessingResult;
import gaia3d.domain.TransferDataType;
import gaia3d.service.LogService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LogServiceImpl implements LogService{
	
	@Autowired
	APIServerConfig aPIServerConfig;

	public void updateImageProcessingStatus(ImageInfo imageInfo, ProcessingResult processingResult) {
		String url = aPIServerConfig.getRootUrl();
		if (imageInfo.getDataType().equals(TransferDataType.ORTHO_IMAGE.getDataType())) {
			url += APIURL.ORTHO_IMAGES.getUrl();
		} else {
			url += APIURL.POSTPROCESSING_IMAGES.getUrl();
		}
		url = url + String.format("/%d?status=%s", imageInfo.getImageId(), processingResult.getStatus());
		log.info("url = {}", url);
		RestTemplate restTemplate = new RestTemplate();
		
		try {
			ResponseEntity<APIResult> aPIResult = restTemplate.postForEntity(url, null, APIResult.class);
			log.info("@@ log status {}", aPIResult.getStatusCode());
			
		} catch (Exception e) {
			// TODO 상태 업데이트 하다가 오류가 나면 .. ?!
			e.printStackTrace();
		}
	}

}
