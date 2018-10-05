package gaia3d.service;

import gaia3d.domain.ImageMosaic;
import gaia3d.domain.TransferDataType;

public interface GeoserverService {
	
	/**
	 * GeoServer 레이어 확인 
	 * @param projectId
	 * @param transferDataType 
	 * @return
	 */
	Long getGeoserverLayer(Long projectId, TransferDataType transferDataType);
	
	/**
	 * GeoServer 레이어 생성
	 * @param projectId
	 * @param transferDataType 
	 * @return
	 */
	Long insertGeoserverLayer(Long projectId, TransferDataType transferDataType);
	
	/**
	 * GeoServer 서비스 영상 정보 입력 
	 * @param imageMosaic
	 * @return
	 */
	int insertGeoserverImage(ImageMosaic imageMosaic);
	
}
