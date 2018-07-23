package gaia3d.controller;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import gaia3d.domain.FileInfo;
import gaia3d.service.FileService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileControllerTest {
	
	@Autowired
	FileService fileService;
	
	@Before
	public void fileInsert() {
		System.out.println("@Before: Insert 실행");
		FileInfo fileInfo = new FileInfo();
		fileInfo.setUser_id("uuuu");
		fileInfo.setJob_type("DATA_FILE_UPLOAD");
		fileInfo.setFile_name("file_10");
		fileInfo.setFile_real_name("file_1010101010");
		fileInfo.setFile_path("C:\\Users\\HJCHOI\\Desktop\\TEST\\file");
		fileInfo.setFile_size("610KB");
		fileInfo.setFile_ext("txt");
		fileService.insertFileInfo(fileInfo);
		FileInfo fileInfoResult = fileService.getFileInfo(fileInfo.getFile_info_id());
		System.out.println("@@ fileInfo: " + fileInfo);
		System.out.println("@@ insert- fileInfo: " + fileInfoResult);
	}
	

	@Test
	public void fileList() {
		FileInfo fileInfo = new FileInfo();
		
		List<FileInfo> fileList = new ArrayList<>();
		fileList = fileService.getFileList(fileInfo);
		log.info("@@@ fileInfo={}" + fileList);
		
	}

}
