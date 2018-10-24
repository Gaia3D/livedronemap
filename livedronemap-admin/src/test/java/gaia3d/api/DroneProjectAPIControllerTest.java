package gaia3d.api;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import gaia3d.domain.APIResult;
import gaia3d.util.DateUtil;
import gaia3d.util.FormatUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest
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
				.append("admin")
				.append("&")
				.append("api_key=")
				.append("test")
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
		bodyMap.add("drone_project_name", "서해 앞바다 불법 어선 탐지");
		bodyMap.add("shooting_area", "서해 앞바다");
		bodyMap.add("shooting_latitude1", 34.77394717788859);
		bodyMap.add("shooting_longitude1", 128.39215224363852);
		bodyMap.add("shooting_latitude2", 34.774483872809924);
		bodyMap.add("shooting_longitude2", 128.4083827226857);
		bodyMap.add("shooting_latitude3", 34.760386132087326);
		bodyMap.add("shooting_longitude3", 128.39187700657115);
		bodyMap.add("shooting_latitude4", 34.76046846630801);
		bodyMap.add("shooting_longitude4", 128.41026631001316);
		bodyMap.add("location", "POINT (128.39966538624049 34.767293523109075)");
		bodyMap.add("shooting_date", DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14));
		bodyMap.add("description", "테스트 시끕하네... ");
		return bodyMap;
	}
	
	private MultiValueMap<String, Object> createDroneProject1(MultiValueMap<String, Object> bodyMap) {
		bodyMap.add("drone_id", 1);
		bodyMap.add("drone_project_name", "실데이터 테스트 2");
		bodyMap.add("shooting_area", "남해");
		bodyMap.add("shooting_upper_left_latitude", 34.622224);
		bodyMap.add("shooting_upper_left_longitude", 127.789765);
		bodyMap.add("shooting_upper_right_latitude", 34.622224);
		bodyMap.add("shooting_upper_right_longitude", 127.803385);
		bodyMap.add("shooting_lower_left_latitude", 34.617687);
		bodyMap.add("shooting_lower_left_longitude", 127.789765);
		bodyMap.add("shooting_lower_right_latitude", 34.617687);
		bodyMap.add("shooting_lower_right_longitude", 127.803385);
		bodyMap.add("location", "POINT (127.796575 34.619955)");
		bodyMap.add("shooting_date", DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14));
		bodyMap.add("description", "테스트 2 입니다.");
		return bodyMap;
	}
}
