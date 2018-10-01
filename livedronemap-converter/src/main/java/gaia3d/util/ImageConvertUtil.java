package gaia3d.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FilenameUtils;

import gaia3d.config.GdalConfig;
import gaia3d.domain.ImageInfo;
import lombok.extern.slf4j.Slf4j;

/**
 * 이미지 변환 using GDAL Command
 * @author jskim
 *
 * TODO JAVA GDAL 라이브러리로 대체 또는 GeoTools 사용 
 */
@Slf4j
public class ImageConvertUtil implements Runnable {
	
	private GdalConfig gdalConfig;
	
	private ImageInfo imageInfo;
	
	// TODO 이렇게 하는게 맞나 .. ?!
	public ImageConvertUtil(GdalConfig gdalConfig, ImageInfo imageInfo) {
		this.gdalConfig = gdalConfig;
		this.imageInfo = imageInfo;
	}
	
	@Override
	public void run() {
		String soureceImage = imageInfo.getImagePath();
		String soureceName = FilenameUtils.getBaseName(soureceImage);
		
		try {
			// TODO 단계별로 진행 여부 필요, properties로 관리할지 파일별로 플레그를 둘지 고려 필요 
			soureceImage = convertProjection(soureceImage);
			soureceImage = createInnerTile(soureceImage);
			soureceImage = createOverview(soureceImage);
			
			// TODO 중간 결과 이미지 삭제 
			
			// 최종 결과물 이동
			Path completeFilePath = Paths.get(soureceImage);
			Path resultDirectoryPath = Paths.get(gdalConfig.getResultPath());
			resultDirectoryPath = resultDirectoryPath.resolve(String.valueOf(imageInfo.getProjectId()));
			
			File resultDirectory = resultDirectoryPath.toFile();
			if (!resultDirectory.exists()) {
				resultDirectory.mkdirs();
			}
			
			Path resultFilePath = resultDirectoryPath.resolve(String.format("%s.tif", soureceName));
			File resultFile = resultFilePath.toFile();
			
			if (resultFile.exists()) {
				resultFile.delete();
			}
			
			Files.move(completeFilePath, resultFilePath);
			
			// Geoserver 영상 등록 호출 
			
			
		} catch (InterruptedException | IOException e) {
			// TODO 결과 저장하는 API 호출 
			log.warn("", e);
		}
		
	}
	
	/**
	 * Mago3D에서 서비스하는 EPSG:4326로 변환 
	 * @param sourceImage 변환할 이미지 경로 
	 * @return 변환된 이미지 경로 
	 * @throws IOException 
	 * @throws InterruptedException 
	 */
	public String convertProjection(String sourceImage) throws InterruptedException, IOException {
		log.info("Start gdalwarp .. {}", sourceImage);
		
		// TODO 확장자는 동적으로 처리 
		String targetImage = getTargetPath(sourceImage, "warp", "tif");
		checkFileExists(targetImage);
		
		Path cmdPath = Paths.get(gdalConfig.getCmdPath(), "gdalwarp");
		List<String> cmdList = new ArrayList<>();
		cmdList.add(cmdPath.toString());
		
		List<String> cmdOpt = Arrays.asList(gdalConfig.getWarpOptions().split(","));
		if (cmdOpt.size() > 0) {
			cmdList.addAll(cmdOpt);
		}
		
		cmdList.add("-s_srs");
		cmdList.add(gdalConfig.getWarpSourceSrs());
		cmdList.add("-t_srs");
		cmdList.add(gdalConfig.getServiceSrs());
		cmdList.add(sourceImage);
		cmdList.add(targetImage);
		
		ProcessRunner processRunner = new ProcessRunner();
		processRunner.execProcess(cmdList);
		
		return targetImage;
		
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
	 * @return 변환된 이미지 경로 
	 * @throws IOException 
	 * @throws InterruptedException 
	 * 
	 */
	public String createInnerTile(String sourceImage) throws InterruptedException, IOException {
		log.info("Start gdal_translate .. {}", sourceImage);
		
		// TODO 확장자는 동적으로 처리 
		String targetImage = getTargetPath(sourceImage, "tiled", "tif");
		checkFileExists(targetImage);
		
		Path cmdPath = Paths.get(gdalConfig.getCmdPath(), "gdal_translate");
		List<String> cmdList = new ArrayList<>();
		cmdList.add(cmdPath.toString());
		
		List<String> cmdOpt = Arrays.asList(gdalConfig.getTranslateOptions().split(","));
		if (cmdOpt != null) {
			cmdList.addAll(cmdOpt);
		}
		cmdList.add(sourceImage);
		cmdList.add(targetImage);
		
		ProcessRunner processRunner = new ProcessRunner();
		processRunner.execProcess(cmdList);
		
		return targetImage;
		
	}
	
	/**
	 * 오버뷰 생성 
	 * @param srcImage 변환할 이미지 경로 
	 * @return 변환된 이미지 경로 
	 * @throws IOException 
	 * @throws InterruptedException 
	 * 
	 */
	public String createOverview(String sourceImage) throws InterruptedException, IOException {
		log.info("Start gdaladdo .. {}", sourceImage);
		
		Path cmdPath = Paths.get(gdalConfig.getCmdPath(), "gdaladdo");
		List<String> cmdList = new ArrayList<>();
		cmdList.add(cmdPath.toString());
		
		List<String> cmdOpt = Arrays.asList(gdalConfig.getAddoOptions().split(","));
		if (cmdOpt != null) {
			cmdList.addAll(cmdOpt);
		}
		cmdList.add(sourceImage);
		
		int initLevel = 2;
		int overviewLevel = gdalConfig.getAddoLevel();
		for (int i = 1; i <= overviewLevel; i++) {
			cmdList.add(String.valueOf(initLevel));
			initLevel *= 2;
		}
		
		ProcessRunner processRunner = new ProcessRunner();
		processRunner.execProcess(cmdList);
		
		return sourceImage;
		
	}
	
	/**
	 * 저장할 이미지 경로 생성 
	 * @param sourcePath 원본 경로 
	 * @param suffix 파일명 뒤에 붙일 suffix
	 * @param extension 확장자 
	 * @return 저장할 이미지 경로
	 * 
	 */
	private String getTargetPath(String sourcePath, String suffix, String extension) {
		String soureceBaseName = FilenameUtils.getBaseName(sourcePath);
		String targetName = String.format("%s_%s.%s", soureceBaseName, suffix, extension);
		
		String soureceDirectory = FilenameUtils.getFullPathNoEndSeparator(sourcePath);
		
		Path targetPath = Paths.get(soureceDirectory, targetName);
		return targetPath.toString();
	}
	
	private void checkFileExists(String path) {
		File file = new File(path);
		
		// TODO 에러 처리 필요 
		if (file.exists()) {
			file.delete();
		}
		
	}
	
}
