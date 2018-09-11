package gaia3d.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

/**
 * 이미지 변환 using GDAL Command
 * @author jskim
 *
 */
@Component
@Slf4j
public class ImageConvertUtil {
	
	@Value("${gdal.cmd.path}")
	private String gdalCmdPath;
	
	@Autowired
	private ProcessRunner processRunner;
	
	/**
	 * Mago3D에서 서비스하는 EPSG:4326로 변환 
	 * @param srcImg 변환할 이미지 경로 
	 * @param targetImg 저장할 이미지 경로 
	 * @param srcSrs 젼환할 이미지 좌표계 
	 * @param targetSrs 저장할 이미지 좌표계 
	 * @param cmdOpt 기타 gdalwarp 옵션. 참고 : https://www.gdal.org/gdalwarp.html 
	 */
	public void convertProjection(
			String srcImg, String targetImg, String srcSrs, String targetSrs, List<String> cmdOpt) {
		log.info("Start gdalwarp .. {}", srcImg);
		checkFileExists(targetImg);
		
		List<String> cmdList = new ArrayList<>();
		
		Path cmdPath = Paths.get(gdalCmdPath, "gdalwarp");
		
		cmdList.add(cmdPath.toString());
		
		if (cmdOpt != null) {
			cmdList.addAll(cmdOpt);
		}
		
		cmdList.add("-s_srs");
		cmdList.add(srcSrs);
		
		cmdList.add("-t_srs");
		cmdList.add(targetSrs);
		
		cmdList.add(srcImg);
		cmdList.add(targetImg);
		
		try {
			processRunner.execProcess(cmdList);
		} catch (InterruptedException | IOException e) {
			e.printStackTrace();
		}
		
	}
	
	// TODO 배경제거
	/**
	 * 배경을 제거하고 alpha 밴드 생성 
	 */
	public void removeBackgroud() {
		
	}
	
	/**
	 * 내부 타일 생성 
	 * @param srcImg 변환할 이미지 경로 
	 * @param targetImg 저장할 이미지 경로 
	 * @param cmdOpt 기타 gdal_translate 옵션. 참고 : https://www.gdal.org/gdal_translate.html
	 */
	public void createInnerTile(String srcImg, String targetImg, List<String> cmdOpt) {
		log.info("Start gdal_translate .. {}", srcImg);
		
		checkFileExists(targetImg);
		
		List<String> cmdList = new ArrayList<>();
		
		Path cmdPath = Paths.get(gdalCmdPath, "gdal_translate");
		
		cmdList.add(cmdPath.toString());
		
		if (cmdOpt != null) {
			cmdList.addAll(cmdOpt);
		}
		
		cmdList.add(srcImg);
		cmdList.add(targetImg);
		
		try {
			processRunner.execProcess(cmdList);
		} catch (InterruptedException | IOException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 오버뷰 생성 
	 * @param srcImg 변환할 이미지 경로 
	 * @param overviewLevel 
	 * @param cmdOpt 기타 gdaladdo 옵션. 참고 : https://www.gdal.org/gdaladdo.html
	 */
	public void createOverview(String srcImg, int overviewLevel, List<String> cmdOpt) {
		log.info("Start gdaladdo .. {}", srcImg);
		
		List<String> cmdList = new ArrayList<>();
		
		Path cmdPath = Paths.get(gdalCmdPath, "gdaladdo");
		
		cmdList.add(cmdPath.toString());
		
		if (cmdOpt != null) {
			cmdList.addAll(cmdOpt);
		}
		
		cmdList.add(srcImg);
		
		int initLevel = 2;
		for (int i = 1; i <= overviewLevel; i++) {
			cmdList.add(String.valueOf(initLevel));
			initLevel *= 2;
		}
		
		try {
			processRunner.execProcess(cmdList);
		} catch (InterruptedException | IOException e) {
			e.printStackTrace();
		}
		
	}
	
	private void checkFileExists(String path) {
		File file = new File(path);
		
		if (file.exists()) {
			file.delete();
		}
		
	}
	
}
