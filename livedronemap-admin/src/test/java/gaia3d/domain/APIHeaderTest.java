package gaia3d.domain;

import org.junit.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class APIHeaderTest {

	@Test
	public void test() {
		String liveDroneMap = "user_id=test&api_key=test&toke=&role=admin&algorithm=sha&type=jwt";
		String[] headers = liveDroneMap.split("&");
		
		for(String value : headers) {
			log.info("@@@@@@@@@@@@@@@@ {}", value);
		}
		
		log.info("@@@@@@@@@@@@@@@@1 {}", headers[0].substring(7));
		log.info("@@@@@@@@@@@@@@@@2 {}", headers[1].substring(8));
		log.info("@@@@@@@@@@@@@@@@3 {}", headers[2].substring(5));
		log.info("@@@@@@@@@@@@@@@@4 {}", headers[3].substring(5));
		log.info("@@@@@@@@@@@@@@@@5 {}", headers[4].substring(10));
		log.info("@@@@@@@@@@@@@@@@6 {}", headers[5].substring(5));
		
//		apiHeader = new APIHeader();
//		apiHeader.setUserId(headers[0].substring(7));
//		apiHeader.setApiKey(headers[1].substring(8));
//		apiHeader.setToken(headers[2].substring(6));
//		apiHeader.setRole(headers[3].substring(5));
//		apiHeader.setAlgorithm(headers[4].substring(10));
//		apiHeader.setType(headers[5].substring(5));
	}

}
