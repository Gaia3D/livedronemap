package gaia3d.config;

import java.util.Properties;

import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.core.Ordered;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@EnableWebMvc
@Configuration
@ComponentScan(basePackages = { "gaia3d.config, gaia3d.controller, gaia3d.interceptor, gaia3d.validator" }, 
includeFilters = {
		@Filter(type = FilterType.ANNOTATION, value = Component.class),
		@Filter(type = FilterType.ANNOTATION, value = Controller.class),
		@Filter(type = FilterType.ANNOTATION, value = RestController.class)})
public class ServletConfig {
	
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }
    
//    @Override
//    public void addViewControllers(ViewControllerRegistry registry) {
//        registry.addViewController("/").setViewName("forward:/index.jsp");
//        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
//        super.addViewControllers(registry);
//    }
    
    @Bean
	@ConditionalOnMissingBean(InternalResourceViewResolver.class)
	public InternalResourceViewResolver viewResolver() {
		log.info(" @@@ ServletConfig viewResolver @@@");
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views");
		viewResolver.setSuffix(".jsp");
		viewResolver.setOrder(3);
		
		return viewResolver;
	}

}
