package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.FileInfo;
import gaia3d.persistence.FileMapper;
import gaia3d.service.FileService;

@Service
public class FileServiceImpl implements FileService {
	@Autowired
	private FileService filService;
	
	@Autowired
	private FileMapper fileMapper;

	
	@Transactional(readOnly=true)
	public Long getFileTotalCount(FileInfo fileInfo) {
		return fileMapper.getFileTotalCount(fileInfo);
	}

	public List<FileInfo> getFileList(FileInfo fileInfo) {
		return fileMapper.getFileList(fileInfo);
	}

	@Transactional(readOnly=true)
	public FileInfo getFileInfo(Long fileInfoId) {
		return fileMapper.getFileInfo(fileInfoId);
	}
	
	public int insertFileInfo(FileInfo fileInfo) {
		return fileMapper.insertFileInfo(fileInfo);
	}

	@Transactional(readOnly=true)
	public int insertFiles(Long fileInfoId, FileInfo fileInfo) {
		insertFileInfo(fileInfo);
		
		return 0;
	}

	@Transactional(readOnly=true)
	public int updateFileInfo(FileInfo fileInfo) {
		return fileMapper.updateFileInfo(fileInfo);
	}

	@Transactional(readOnly=true)
	public int deleteFileInfo(Long fileInfoId) {
		return fileMapper.deleteFileInfo(fileInfoId);
	}

	@Transactional(readOnly=true)
	public int deleteFiles(String fileInfoIds) {
		String[] fileIds = fileInfoIds.split(".");
		for(String file_id : fileIds) {
			deleteFileInfo(Long.valueOf(file_id));
		}
		return fileInfoIds.length();
	}

	

	
}
