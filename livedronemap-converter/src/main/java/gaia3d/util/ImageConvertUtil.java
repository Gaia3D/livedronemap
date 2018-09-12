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
@Slf4j
@Component
public class ImageConvertUtil {
	
	@Value("${gdal.cmd.path}")
	private String gdalCmdPath;
	
	@Autowired
	private ProcessRunner processRunner;
	
	/**
	 * Mago3D에서 서비스하는 EPSG:4326로 변환 
	 * @param srcImage 변환할 이미지 경로 
	 * @param targetImage 저장할 이미지 경로 
	 * @param srcSrs 젼환할 이미지 좌표계 
	 * @param targetSrs 저장할 이미지 좌표계 
	 * @param cmdOpt 기타 gdalwarp 옵션. 참고 : https://www.gdal.org/gdalwarp.html 
	 * @throws IOException 
	 * @throws InterruptedException 
	 */
	public void convertProjection(
			String srcImage, String targetImage, String srcSrs, String targetSrs, List<String> cmdOpt) 
					throws InterruptedException, IOException {
		log.info("Start gdalwarp .. {}", srcImage);
		checkFileExists(targetImage);
		
		Path cmdPath = Paths.get(gdalCmdPath, "gdalwarp");
		List<String> cmdList = new ArrayList<>();
		cmdList.add(cmdPath.toString());
		if (cmdOpt != null) {
			cmdList.addAll(cmdOpt);
		}
		
		cmdList.add("-s_srs");
		cmdList.add(srcSrs);
		cmdList.add("-t_srs");
		cmdList.add(targetSrs);
		cmdList.add(srcImage);
		cmdList.add(targetImage);
		
		processRunner.execProcess(cmdList);
		
	}
	
	// TODO 배경제거
	/**
	 * 배경을 제거하고 alpha 밴드 생성 
	 */
	public void removeBackgroud() {
		
	}
	
	/**
	 * 내부 타일 생성 
	 * @param srcImage 변환할 이미지 경로 
	 * @param targetImage 저장할 이미지 경로 
	 * @param cmdOpt 기타 gdal_translate 옵션. 참고 : https://www.gdal.org/gdal_translate.html
	 * @throws IOException 
	 * @throws InterruptedException 
	 */
	public void createInnerTile(String srcImage, String targetImage, List<String> cmdOpt) 
			throws InterruptedException, IOException {
		log.info("Start gdal_translate .. {}", srcImage);
		
		checkFileExists(targetImage);
		
		Path cmdPath = Paths.get(gdalCmdPath, "gdal_translate");
		List<String> cmdList = new ArrayList<>();
		cmdList.add(cmdPath.toString());
		if (cmdOpt != null) {
			cmdList.addAll(cmdOpt);
		}
		cmdList.add(srcImage);
		cmdList.add(targetImage);
		
		processRunner.execProcess(cmdList);
		
	}
	
	/**
	 * 오버뷰 생성 
	 * @param srcImage 변환할 이미지 경로 
	 * @param overviewLevel 
	 * @param cmdOpt 기타 gdaladdo 옵션. 참고 : https://www.gdal.org/gdaladdo.html
	 * @throws IOException 
	 * @throws InterruptedException 
	 */
	public void createOverview(String srcImage, int overviewLevel, List<String> cmdOpt) 
			throws InterruptedException, IOException {
		log.info("Start gdaladdo .. {}", srcImage);
		
		Path cmdPath = Paths.get(gdalCmdPath, "gdaladdo");
		List<String> cmdList = new ArrayList<>();
		cmdList.add(cmdPath.toString());
		if (cmdOpt != null) {
			cmdList.addAll(cmdOpt);
		}
		cmdList.add(srcImage);
		
		int initLevel = 2;
		for (int i = 1; i <= overviewLevel; i++) {
			cmdList.add(String.valueOf(initLevel));
			initLevel *= 2;
		}
		
		processRunner.execProcess(cmdList);
		
	}
	
	private void checkFileExists(String path) {
		File file = new File(path);
		
		// TODO 에러 처리 필요 
		if (file.exists()) {
			file.delete();
		}
		
	}
	
}
