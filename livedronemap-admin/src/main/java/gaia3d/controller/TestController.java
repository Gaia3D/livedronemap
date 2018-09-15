package gaia3d.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/test/")
@Controller
public class TestController {

	@GetMapping("view")
	public String view1() {
		System.out.println("--------------------------------------------------test");
		
		return "/test/view";
	}
}
