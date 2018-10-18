package gaia3d.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gaia3d.domain.CacheManager;
import gaia3d.domain.Policy;
import gaia3d.security.Crypt;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/monitoring/")
public class MonitoringController {
	
	@GetMapping(value = "list-simulation")
	public String listSimulation(Model model) {
		
		return "/monitoring/list-simulation";
	}
	
	@GetMapping(value = "list-health-check")
	public String listHealthCheck(Model model) {
		
		return "/monitoring/list-health-check";
	}
}
