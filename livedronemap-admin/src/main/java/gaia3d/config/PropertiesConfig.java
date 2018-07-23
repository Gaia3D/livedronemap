package gaia3d.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Data;

@Data
@Configuration
@PropertySource("classpath:livedrone.properties")
@ConfigurationProperties(prefix = "livedrone")
public class PropertiesConfig {

//	private String osType;
//	private boolean callRemoteEnable;
//	private String serverIp;
//	private String restAuthKey;
//	
//	private String licenseFile;
//	private String licenseFileChecker;
	

	// 파일 업로드 폴더
	private String sampleUploadDir;
	
}
