package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.FileInfo;
import gaia3d.domain.UploadLog;
import gaia3d.persistence.UploadMapper;
import gaia3d.service.UploadService;

@Service
public class UploadServiceImpl implements UploadService {
	
	@Autowired
	private UploadMapper uploadMapper;
	
	/**
	 * 사용자가 업로드 완료한 파일 총 건수
	 * @param uploadLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getListUploadLogTotalCount(UploadLog uploadLog) {
		return uploadMapper.getListUploadLogTotalCount(uploadLog);
	}
	
	/**
	 * 사용자가 업로드 완료한 파일 목록
	 * @param uploadLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UploadLog> getListUploadLog(UploadLog uploadLog) {
		return uploadMapper.getListUploadLog(uploadLog);
	}
	
	/**
	 * 사용자가 업로딩한 파일 목록을 저장
	 * @param fileList
	 */
	@Transactional
	public void insertFiles(List<FileInfo> fileList) {
		for(FileInfo fileInfo : fileList) {
			uploadMapper.insertFileInfo(fileInfo);
		}
	}
}
