package gaia3d.service;

import org.springframework.http.ResponseEntity;

import gaia3d.domain.APIResult;
import gaia3d.domain.ImageMosaic;
import springfox.documentation.service.ResponseMessage;

public interface GeoserverService {
	
	/**
	 * GeoServer 레이어 리스트 조회 
	 * @param imageMosaic
	 * @return
	 */
	ResponseEntity<APIResult> selectGeoserverLayer(String layerNm);
	
	/**
	 * GeoServer에 Layer 등록 
	 * @param imageMosaic
	 * @return
	 */
	String createGeoserverLayer(String projectId);
	
	/**
	 * GeoServer에 영상 등록 
	 * @param imageMosaic
	 * @return
	 */
	ImageMosaic insertGeoserverImage(ImageMosaic imageMosaic);
	
}
