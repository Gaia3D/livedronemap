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
import gaia3d.domain.PrivateAPIResult;
import gaia3d.service.GeoserverService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/geoserver/")
@RestController
public class GeoserverAPIController {
	
	@Autowired
	private GeoserverService geoserverService;
	
	@GetMapping("layers/{projectId}")
	public PrivateAPIResult getGeoserverLayer(HttpServletRequest request, @PathVariable("projectId") String projectId) {
		// TODO 인증 
		return geoserverService.selectGeoserverLayer(projectId);
	}
	
	@PostMapping("layers")
	public PrivateAPIResult createGeoserverLayer(HttpServletRequest request, @RequestBody ImageMosaic imageMosaic) {
		// TODO 인증 
		
		Integer projectId = imageMosaic.getProject_id();
		if (projectId == null) {
			// TODO 오류 처리 수정 필요 
			PrivateAPIResult aPIResult = new PrivateAPIResult();
			aPIResult.setResult("fail");
			aPIResult.setStatusCode(400);
			aPIResult.setMessage("project_id is required.");
			return aPIResult;
		}
		
		return geoserverService.createGeoserverLayer(projectId);
	}
	
	@PostMapping("images")
	public ResponseEntity<APIResult> createGeoserverImage(HttpServletRequest request, ImageMosaic imageMosaic) {
		// TODO 인증 
		return null;
	}
	
}
