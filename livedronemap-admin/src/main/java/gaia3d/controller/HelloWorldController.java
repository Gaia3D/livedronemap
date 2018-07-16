package gaia3d.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hello/")
public class HelloWorldController {
	
	@GetMapping("world")
	public String hello() {
		log.info("Hello!!");
		return "/hello/hello";
	}
	
	
}
