package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.FileInfo;

@Repository
public interface FileMapper {
	
	/**
	 * 파일 정보 획득
	 * @param file_info_id
	 * @return
	 */
	FileInfo getFileInfo(Long file_info_id);
	
	/**
	 * 파일 정보 등록
	 * @param fileInfo
	 * @return
	 */
	int insertFileInfo(FileInfo fileInfo);
	
	/**
	 * 파일 정보 수정
	 * @param fileInfo
	 * @return
	 */
	int updateFileInfo(FileInfo fileInfo);
	
}
