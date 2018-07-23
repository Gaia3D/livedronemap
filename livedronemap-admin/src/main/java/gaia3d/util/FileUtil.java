package gaia3d.util;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUtil {
	
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws IOException {
		UUID uid = UUID.randomUUID();

		String savedName = uid.toString() + "_" + originalName;
		
		String savedPath = calcPath(uploadPath);

		File target = new File(uploadPath + savedPath, savedName);

		FileCopyUtils.copy(fileData, target);
		
		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
		log.info("@@ formatName : " + formatName);
		
		String uploadedFileName = makeIcon(uploadPath, savedPath, savedName); 
		
		return uploadedFileName;
	}

	private static String makeIcon(String uploadPath, String path, String fileName) throws IOException {
		String iconName = uploadPath + path + File.separator + fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		log.info("@@@ yearPath" + yearPath);
		
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		log.info("@@@ monthPath" + monthPath);
		
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		log.info("@@@ datePath" + datePath);

		makeDir(uploadPath, yearPath, monthPath, datePath);
		log.info("@@@ makeDir - datePath" + datePath);
		
		return datePath;
	}

	private static void makeDir(String uploadPath, String ... paths) {
		if(new File(uploadPath + paths[paths.length -1]).exists()) {
			return;
		}
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			
			if(! dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
}
