package gaia3d.api;

import java.util.UUID;

import org.junit.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import gaia3d.domain.APIResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class DroneProjectAPIControllerTest {

	@Test
	public void test() throws Exception {
		MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<>();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("live_drone_map", getCustomHeader());
		
		createDroneProject(bodyMap);
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost/drone-projects";
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(bodyMap, headers);
		APIResult aPIResult = restTemplate.postForObject(url, requestEntity, APIResult.class);
		
		log.info("statusCode = {}, validationCode = {}, message = {}", aPIResult.getStatusCode(), aPIResult.getValidationCode(), aPIResult.getMessage());
	}

	/**
	 * 암호화 된 header 값을 생성
	 * @return
	 * @throws Exception
	 */
	private String getCustomHeader() throws Exception {
		StringBuffer buffer = new StringBuffer();
		buffer.append("user_id=")
				.append("test")
				.append("&")
				.append("api_key=")
				.append(UUID.randomUUID().toString())
				.append("&")
				.append("token=")
				.append("22327341")
				.append("&")
				.append("role=")
				.append("ADMIN")
				.append("&")
				.append("algorithm=")
				.append("sha")
				.append("&")
				.append("type=")
				.append("jwt, mac")
				.append("&")
				.append("timestamp=")
				.append(System.nanoTime());
		
		return buffer.toString();
		//return AES128Cipher.encode(buffer.toString());
	}
	
	private MultiValueMap<String, Object> createDroneProject(MultiValueMap<String, Object> bodyMap) {
		bodyMap.add("drone_id", 1);
		bodyMap.add("drone_project_name", "test 드론 테스트 촬영 비행4");
		bodyMap.add("shooting_area", "동해 앞바다");
		bodyMap.add("shooting_latitude1", 37.1);
		bodyMap.add("shooting_longitude1", 132.23);
		bodyMap.add("shooting_latitude2", 37.2);
		bodyMap.add("shooting_longitude2", 132.24);
		bodyMap.add("shooting_latitude3", 37.3);
		bodyMap.add("shooting_longitude3", 132.25);
		bodyMap.add("shooting_latitude4", 37.4);
		bodyMap.add("shooting_longitude4", 132.26);
		bodyMap.add("location", "POINT (128.382757714281 34.7651373676212)");
		bodyMap.add("shooting_date", "20180929203800");
		bodyMap.add("description", "테스트 시끕하네... ");
		return bodyMap;
	}
	
}
