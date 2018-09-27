package gaia3d.service.impl;

import java.util.Base64;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import gaia3d.domain.APIResult;
import gaia3d.domain.ImageMosaic;
import gaia3d.service.GeoserverService;

@Service
public class GeoserverServiceImpl implements GeoserverService {
	
	@Override
	public ResponseEntity<APIResult> selectGeoserverLayer(String layerNm) {
		APIResult result = new APIResult();
		int statusCode = 200;
		
		// TODO policy 연결 
		// http://localhost:8080/geoserver/rest/workspaces/dronemap/coveragestores/dronemap/coverages/dronemap_t.json
		String geoserverDataUrl = "http://localhost:8080";
		String geoserverDataWorkspace = "dronemap";
		
		String url = String.format("%s/geoserver/rest/workspaces/%s/coveragestores/%s/coverages/%s", 
				geoserverDataUrl, geoserverDataWorkspace, geoserverDataWorkspace, layerNm);
		
		// TODO geoserver 계정 처리
		HttpHeaders headers = createHttpHeaders("admin", "geoserver");
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
		try {
			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			
		    statusCode = response.getStatusCodeValue();		
			result.setStatusCode(statusCode);
			
		} catch (HttpClientErrorException e) {
			String code = e.getMessage().split(" ")[0];
			statusCode = Integer.parseInt(code);
		}
		
		result.setStatusCode(statusCode);
		HttpStatus httpStatus = HttpStatus.valueOf(statusCode);
		result.setMessage(httpStatus.getReasonPhrase());

		return new ResponseEntity<APIResult>(result, httpStatus);
	}

	@Override
	public String createGeoserverLayer(String projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ImageMosaic insertGeoserverImage(ImageMosaic imageMosaic) {
		// TODO Auto-generated method stub
		return null;
	}
	
	private HttpHeaders createHttpHeaders(String user, String password)
	{
	    String notEncoded = user + ":" + password;
	    String encodedAuth = "Basic " + Base64.getEncoder().encodeToString(notEncoded.getBytes());
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    headers.add("Authorization", encodedAuth);
	    return headers;
	}

}
