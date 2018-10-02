package gaia3d.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Data;

@Data
@Configuration
@PropertySource("classpath:api-server.properties")
@ConfigurationProperties(prefix = "api")
public class APIServerConfig {
	
	private String rootUrl;
	
}
