package gaia3d.controller;

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
public class DroneControllerTest {

	@Test
	public void test() {
		Random random = new Random();
		int number = random.nextInt(4) + 1;
		
		MultiValueMap<String, Object> formDataMap = new LinkedMultiValueMap<String, Object>();
		formDataMap.add("drone_name", "드론" + number + " 호기");
		
//		Drone drone = new Drone();
//		drone.setDrone_name("드론" + number + " 호기");
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost/drones";
		@SuppressWarnings("unchecked")
		Map<String, Object> result = restTemplate.postForObject(url, formDataMap, Map.class);
		//ResponseEntity<APIResult> responseEntity = restTemplate.exchange(url, HttpMethod.POST, request, APIResult.class);
        log.info("--- result = {}", result);
	}
}
