package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.APIServerConfig;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIURL;
import gaia3d.domain.ImageDataType;
import gaia3d.domain.ImageMosaic;
import gaia3d.service.GeoserverService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GeoserverServiceImpl implements GeoserverService {
	
	@Autowired
	APIServerConfig aPIServerConfig;
	
	/**
	 * GeoServer에 영상 정보 저장 
	 * @param imageMosaic
	 * @return
	 */
	public ResponseEntity<APIResult> insertImageInfoForGeoServer(ImageMosaic imageMosaic) {
		String url = aPIServerConfig.getRootUrl() + APIURL.GEOSERVER_IMAGES.getUrl();
		log.info("url = {}", url);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.postForEntity(url, imageMosaic, APIResult.class);
	}
	
	/**
	 * GeoServer에 layer 생성 
	 * @return
	 * @param imageMosaic
	 */
	public ResponseEntity<APIResult> createGeoserverLayer(ImageMosaic imageMosaic) {
		String url = null;
		if (imageMosaic.getData_type().equals(ImageDataType.ORTHO_IMAGE.getDataType())) {
			url = aPIServerConfig.getRootUrl() + APIURL.GEOSERVER_LAYERS_ORTHO_IMAGES.getUrl();
		} else {
			url = aPIServerConfig.getRootUrl() + APIURL.GEOSERVER_LAYERS_POSTPROCESSING_IMAGES.getUrl();
		}
		log.info("url = {}", url);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.postForEntity(url, imageMosaic, APIResult.class);
	}

	/**
	 * GeoServer에 layer 확인 
	 * @param imageMosaic
	 * @return
	 */
	public ResponseEntity<APIResult> checkGeoServerLayer(ImageMosaic imageMosaic) {
		String url = null;
		if (imageMosaic.getData_type().equals(ImageDataType.ORTHO_IMAGE.getDataType())) {
			url = aPIServerConfig.getRootUrl() 
					+ String.format("%s/%d", APIURL.GEOSERVER_LAYERS_ORTHO_IMAGES.getUrl(), imageMosaic.getProject_id());
		} else {
			url = aPIServerConfig.getRootUrl() 
					+ String.format("%s/%d", APIURL.GEOSERVER_LAYERS_POSTPROCESSING_IMAGES.getUrl(), imageMosaic.getProject_id());
		}
		log.info("url = {}", url);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.getForEntity(url, APIResult.class);
	}

}
