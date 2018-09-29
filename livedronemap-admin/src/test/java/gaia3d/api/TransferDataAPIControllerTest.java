package gaia3d.api;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.databind.ObjectMapper;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import gaia3d.LivedronemapAdminApplicationTests;
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
	
	@Test
	public void test() throws Exception {
//		MockHttpServletRequestBuilder createMessage = post("/messages/")
//				.param("summary", "Spring Rocks")
//				.param("text", "In case you didn't know, Spring Rocks!"); 
//		
//		mockMvc.perform(createMessage) 
//			.andExpect(status().isOk())
//			.andDo(print());

	}
	
	/**
	 * 데이터 전송 테스트
	 * @throws Exception
	 */
	@Test
	public void transferData() throws Exception {
		TransferDataResource transferDataResource = getTransferDataResource();
		String jsonContent = mapper.writeValueAsString(transferDataResource);
        log.info("{}", jsonContent);
		
		MvcResult mvcResult = mockMvc.perform(post("http://localhost/transfer-data")
				.content(jsonContent))
				.andExpect(status().isOk())
				.andReturn();
		
		log.info("{}", mvcResult.getResponse().getContentAsString());
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
			orthoDetectedObject.setDetected_date("2018-09-29 20:38:00");
			orthoDetectedObject.setBounding_box_geometry("POLYGON ((128.382734145868 34.7651857207077,128.382789761448 34.7651808845703,128.382783958083 34.7650672353414,128.38272544082 34.7650730387062,128.382734145868 34.7651857207077))");
			orthoDetectedObject.setMajor_axis("30");
			orthoDetectedObject.setMinor_axis("50");
			orthoDetectedObject.setOrientation("260");
			orthoDetectedObject.setBounding_box_area("150");
			orthoDetectedObject.setLength("30");
			orthoDetectedObject.setSpeed("12");
			
			detected_objects.add(orthoDetectedObject);
		}
		
		TransferDataResource transferDataResource = new TransferDataResource();
		transferDataResource.setDrone_project_id(1);
		transferDataResource.setData_type("0");
		transferDataResource.setFile_name("test.jpg");
		transferDataResource.setDetected_objects(detected_objects);
		transferDataResource.setDrone(drone);
		transferDataResource.setShooting_date("2018-09-29 20:38:00");
		
		String jsonStr = mapper.writeValueAsString(transferDataResource);
        log.info("{}", jsonStr);
        
        return transferDataResource;
	}
}

