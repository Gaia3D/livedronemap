package gaia3d.api;

import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

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
import gaia3d.util.DateUtil;
import gaia3d.util.FormatUtil;
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
	
	private String[] POINT = {
			"POINT (128.383354173067 34.7651263406521)",
			"POINT (128.382757714281 34.7651373676212)",
			"POINT (128.383925370069 34.7667388845233)",
			"POINT (128.384959098305 34.770929934764)",
			"POINT (128.388532638272 34.7744513472413)",
			"POINT (128.388676189362 34.7745275335737)"
	};
	private String[] BOUNDING_BOX = {
			"POLYGON ((128.383354138682 34.765181368184,128.383405885352 34.7651639580893,128.383357040365 34.7650551449979,128.383300941171 34.7650773912299,128.383354138682 34.765181368184))",
			"POLYGON ((128.382734145868 34.7651857207077,128.382789761448 34.7651808845703,128.382783958083 34.7650672353414,128.38272544082 34.7650730387062,128.382734145868 34.7651857207077))",
			"POLYGON ((128.383899293915 34.7667874169953,128.383947010618 34.7667846101305,128.383936184139 34.7666731374968,128.383889269398 34.7666771473038,128.383899293915 34.7667874169953))",
			"POLYGON ((128.384887310351 34.770899073058,128.384979535912 34.771006134904,128.385026851634 34.7709780662553,128.384929814305 34.7708681975444,128.384887310351 34.770899073058))",
			"POLYGON ((128.388466063068 34.7744397326088,128.388568313146 34.7745050924623,128.388595980814 34.7744678012576,128.388492126814 34.7744040453268,128.388466063068 34.7744397326088))",
			"POLYGON ((128.388625252405 34.7745596258371,128.388757576035 34.7745383738602,128.388752764266 34.7744942659835,128.388619237694 34.7745171218832,128.388625252405 34.7745596258371))"
	};
	
	ObjectMapper mapper = new ObjectMapper();

	@Before
	public void setUp() throws Exception {
		//MockitoAnnotations.initMocks(this);
//      mockMvc = standaloneSetup(transferDataAPIController).build();
		this.mockMvc = webAppContextSetup(context).build();
	}
	
//	/**
//	 * 데이터 전송 테스트
//	 * @throws Exception
//	 */
//	@Ignore
//	public void mockMvcTransferData() throws Exception {
//		TransferDataResource transferDataResource = getTransferDataResource();
//		String jsonContent = mapper.writeValueAsString(transferDataResource);
//        log.info("{}", jsonContent);
//		
////		MvcResult mvcResult = mockMvc.perform(post("http://localhost/transfer-data")
////				.content(jsonContent))
////				.andExpect(status().isOk())
////				.andReturn();
//		
//		ResultMatcher ok = MockMvcResultMatchers.status().isOk();
//		String fileName = "test.txt";
//		
//		HttpHeaders headers = new HttpHeaders();
//		headers.add("live_drone_map", getCustomHeader());
//		MockMultipartFile attachFile = new MockMultipartFile("file", fileName, "text/plain", "test data".getBytes());
//		MockHttpServletRequestBuilder builder = MockMvcRequestBuilders.multipart("http://localhost/transfer-data").file(attachFile);
//		this.mockMvc.perform(builder.headers(headers).content(jsonContent))
//					.andExpect(ok)
//					.andDo(MockMvcResultHandlers.print());
//		
//		//log.info("{}", mvcResult.getResponse().getContentAsString());
//	}
	
//	@Ignore
//	public void restTempateTransferData1() throws Exception {
//		MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<>();
//		bodyMap.add("file", getFileResource());
//		HttpHeaders headers = new HttpHeaders();
//		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
//		headers.add("live_drone_map", getCustomHeader());
//		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(bodyMap, headers);
//		
//		RestTemplate restTemplate = new RestTemplate();
//		ResponseEntity<APIResult> response = restTemplate.exchange("http://localhost/transfer-data", HttpMethod.POST, requestEntity, APIResult.class);
//		System.out.println("response status: " + response.getStatusCode());
//		System.out.println("response body: " + response.getBody());
//	}
	
	@Ignore
	/**
	 * 이걸 ignore 한 이유는 gradle build 할때 실행하면 무지 시간이 오래 걸리므로, 할때마다 고쳐서 사용하시길
	 * @throws Exception
	 */
	public void restTempateTransferData() throws Exception {
		
		for(int i=0; i<6; i++) {
			MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<>();
			
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.MULTIPART_FORM_DATA);
			headers.add("live_drone_map", getCustomHeader());
			
			bodyMap.add("file_meta", getTransferDataResource(i));
			bodyMap.add("file", getFileResource(i));
			
			RestTemplate restTemplate = new RestTemplate();
			String url = "http://localhost/transfer-data";
			HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(bodyMap, headers);
			APIResult aPIResult = restTemplate.postForObject(url, requestEntity, APIResult.class);
			
			log.info("statusCode = {}, validationCode = {}, message = {}", aPIResult.getStatusCode(), aPIResult.getValidationCode(), aPIResult.getMessage());
		}
	}
	
	private Resource getFileResource(int index) throws Exception {
		int number = index + 1;
		String filePath = "C:\\livedronemap\\data\\marine_surveillance_" + number + ".tif";
		return new FileSystemResource(filePath);
	}
	
	private TransferDataResource getTransferDataResource(int index) throws Exception {
		
		int number = index + 1;
		List<OrthoDetectedObject> detected_objects = new ArrayList<>();
			
		OrthoDetectedObject orthoDetectedObject = new OrthoDetectedObject();
		orthoDetectedObject.setNumber(number);
		orthoDetectedObject.setGeometry(POINT[index]);
		orthoDetectedObject.setObject_type("0");
		orthoDetectedObject.setDetected_date(DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14));
		orthoDetectedObject.setBounding_box_geometry(BOUNDING_BOX[index]);
		orthoDetectedObject.setMajor_axis(30);
		orthoDetectedObject.setMinor_axis(50);
		orthoDetectedObject.setOrientation(260);
		orthoDetectedObject.setBounding_box_area(150);
		orthoDetectedObject.setLength(30);
		orthoDetectedObject.setSpeed(12);
			
		detected_objects.add(orthoDetectedObject);
		
		TransferDataResource transferDataResource = new TransferDataResource();
		transferDataResource.setDrone_project_id(1);
		transferDataResource.setData_type("0");
		transferDataResource.setFile_name("marine_surveillance_" + number + ".tif");
		transferDataResource.setDetected_objects(detected_objects);
		transferDataResource.setDrone(getDrone());
		transferDataResource.setShooting_date(DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14));
		
		String jsonStr = mapper.writeValueAsString(transferDataResource);
        log.info("{}", jsonStr);
        
        return transferDataResource;
	}
	
	private Drone getDrone() {
		Drone drone = new Drone();
		drone.setLatitude(new BigDecimal("37.22516"));
		drone.setLongitude(new BigDecimal("128.2151"));
		drone.setAltitude(new BigDecimal("100"));
		drone.setRoll(new BigDecimal("2.123"));
		drone.setPitch(new BigDecimal("0.23"));
		drone.setYaw(new BigDecimal("1.2323"));
		return drone;
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
}

