package gaia3d.service;

import gaia3d.domain.ImageMosaic;

public interface GeoserverService {
	
	/**
	 * GeoServer 레이어 리스트 조회 
	 * @param projectId
	 * @return
	 */
	Long getGeoserverLayer(Long projectId);
	
	/**
	 * GeoServer에 Layer 등록 
	 * @param projectId
	 * @return
	 */
	Long inputGeoserverLayer(Long projectId);
	
	/**
	 * GeoServer에 영상 등록 
	 * @param imageMosaic
	 * @return
	 */
	int insertGeoserverImage(ImageMosaic imageMosaic);
	
}
