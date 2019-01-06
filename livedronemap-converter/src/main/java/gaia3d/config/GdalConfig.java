package gaia3d.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Data;

@Data
@Configuration
@PropertySource("classpath:gdal.properties")
@ConfigurationProperties(prefix = "gdal")
public class GdalConfig {
	
	private String cmdPath;
	private String resultPath;
	private String serviceSrs;
	
	private String nearblackUse;
	private String nearblackOptions;
	
	private String warpUse;
	private String warpOptions;
	private String warpSourceSrs;
	
	private String translateUse;
	private String translateOptions;
	
	private String addoUse;
	private String addoOptions;
	private int addoLevel;
	
}	
