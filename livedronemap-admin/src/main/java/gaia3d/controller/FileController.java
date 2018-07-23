package gaia3d.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.FileInfo;
import gaia3d.service.FileService;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RestController
@RequestMapping("/file/")
public class FileController {
	
	@Autowired
	PropertiesConfig propertiesConfig;
	
	@Autowired
	FileService fileService;
	
	@GetMapping("/listFile")
	public List<FileInfo> listFil(FileInfo fileInfo){
		List<FileInfo> fileList = new ArrayList<>();
		fileList = fileService.getFileList(fileInfo);
		
		return fileList;
	}
	
	@PostMapping("/uploadFile")
	public FileInfo uploadFile(@RequestParam("file") MultipartFile file) throws IOException {
		// 파일 
		
		return null;
		
	}
	
	
}



















