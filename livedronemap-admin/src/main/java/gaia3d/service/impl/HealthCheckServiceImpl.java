package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;

import gaia3d.config.RestTemplateResponseErrorHandler;
import gaia3d.service.HealthCheckService;

public class HealthCheckServiceImpl implements HealthCheckService {

	@Autowired
	private RestTemplateBuilder restTemplateBuilder;
	@Autowired
	private RestTemplateResponseErrorHandler restTemplateResponseErrorHandler;
}
