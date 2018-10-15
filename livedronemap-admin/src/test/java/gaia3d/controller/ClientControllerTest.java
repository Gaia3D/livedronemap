package gaia3d.controller;

import static org.junit.Assert.*;

import java.util.Map;
import java.util.Random;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest
public class ClientControllerTest {

	@Test
	public void test() {
		// client_id, client_group_id, client_name, client_ip, use_yn, api_key, description 
		MultiValueMap<String, Object> formDataMap = new LinkedMultiValueMap<String, Object>();
		formDataMap.add("client_group_id", 1);
		formDataMap.add("client_name", "AI서버");
		formDataMap.add("client_ip", "0.0.0.0");
		formDataMap.add("use_yn", "Y");
		formDataMap.add("api_key", "test");
		formDataMap.add("description", "test server");
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost/clients";
		@SuppressWarnings("unchecked")
		Map<String, Object> result = restTemplate.postForObject(url, formDataMap, Map.class);
		//ResponseEntity<APIResult> responseEntity = restTemplate.exchange(url, HttpMethod.POST, request, APIResult.class);
        log.info("--- result = {}", result);
	}

}
