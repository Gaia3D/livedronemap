package gaia3d.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Data;

@Data
@Configuration
@PropertySource("classpath:livedronemap.properties")
@ConfigurationProperties(prefix = "livedronemap")
public class PropertiesConfig {

//	private String osType;
//	private boolean callRemoteEnable;
//	private String serverIp;
//	private String restAuthKey;
	
	// transfer data
	private String orthoImageDir;
	private String postprocessingImageDir;
	
}
