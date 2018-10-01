package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.ImageMosaic;

/**
 * Geoserver 
 * @author Kim Jeaseon
 *
 */
@Repository
public interface GeoserverMapper {
	
	/**
	 * 이미지 정보 입력 
	 * @param imageMosaic
	 * @return
	 */
	int insertGeoserverImage(ImageMosaic imageMosaic);
	
}
