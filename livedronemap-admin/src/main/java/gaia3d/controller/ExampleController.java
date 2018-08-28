package gaia3d.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/hello")
@Controller
public class ExampleController {

	@GetMapping("/world")
	@ResponseBody
	public String hello() {
		System.out.println("--------------------------------------------------test");
		
		return "/test";
	}
}
