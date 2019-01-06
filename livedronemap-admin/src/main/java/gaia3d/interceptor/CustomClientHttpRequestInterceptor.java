package gaia3d.interceptor;

import java.io.IOException;

import org.springframework.http.HttpRequest;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpResponse;

import lombok.extern.slf4j.Slf4j;

/**
 * interceptor to log incoming requests
 */
@Slf4j
public class CustomClientHttpRequestInterceptor implements ClientHttpRequestInterceptor {

	@Override
	public ClientHttpResponse intercept(HttpRequest request, byte[] body, ClientHttpRequestExecution execution) throws IOException {
		log.info("@@@@@@ Headers = {}", request.getHeaders());
		log.info("@@@@@@ URI = {}, Method = {}", request.getURI(), request.getMethod());
		return execution.execute(request, body);
	}
}