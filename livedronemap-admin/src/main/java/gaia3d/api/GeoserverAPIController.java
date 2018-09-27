package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.APIResult;
import gaia3d.domain.ImageMosaic;
import gaia3d.service.GeoserverService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/geoserver/")
@RestController
public class GeoserverAPIController {
	
	@Autowired
	GeoserverService geoserverService;
	
	@GetMapping("layers/{layerName}")
	public ResponseEntity<APIResult> getGeoserverLayer(HttpServletRequest request, @PathVariable("layerName") String layerNm) {
		log.info("@@ project id : {}", layerNm);
		return geoserverService.selectGeoserverLayer(layerNm);
	}
	
	@PostMapping("layers")
	public String createGeoserverLayer(HttpServletRequest request, String projectId) {
		log.info("@@ project id : {}", projectId);
		return null;
	}
	
	@PostMapping("images")
	public String createGeoserverImage(HttpServletRequest request, ImageMosaic imageMosaic) {
		return null;
	}
	
}
