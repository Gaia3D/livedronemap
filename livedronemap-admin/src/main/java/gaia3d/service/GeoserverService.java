package gaia3d.service;

import org.springframework.http.ResponseEntity;

import gaia3d.domain.APIResult;
import gaia3d.domain.ImageMosaic;
import springfox.documentation.service.ResponseMessage;

public interface GeoserverService {
	
	/**
	 * GeoServer 레이어 리스트 조회 
	 * @param projectId
	 * @return
	 */
	ResponseEntity<APIResult> selectGeoserverLayer(String projectId);
	
	/**
	 * GeoServer에 Layer 등록 
	 * @param projectId
	 * @return
	 */
	String createGeoserverLayer(int projectId);
	
	/**
	 * GeoServer에 영상 등록 
	 * @param imageMosaic
	 * @return
	 */
	ImageMosaic insertGeoserverImage(ImageMosaic imageMosaic);
	
}
