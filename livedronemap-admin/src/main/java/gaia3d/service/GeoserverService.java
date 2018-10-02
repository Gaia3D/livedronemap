package gaia3d.service;

import gaia3d.domain.ImageMosaic;

public interface GeoserverService {
	
	/**
	 * GeoServer 레이어 확인 
	 * @param projectId
	 * @return
	 */
	Long getGeoserverLayer(Long projectId);
	
	/**
	 * GeoServer 레이어 생성
	 * @param projectId
	 * @return
	 */
	Long inputGeoserverLayer(Long projectId);
	
	/**
	 * GeoServer 서비스 영상 정보 입력 
	 * @param imageMosaic
	 * @return
	 */
	int insertGeoserverImage(ImageMosaic imageMosaic);
	
}
