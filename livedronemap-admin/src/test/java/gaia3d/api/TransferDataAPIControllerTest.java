package gaia3d.api;

import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultMatcher;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.databind.ObjectMapper;

import gaia3d.domain.APIResult;
import gaia3d.domain.Drone;
import gaia3d.domain.OrthoDetectedObject;
import gaia3d.domain.TransferDataResource;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest
public class TransferDataAPIControllerTest {

	private MockMvc mockMvc;

	@Autowired
	private WebApplicationContext context;
	@Autowired
	private TransferDataAPIController transferDataAPIController;
	
	ObjectMapper mapper = new ObjectMapper();

	@Before
	public void setUp() throws Exception {
		//MockitoAnnotations.initMocks(this);
//      mockMvc = standaloneSetup(transferDataAPIController).build();
		this.mockMvc = webAppContextSetup(context).build();
	}
	
	/**
	 * 데이터 전송 테스트
	 * @throws Exception
	 */
	@Ignore
	public void mockMvcTransferData() throws Exception {
		TransferDataResource transferDataResource = getTransferDataResource();
		String jsonContent = mapper.writeValueAsString(transferDataResource);
        log.info("{}", jsonContent);
		
//		MvcResult mvcResult = mockMvc.perform(post("http://localhost/transfer-data")
//				.content(jsonContent))
//				.andExpect(status().isOk())
//				.andReturn();
		
		ResultMatcher ok = MockMvcResultMatchers.status().isOk();
		String fileName = "test.txt";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("live_drone_map", getCustomHeader());
		MockMultipartFile attachFile = new MockMultipartFile("file", fileName, "text/plain", "test data".getBytes());
		MockHttpServletRequestBuilder builder = MockMvcRequestBuilders.multipart("http://localhost/transfer-data").file(attachFile);
		this.mockMvc.perform(builder.headers(headers).content(jsonContent))
					.andExpect(ok)
					.andDo(MockMvcResultHandlers.print());
		
		//log.info("{}", mvcResult.getResponse().getContentAsString());
	}
	
	@Ignore
	public void restTempateTransferData1() throws Exception {
		MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<>();
		bodyMap.add("file", getFileResource());
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		headers.add("live_drone_map", getCustomHeader());
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(bodyMap, headers);
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<APIResult> response = restTemplate.exchange("http://localhost/transfer-data", HttpMethod.POST, requestEntity, APIResult.class);
		System.out.println("response status: " + response.getStatusCode());
		System.out.println("response body: " + response.getBody());
	}
	
	@Test
	public void restTempateTransferData() throws Exception {
		MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<>();
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		headers.add("live_drone_map", getCustomHeader());
		
		bodyMap.add("file_meta", getTransferDataResource());
		bodyMap.add("file", getFileResource());
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost/transfer-data";
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(bodyMap, headers);
		APIResult aPIResult = restTemplate.postForObject(url, requestEntity, APIResult.class);
		
		log.info("statusCode = {}, validationCode = {}, message = {}", aPIResult.getStatusCode(), aPIResult.getValidationCode(), aPIResult.getMessage());
	}
	
	private Resource getFileResource() throws Exception {
		Random random = new Random();
		int number = random.nextInt(6);
		String filePath = "C:\\livedronemap\\data\\marine_surveillance_" + number + ".tif";
		return new FileSystemResource(filePath);
	}
	
	private TransferDataResource getTransferDataResource() throws Exception {
		Drone drone = new Drone();
		drone.setLatitude(new BigDecimal("37.22516"));
		drone.setLongitude(new BigDecimal("128.2151"));
		drone.setAltitude(new BigDecimal("100"));
		drone.setRoll(new BigDecimal("2.123"));
		drone.setPitch(new BigDecimal("0.23"));
		drone.setYaw(new BigDecimal("1.2323"));
		
		List<OrthoDetectedObject> detected_objects = new ArrayList<>();
		for(int i=0; i<2; i++) {
			OrthoDetectedObject orthoDetectedObject = new OrthoDetectedObject();
			orthoDetectedObject.setNumber(i);
			orthoDetectedObject.setGeometry("POINT (128.382757714281 34.7651373676212)");
			orthoDetectedObject.setObject_type("0");
			orthoDetectedObject.setDetected_date("20180929203800");
			orthoDetectedObject.setBounding_box_geometry("POLYGON ((128.382734145868 34.7651857207077,128.382789761448 34.7651808845703,128.382783958083 34.7650672353414,128.38272544082 34.7650730387062,128.382734145868 34.7651857207077))");
			orthoDetectedObject.setMajor_axis(30);
			orthoDetectedObject.setMinor_axis(50);
			orthoDetectedObject.setOrientation(260);
			orthoDetectedObject.setBounding_box_area(150);
			orthoDetectedObject.setLength(30);
			orthoDetectedObject.setSpeed(12);
			
			detected_objects.add(orthoDetectedObject);
		}
		
		TransferDataResource transferDataResource = new TransferDataResource();
		transferDataResource.setDrone_project_id(7);
		transferDataResource.setData_type("0");
		transferDataResource.setFile_name("test.jpg");
		transferDataResource.setDetected_objects(detected_objects);
		transferDataResource.setDrone(drone);
		transferDataResource.setShooting_date("20180929203800");
		
		String jsonStr = mapper.writeValueAsString(transferDataResource);
        log.info("{}", jsonStr);
        
        return transferDataResource;
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
}

