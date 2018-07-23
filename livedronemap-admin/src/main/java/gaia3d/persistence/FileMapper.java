package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.FileInfo;

@Repository
public interface FileMapper {

	// 파일 총 건수
	Long getFileTotalCount(FileInfo fileInfo);
	
	// 파일 목록
	List<FileInfo> getFileList(FileInfo fileInfo);
	
	// 파일 정보
	FileInfo getFileInfo(Long fileInfoId);
	
	// 파일 등록
	int insertFileInfo(FileInfo fileInfo);
	
	// 파일 일괄 등록
	int insertFiles(Long fileInfoId, FileInfo fileInfo);
	
	// 파일 정보 수정
	int updateFileInfo(FileInfo fileInfo);
	
	// 파일 삭제
	int deleteFileInfo(Long fileInfoId);
	
	// 파일 일괄 삭제
	int deleteFiles(String fileInfoIds);
	
}
