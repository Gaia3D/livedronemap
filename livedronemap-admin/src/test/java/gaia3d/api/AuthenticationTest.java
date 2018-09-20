package gaia3d.api;

import static org.junit.Assert.*;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.client.RestOperations;
import org.springframework.web.client.RestTemplate;

public class AuthenticationTest {

	@Test
	public void restTemplate() {
		RestTemplate restTemplate = getRestTemplate();
		//restTemplate.getForEntity("http://localhost/authentication/list-drone-project", responseType, uriVariables)
	}
	
	
	private RestTemplate getRestTemplate() {
//		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
//		factory.setReadTimeout(5000); // 읽기시간초과, ms 
//		factory.setConnectTimeout(3000); // 연결시간초과, ms 
//		HttpClient httpClient = HttpClientBuilder.create()
//				.setMaxConnTotal(100) // connection pool 적용 
//				.setMaxConnPerRoute(5) // connection pool 적용 
//				.build(); 
//		factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅 
//		RestTemplate restTemplate = new RestTemplate(factory);

		
		SimpleClientHttpRequestFactory simpleClientHttpRequestFactory = new SimpleClientHttpRequestFactory();
		simpleClientHttpRequestFactory.setConnectTimeout(5000);
		simpleClientHttpRequestFactory.setReadTimeout(3000);
		
		RestTemplate restTemplate = new RestTemplate(simpleClientHttpRequestFactory);
		return restTemplate;
	}

}
