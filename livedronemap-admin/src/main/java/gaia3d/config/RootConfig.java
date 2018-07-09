package gaia3d.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.FilterType;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import gaia3d.config.RootConfig;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
//@MapperScan("gaia3d.persistence")
@ComponentScan(	basePackages = {"gaia3d.service, gaia3d.persistence"},
includeFilters = {	@Filter(type = FilterType.ANNOTATION, value = Component.class),
					@Filter(type = FilterType.ANNOTATION, value = Service.class),
					@Filter(type = FilterType.ANNOTATION, value = Repository.class) },
excludeFilters = @Filter(type = FilterType.ANNOTATION, value = Controller.class) )
public class RootConfig {
	
	

}
