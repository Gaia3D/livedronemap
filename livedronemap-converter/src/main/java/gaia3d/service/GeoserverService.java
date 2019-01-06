package gaia3d.service;

import org.springframework.http.ResponseEntity;

import gaia3d.domain.APIResult;
import gaia3d.domain.ImageMosaic;

/**
 * GeoServer API 호출
 * @author jskim
 *
 */
public interface GeoserverService {
	
	public ResponseEntity<APIResult> insertImageInfoForGeoServer(ImageMosaic imageMosaic);
	
	public ResponseEntity<APIResult> createGeoserverLayer(ImageMosaic imageMosaic);
	
	public ResponseEntity<APIResult> checkGeoServerLayer(ImageMosaic imageMosaic);
	
}
