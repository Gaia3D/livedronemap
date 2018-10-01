package gaia3d.service;

import gaia3d.domain.ImageMosaic;
import gaia3d.domain.PrivateAPIResult;

public interface GeoserverService {
	
	/**
	 * GeoServer 레이어 리스트 조회 
	 * @param projectId
	 * @return
	 */
	PrivateAPIResult selectGeoserverLayer(String projectId);
	
	/**
	 * GeoServer에 Layer 등록 
	 * @param projectId
	 * @return
	 */
	PrivateAPIResult createGeoserverLayer(int projectId);
	
	/**
	 * GeoServer에 영상 등록 
	 * @param imageMosaic
	 * @return
	 */
	PrivateAPIResult insertGeoserverImage(ImageMosaic imageMosaic);
	
}
