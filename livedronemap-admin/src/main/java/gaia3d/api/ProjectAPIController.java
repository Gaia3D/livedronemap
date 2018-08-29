package gaia3d.api;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/project")
@RestController
public class ProjectAPIController {

	@PostMapping
	public String createToken() {
		// /auth/xxx
		
		return "";
	}
	
	@PutMapping
	public String refreshToken() {
		return "";
	}
	
}
