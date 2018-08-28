package gaia3d.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/project")
@RestController
public class ProjectAPIController {

	@GetMapping
	public String getToken() {
		//http://bcho.tistory.com/999
		//http://alwayspr.tistory.com/8
		return "";
	}
	
}
