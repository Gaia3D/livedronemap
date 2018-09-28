package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@GetMapping("layers/{projectId}")
	public ResponseEntity<APIResult> getGeoserverLayer(HttpServletRequest request, @PathVariable("projectId") String projectId) {
		// TODO 인증 
		return geoserverService.selectGeoserverLayer(projectId);
	}
	
	@PostMapping("layers")
	public ResponseEntity<APIResult> createGeoserverLayer(HttpServletRequest request, @RequestBody ImageMosaic imageMosaic) {
		// TODO 인증 
		Integer projectId = imageMosaic.getProject_id();
		if (projectId == null) {
			return null;
		}
		
		log.info("@@ project id : {}", projectId);
		
		geoserverService.createGeoserverLayer(projectId);
		
		return null;
	}
	
	@PostMapping("images")
	public ResponseEntity<APIResult> createGeoserverImage(HttpServletRequest request, ImageMosaic imageMosaic) {
		// TODO 인증 
		return null;
	}
	
}
