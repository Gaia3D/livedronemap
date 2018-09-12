package gaia3d.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Configuration
@PropertySource("classpath:gdal.properties")
public class GdalConfig {
	
	@Value("${gdal.cmd.path}")
	private String gdalCmdPath;
	@Value("${gdal.result.path}")
	private String gdalResultPath;
	@Value("${gdal.service.srs}")
	private String gdalServiceSrs;
	
	@Value("${gdal.warp.options}")
	private String gdalWarpOptions;
	@Value("${gdal.warp.source.srs}")
	private String gdalWarpSourceSrs;
	
	@Value("${gdal.translate.options}")
	private String gdalTranslateOptions;
	
	@Value("${gdal.addo.options}")
	private String gdalAddoOptions;
	@Value("${gdal.addo.level}")
	private int gdalAddoLevel;
	
}	
