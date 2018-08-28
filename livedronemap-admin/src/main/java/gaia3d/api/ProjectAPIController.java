package gaia3d.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/project")
@RestController
public class ProjectAPIController {

	@PostMapping
	public String createToken() {
		//http://bcho.tistory.com/999
		//http://alwayspr.tistory.com/8
		return "";
	}
	
}
