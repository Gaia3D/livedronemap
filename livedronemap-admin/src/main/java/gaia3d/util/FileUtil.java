package gaia3d.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import gaia3d.domain.FileInfo;
import gaia3d.domain.Policy;
import lombok.extern.slf4j.Slf4j;

/**
 * TODO N중화 처리를 위해 FTP 로 다른 PM 으로 전송해 줘야 하는데....
 * 
 * 파일 처리 관련 Util
 * @author jeongdae
 *
 */
@Slf4j
public class FileUtil {

	// 디렉토리 생성 방법 
	public static final int SUBDIRECTORY_YEAR = 1;
	public static final int SUBDIRECTORY_YEAR_MONTH = 2;
	public static final int SUBDIRECTORY_YEAR_MONTH_DAY = 3;
	
	// 파일 copy 시 버퍼 사이즈
	public static final int BUFFER_SIZE = 8192;
	
	/**
	 * transfer data 
	 * @param subDirectoryType
	 * @param multipartFile
	 * @param policy
	 * @param directory
	 * @return
	 */
	public static FileInfo upload(int subDirectoryType, MultipartFile multipartFile, Policy policy, String directory) {
		// 파일 기본 validation 체크
		FileInfo fileInfo = fileValidation(multipartFile, policy);
		if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
			return fileInfo;
		}
		
		// 파일을 upload 디렉토리로 복사
		fileInfo = fileCopy(subDirectoryType, multipartFile, fileInfo, directory);
		
		return fileInfo;
	}
	
	/**
	 * 사용자 업로딩 파일에 대한 기본적인 validation 체크. 이름, 확장자, 사이즈
	 * @param multipartFile
	 * @param fileInfo
	 * @return
	 */
	private static FileInfo fileValidation(MultipartFile multipartFile, Policy policy) {
		
		FileInfo fileInfo = new FileInfo();
		// 1 파일 공백 체크
		if(multipartFile == null || multipartFile.getSize() == 0l) {
			log.info("@@ multipartFile is null");
			fileInfo.setError_code("fileinfo.invalid");
			return fileInfo;
		}
		
		// 2 파일 이름
		String fileName = multipartFile.getOriginalFilename();
		if(fileName.indexOf("..") >= 0 || fileName.indexOf("/") >= 0) {
			// TODO File.seperator 정규 표현식이 안 먹혀서 이렇게 처리함
			log.info("@@ fileName = {}", fileName);
			fileInfo.setError_code("fileinfo.name.invalid");
			return fileInfo;
		}
		
		// 3 파일 확장자
		String[] fileNameValues = fileName.split("\\.");
		if(fileNameValues.length != 2) {
			log.info("@@ fileNameValues.length = {}, fileName = {}", fileNameValues.length, fileName);
			fileInfo.setError_code("fileinfo.name.invalid");
			return fileInfo;
		}
		if(fileNameValues[0].indexOf(".") >= 0 || fileNameValues[0].indexOf("..") >= 0) {
			log.info("@@ fileNameValues[0] = {}", fileNameValues[0]);
			fileInfo.setError_code("fileinfo.name.invalid");
			return fileInfo;
		}
		// LowerCase로 비교
		String extension = fileNameValues[1];
		List<String> extList = new ArrayList<String>();
		if(policy.getUser_upload_type() != null && !"".equals(policy.getUser_upload_type())) {
			String[] uploadTypes = policy.getUser_upload_type().toLowerCase().split(",");
			extList = Arrays.asList(uploadTypes);
		}
		if(!extList.contains(extension.toLowerCase())) {
			log.info("@@ extList = {}, extension = {}", extList, extension);
			fileInfo.setError_code("fileinfo.ext.invalid");
			return fileInfo;
		}
		
		// 4 파일 사이즈
		// TODO data object attribute 파일은 사이즈가 커서 제한을 하지 않음
		long fileSize = multipartFile.getSize();
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ user upload file size = {} KB", (fileSize / 1000));
		if( fileSize > (policy.getUser_upload_max_filesize() * 1000000l)) {
			log.info("@@ fileSize = {}, user upload max filesize = {} M", (fileSize / 1000), policy.getUser_upload_max_filesize());
			fileInfo.setError_code("fileinfo.size.invalid");
			return fileInfo;
		}
		
		fileInfo.setFile_name(fileName);
		fileInfo.setFile_ext(extension);
		
		return fileInfo;
	}
	
	/**
	 * 파일 복사
	 * @param multipartFile
	 * @param fileInfo
	 * @param targetDirectory
	 * @return
	 */
	private static FileInfo fileCopy(int subDirectoryType, MultipartFile multipartFile, FileInfo fileInfo, String targetDirectory) {
		
		// 최상위 /upload/user/ 생성
		File rootDirectory = new File(targetDirectory);
		if(!rootDirectory.exists()) {
			rootDirectory.mkdir();
		}
		
		// 현재년 sub 디렉토리 생성
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14);
		String year = today.substring(0,4);
		String month = today.substring(4,6);
		String day = today.substring(6,8);
		String sourceDirectory = targetDirectory;
		
		if(subDirectoryType >= FileUtil.SUBDIRECTORY_YEAR) {
			File yearDirectory = new File(targetDirectory + year);
			if(!yearDirectory.exists()) {
				yearDirectory.mkdir();
			}
			sourceDirectory = targetDirectory + year + File.separator;
		}
		if(subDirectoryType >= FileUtil.SUBDIRECTORY_YEAR_MONTH) {
			File monthDirectory = new File(targetDirectory + year + File.separator + month);
			if(!monthDirectory.exists()) {
				monthDirectory.mkdir();
			}
			sourceDirectory = targetDirectory + year + File.separator + month + File.separator;
		}
		if(subDirectoryType >= FileUtil.SUBDIRECTORY_YEAR_MONTH_DAY) {
			File dayDirectory = new File(targetDirectory + year + File.separator + month + File.separator + day);
			if(!dayDirectory.exists()) {
				dayDirectory.mkdir();
			}
			sourceDirectory = targetDirectory + year + File.separator + month + File.separator + day + File.separator;
		}
		
		String saveFileName = today + "_" + System.nanoTime() + "." + fileInfo.getFile_ext();
		long size = 0L;
		try (	InputStream inputStream = multipartFile.getInputStream();
				OutputStream outputStream = new FileOutputStream(sourceDirectory + saveFileName)) {
		
			int bytesRead = 0;
			byte[] buffer = new byte[BUFFER_SIZE];
			while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
				size += bytesRead;
				outputStream.write(buffer, 0, bytesRead);
			}
		
			fileInfo.setFile_real_name(saveFileName);
			fileInfo.setFile_size(String.valueOf(size));
			fileInfo.setFile_path(sourceDirectory);
		} catch(Exception e) {
			e.printStackTrace();
			fileInfo.setError_code("fileinfo.copy.exception");
		}

		return fileInfo;
	}
	
	public static void deleteFile(String fileName) {
		File file = new File(fileName);
		if(file.exists()) {
			file.delete();
		}
	}
}