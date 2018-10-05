package gaia3d.service.impl;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.RestTemplateResponseErrorHandler;
import gaia3d.domain.CacheManager;
import gaia3d.domain.ImageMosaic;
import gaia3d.domain.Policy;
import gaia3d.domain.TransferDataType;
import gaia3d.exception.GeoserverException;
import gaia3d.persistence.GeoserverMapper;
import gaia3d.security.Crypt;
import gaia3d.service.GeoserverService;
import lombok.extern.slf4j.Slf4j;

/**
 * GeoServer 서비스 
 * @author jskim
 *
 */
@Slf4j
@Service
public class GeoserverServiceImpl implements GeoserverService {
	
	@Autowired
	private RestTemplateBuilder restTemplateBuilder;
	@Autowired
	private RestTemplateResponseErrorHandler restTemplateResponseErrorHandler;
	
	@Autowired
	private GeoserverMapper geoserverMapper;
	
	/**
	 * GeoServer 레이어 확인 
	 * @param projectId
	 * @return
	 */
	public Long getGeoserverLayer(Long projectId, TransferDataType transferDataType) {
		Policy policy = CacheManager.getPolicy();
		String geoserverDataUrl = policy.getGeoserver_data_url();
		String geoserverDataWorkspace = policy.getGeoserver_data_workspace();
		
		String layerName = String.format("%s_%d_%s", geoserverDataWorkspace, projectId, transferDataType.getDataType());
		// TODO 이건 고민 좀 .. 
		String url = String.format("%s/rest/workspaces/%s/coveragestores/%s/coverages/%s", 
				geoserverDataUrl, geoserverDataWorkspace, geoserverDataWorkspace, layerName);
		
		// set haeder
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		String user = policy.getGeoserver_user();
		String password = policy.getGeoserver_password();
		String encodedUserPassword = encodeUserPassword(user, password);
	    headers.add("Authorization", "Basic " + encodedUserPassword);
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		
		try {
			RestTemplate restTemplate = restTemplateBuilder.errorHandler(restTemplateResponseErrorHandler).build();
			ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			if (response.getStatusCode() != HttpStatus.OK) {
				throw new GeoserverException(response.getBody());
			}
		} catch (HttpClientErrorException e) {
			e.printStackTrace();
			throw new GeoserverException(e.getResponseBodyAsString());
		}

		return projectId;
	}

	/**
	 * GeoServer 레이어 생성
	 * @param projectId
	 * @return
	 */
	public Long insertGeoserverLayer(Long projectId, TransferDataType transferDataType) {
		Policy policy = CacheManager.getPolicy();
		String geoserverDataUrl = policy.getGeoserver_data_url();
		String geoserverDataWorkspace = policy.getGeoserver_data_workspace();
		
		// TODO 이건 고민 좀 .. 
		String url = String.format("%s/rest/workspaces/%s/coveragestores/%s/coverages", 
				geoserverDataUrl, geoserverDataWorkspace, geoserverDataWorkspace);
		
		String layerInfo = null;
		try {
			// TODO 경로 처리
			layerInfo = new String(Files.readAllBytes(Paths.get("src/main/resources/geoserver/layer.json")), StandardCharsets.UTF_8);
			layerInfo = layerInfo.replace("{workspaceName}", geoserverDataWorkspace);
			layerInfo = layerInfo.replace("{projectId}", String.valueOf(projectId));
			layerInfo = layerInfo.replace("{dataType}", transferDataType.getDataType());

			// set haeder
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);
			String user = policy.getGeoserver_user();
			String password = policy.getGeoserver_password();
			String encodedUserPassword = encodeUserPassword(user, password);
		    headers.add("Authorization", "Basic " + encodedUserPassword);
			HttpEntity<String> requestEntity =  new HttpEntity<String>(layerInfo, headers);

			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<String> response = restTemplate.postForEntity(url, requestEntity, String.class);
			
			if (response.getStatusCode() != HttpStatus.CREATED) {
				throw new GeoserverException(response.getBody());
			}
			
		} catch (HttpClientErrorException e) {
			throw new GeoserverException(e.getResponseBodyAsString());
		} catch (IOException e) {
			throw new GeoserverException(e.getMessage());
		}
		
		return projectId;
	}

	/**
	 * GeoServer 서비스 영상 정보 입력 
	 * @param imageMosaic
	 * @return
	 */
	@Transactional
	public int insertGeoserverImage(ImageMosaic imageMosaic) {
		return geoserverMapper.insertGeoserverImage(imageMosaic);
	}
	
	/**
	 * 유저 정보 Base64 인코딩 
	 * @param user
	 * @param password
	 * @return
	 */
	private String encodeUserPassword(String user, String password) {
		String plainUserPassword = Crypt.decrypt(user) + ":" + Crypt.decrypt(password);
		return Base64.getEncoder().encodeToString(plainUserPassword.getBytes());
	}

}
