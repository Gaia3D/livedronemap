package gaia3d.service.impl;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import gaia3d.domain.ImageMosaic;
import gaia3d.domain.PrivateAPIResult;
import gaia3d.security.Crypt;
import gaia3d.service.GeoserverService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GeoserverServiceImpl implements GeoserverService {
	
	@Override
	public PrivateAPIResult selectGeoserverLayer(String projectId) {
		PrivateAPIResult aPIResult = new PrivateAPIResult();
		
		// TODO policy 연결 
		// http://localhost:8080/geoserver/rest/workspaces/dronemap/coveragestores/dronemap/coverages/dronemap_t.json
		String geoserverDataUrl = "http://localhost:8080";
		String geoserverDataWorkspace = "dronemap";
		
		String layerName = String.format("%s_%s", geoserverDataWorkspace, projectId);
		String url = String.format("%s/geoserver/rest/workspaces/%s/coveragestores/%s/coverages/%s", 
				geoserverDataUrl, geoserverDataWorkspace, geoserverDataWorkspace, layerName);
		
		// TODO geoserver 계정 처리
		
		// set haeder
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		String user = "mkKxoOOBBWrvZK6yCF8l8w==";
		String password = "GjKX1+xXvjlIl65JNgVFzg==";
		String encodedUserPassword = encodeUserPassword(user, password);
	    headers.add("Authorization", "Basic " + encodedUserPassword);
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		
		try {
			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			
	    	aPIResult.setStatusCode(response.getStatusCodeValue());
	    	aPIResult.setResult("success");  // TOOD 상수 전환 
			
		} catch (HttpClientErrorException e) {
			aPIResult.setStatusCode(e.getRawStatusCode());
			aPIResult.setResult("fail");  // TOOD 상수 전환 
			aPIResult.setMessage(e.getResponseBodyAsString());
		}

		return aPIResult;
	}

	@Override
	public PrivateAPIResult createGeoserverLayer(int projectId) {
		PrivateAPIResult aPIResult = new PrivateAPIResult();
		
		// TODO policy 연결 
		// http://localhost:8080/geoserver/rest/workspaces/dronemap/coveragestores/dronemap/coverages
		String geoserverDataUrl = "http://localhost:8080";
		String geoserverDataWorkspace = "dronemap";
		
		String url = String.format("%s/geoserver/rest/workspaces/%s/coveragestores/%s/coverages", 
				geoserverDataUrl, geoserverDataWorkspace, geoserverDataWorkspace);
		
		String layerInfo = null;
		try {
			layerInfo = new String(Files.readAllBytes(Paths.get("src/main/resources/geoserver/layer.json")), StandardCharsets.UTF_8);
			layerInfo = layerInfo.replace("{projectId}", String.valueOf(projectId));
			layerInfo = layerInfo.replace("{workspaceName}", geoserverDataWorkspace);
			
		} catch (IOException e) {
			aPIResult.setResult("fail");
			aPIResult.setStatusCode(500);
			aPIResult.setMessage(e.getMessage());
			log.warn("", e);
			return aPIResult;
		}
		
		// set haeder
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		String user = "mkKxoOOBBWrvZK6yCF8l8w==";
		String password = "GjKX1+xXvjlIl65JNgVFzg==";
		String encodedUserPassword = encodeUserPassword(user, password);
	    headers.add("Authorization", "Basic " + encodedUserPassword);
		HttpEntity<String> requestEntity =  new HttpEntity<String>(layerInfo, headers);

		try {
			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity, String.class);
			
			aPIResult.setStatusCode(response.getStatusCodeValue());
	    	aPIResult.setResult("success");  // TOOD 상수 전환 
			
		} catch (HttpClientErrorException e) {
			aPIResult.setStatusCode(e.getRawStatusCode());
			aPIResult.setResult("fail");  // TOOD 상수 전환 
			aPIResult.setMessage(e.getResponseBodyAsString());
		}
		
		return aPIResult;
	}

	@Override
	public ImageMosaic insertGeoserverImage(ImageMosaic imageMosaic) {
		return null;
	}
	
	private String encodeUserPassword(String user, String password) {
		String plainUserPassword = Crypt.decrypt(user) + ":" + Crypt.decrypt(password);
		return Base64.getEncoder().encodeToString(plainUserPassword.getBytes());
	}
	
//	private HttpHeaders createHttpHeaders(String user, String password)
//	{
//	    String notEncoded = user + ":" + password;
//	    String encodedAuth = "Basic " + Base64.getEncoder().encodeToString(notEncoded.getBytes());
//	    HttpHeaders headers = new HttpHeaders();
//	    headers.setContentType(MediaType.APPLICATION_JSON);
//	    headers.add("Authorization", encodedAuth);
//	    return headers;
//	}

}
