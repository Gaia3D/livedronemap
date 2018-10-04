package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpServerErrorException;

import gaia3d.domain.GeoserverAPIResult;
import gaia3d.domain.ImageDataType;
import gaia3d.domain.ImageMosaic;
import gaia3d.exception.GeoserverException;
import gaia3d.service.GeoserverService;
import lombok.extern.slf4j.Slf4j;

/**
 * GeoServer 처리 API 
 * @author jskim
 *
 */
@Slf4j
@RequestMapping("/geoserver/")
@RestController
public class GeoserverAPIController {
	
	@Autowired
	private GeoserverService geoserverService;
	
	/**
	 * GeoServer 개별 정사 영상 레이어 확인 
	 * @param request
	 * @param projectId
	 * @return
	 */
	@GetMapping("layers/ortho-images/{projectId:[0-9]+}")
	public ResponseEntity<GeoserverAPIResult> getGeoserverOrthoImageLayer(HttpServletRequest request, @PathVariable("projectId") Long projectId) {
		// TODO 인증 
		
		log.info("@@@@@@@@@@@ projectId = {}", projectId);
		GeoserverAPIResult geoserverAPIResult = new GeoserverAPIResult();
		HttpStatus httpStatus = null; 
		try {
			geoserverService.getGeoserverLayer(projectId, ImageDataType.ORTHO_IMAGE);
			
			httpStatus = HttpStatus.OK;
			geoserverAPIResult.setStatusCode(httpStatus.value());
		} catch (Exception e) {
			e.printStackTrace();
			if (e instanceof GeoserverException) {
				httpStatus = HttpStatus.NOT_FOUND;
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}
			geoserverAPIResult.setStatusCode(httpStatus.value());
			geoserverAPIResult.setException(e.getClass().getName());
			geoserverAPIResult.setMessage(e.getMessage());
		}
		
		return new ResponseEntity<GeoserverAPIResult>(geoserverAPIResult, httpStatus); 
	}
	
	/**
	 * GeoServer 개별 정사 영상 레이어 생성 
	 * @param request
	 * @param imageMosaic
	 * @return
	 */
	@PostMapping("layers/ortho-images")
	public ResponseEntity<GeoserverAPIResult> insertGeoserverOrthoImageLayer(HttpServletRequest request, @RequestBody ImageMosaic imageMosaic) {
		// TODO 인증 
		
		GeoserverAPIResult geoserverAPIResult = new GeoserverAPIResult();
		HttpStatus httpStatus = null;
		try {
			Long projectId = imageMosaic.getProject_id();
			if (projectId == null) {
				httpStatus = HttpStatus.BAD_REQUEST;
				geoserverAPIResult.setStatusCode(httpStatus.value());
				geoserverAPIResult.setMessage("Required field is null.");
				return new ResponseEntity<GeoserverAPIResult>(geoserverAPIResult, httpStatus);
			} 
			geoserverService.insertGeoserverLayer(projectId, ImageDataType.ORTHO_IMAGE);
			
			httpStatus = HttpStatus.OK;
			geoserverAPIResult.setStatusCode(httpStatus.value());
			
		} catch (Exception e) {
			e.printStackTrace();
			if (e instanceof HttpServerErrorException) {
				httpStatus = ((HttpServerErrorException) e).getStatusCode();
				geoserverAPIResult.setMessage(((HttpServerErrorException) e).getResponseBodyAsString());
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				geoserverAPIResult.setMessage(e.getMessage());
			}
			geoserverAPIResult.setStatusCode(httpStatus.value());
			geoserverAPIResult.setException(e.getClass().getName());
		}
		
		return new ResponseEntity<GeoserverAPIResult>(geoserverAPIResult, httpStatus);
	}
	
