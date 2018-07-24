package gaia3d.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.FileInfo;

@RestController
@RequestMapping(value="/cors/")
public class CorsController {
	
//	@CrossOrigin
	@GetMapping("/admin")
	public FileInfo fileInfo() {
		FileInfo fileInfo = new FileInfo();
		fileInfo.setError_code("TEST_ERROR");
		fileInfo.setFile_name("TEST_FILE");
		return fileInfo;
	}

	
}