	/**
	 * GeoServer 후처리 영상 레이어 확인 
	 * @param request
	 * @param projectId
	 * @return
	 */
	@GetMapping("layers/postprocessing-images/{projectId:[0-9]+}")
	public ResponseEntity<GeoserverAPIResult> getGeoserverPostProcessingImageLayer(HttpServletRequest request, @PathVariable("projectId") Long projectId) {
		// TODO 인증 
		
		GeoserverAPIResult geoserverAPIResult = new GeoserverAPIResult();
		HttpStatus httpStatus = null; 
		try {
			geoserverService.getGeoserverLayer(projectId, ImageDataType.POSTPROCESSING_IMAGE);
			
			httpStatus = HttpStatus.OK;
			geoserverAPIResult.setStatusCode(httpStatus.value());
		} catch (Exception e) {
			e.printStackTrace();
			if (e instanceof GeoserverException) {
				httpStatus = HttpStatus.NOT_FOUND;
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}
			geoserverAPIResult.setStatusCode(httpStatus.value());
			geoserverAPIResult.setException(e.getClass().getName());
			geoserverAPIResult.setMessage(e.getMessage());
		}
		
		return new ResponseEntity<GeoserverAPIResult>(geoserverAPIResult, httpStatus); 
	}
	
	/**
	 * GeoServer 후처리 영상 레이어 생성 
	 * @param request
	 * @param imageMosaic
	 * @return
	 */
	@PostMapping("layers/postprocessing-images")
	public ResponseEntity<GeoserverAPIResult> insertGeoserverPostProcessingImageLayer(HttpServletRequest request, @RequestBody ImageMosaic imageMosaic) {
		// TODO 인증 
		
		GeoserverAPIResult geoserverAPIResult = new GeoserverAPIResult();
		HttpStatus httpStatus = null;
		try {
			Long projectId = imageMosaic.getProject_id();
			if (projectId == null) {
				httpStatus = HttpStatus.BAD_REQUEST;
				geoserverAPIResult.setStatusCode(httpStatus.value());
				geoserverAPIResult.setMessage("Required field is null.");
				return new ResponseEntity<GeoserverAPIResult>(geoserverAPIResult, httpStatus);
			} 
			geoserverService.insertGeoserverLayer(projectId, ImageDataType.POSTPROCESSING_IMAGE);
			
			httpStatus = HttpStatus.OK;
			geoserverAPIResult.setStatusCode(httpStatus.value());
			
		} catch (Exception e) {
			e.printStackTrace();
			if (e instanceof HttpServerErrorException) {
				httpStatus = ((HttpServerErrorException) e).getStatusCode();
				geoserverAPIResult.setMessage(((HttpServerErrorException) e).getResponseBodyAsString());
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				geoserverAPIResult.setMessage(e.getMessage());
			}
			geoserverAPIResult.setStatusCode(httpStatus.value());
			geoserverAPIResult.setException(e.getClass().getName());
		}
		
		return new ResponseEntity<GeoserverAPIResult>(geoserverAPIResult, httpStatus);
	}
	
	/**
	 * GeoServer 서비스 영상 정보 입력 
	 * @param request
	 * @param imageMosaic
	 * @return
	 */
	@PostMapping("images")
	public ResponseEntity<GeoserverAPIResult> insertGeoserverImage(HttpServletRequest request, @RequestBody ImageMosaic imageMosaic) {
		// TODO 인증 
		
		GeoserverAPIResult geoserverAPIResult = new GeoserverAPIResult();
		HttpStatus httpStatus = null;
		try {
			if (imageMosaic.getLocation() == null || imageMosaic.getThe_geom() == null 
					|| imageMosaic.getImage_date() == null || imageMosaic.getProject_id() == null) {
				httpStatus = HttpStatus.BAD_REQUEST;
				geoserverAPIResult.setStatusCode(httpStatus.value());
				geoserverAPIResult.setMessage("Required field is null.");
				
				return new ResponseEntity<GeoserverAPIResult>(geoserverAPIResult, httpStatus);
			} 
			
			geoserverService.insertGeoserverImage(imageMosaic);

			httpStatus = HttpStatus.OK;
			geoserverAPIResult.setStatusCode(httpStatus.value());
			
		} catch(Exception e) {
			e.printStackTrace();
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			geoserverAPIResult.setStatusCode(httpStatus.value());
			geoserverAPIResult.setException(e.getClass().getName());
			geoserverAPIResult.setMessage(e.getMessage());
		}
		
		return new ResponseEntity<GeoserverAPIResult>(geoserverAPIResult, httpStatus);
	}
	
}
