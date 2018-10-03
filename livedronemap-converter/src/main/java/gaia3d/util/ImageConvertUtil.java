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
import org.geotools.coverage.grid.GridCoverage2D;
import org.geotools.coverage.grid.io.AbstractGridCoverage2DReader;
import org.geotools.coverage.grid.io.AbstractGridFormat;
import org.geotools.factory.Hints;
import org.geotools.gce.geotiff.GeoTiffFormat;
import org.geotools.geometry.Envelope2D;
import org.geotools.referencing.CRS;
import org.opengis.referencing.FactoryException;
import org.opengis.referencing.NoSuchAuthorityCodeException;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.HttpClientErrorException;

import gaia3d.config.GdalConfig;
import gaia3d.domain.APIResult;
import gaia3d.domain.ImageInfo;
import gaia3d.domain.ImageMosaic;
import lombok.extern.slf4j.Slf4j;

/**
 * 이미지 변환 using GDAL Command
 * @author jskim
 *
 * TODO JAVA GDAL 라이브러리로 대체 또는 GeoTools 사용 
 */
@Slf4j
public class ImageConvertUtil implements Runnable {
	
	private final static String PROCESS_USE_FLAG = "true";
	
	private APIUtil aPIUtil;
	
	private GdalConfig gdalConfig;
	
	private ImageInfo imageInfo;
	
	public ImageConvertUtil(APIUtil aPIUtil, GdalConfig gdalConfig, ImageInfo imageInfo) {
		this.aPIUtil = aPIUtil;
		this.gdalConfig = gdalConfig;
		this.imageInfo = imageInfo;
	}
	
	public void run() {
		String sourceImage = imageInfo.getImagePath();
		String sourceName = FilenameUtils.getBaseName(sourceImage);
		
		try {
			// TODO 단계별로 진행 여부 필요, properties로 관리할지 파일별로 플레그를 둘지 고려 필요 
			if (gdalConfig.getNearblackUse().equals(PROCESS_USE_FLAG)) {
				sourceImage = removeBackgroud(sourceImage);
			}
			if (gdalConfig.getWarpUse().equals(PROCESS_USE_FLAG)) {
				sourceImage = convertProjection(sourceImage);
			}
			if (gdalConfig.getTranslateUse().equals(PROCESS_USE_FLAG)) {
				sourceImage = createInnerTile(sourceImage);
			}
			if (gdalConfig.getAddoUse().equals(PROCESS_USE_FLAG)) {
				sourceImage = createOverview(sourceImage);
			}
			
			// TODO 원본은 남기고, 중간 결과 이미지 삭제 
			
			// 최종 결과물 이동
			String resultImagePath = moveResultImage(sourceName, sourceImage);
			
			// Geoserver 영상 등록 호출 
			ImageMosaic imageMosaic = new ImageMosaic();
			String imageName = FilenameUtils.getName(resultImagePath);
			Integer projectId = imageInfo.getProjectId();
			String location = String.format("%d/%s", projectId, imageName);
			imageMosaic.setLocation(location);
			String theGeom = getImageBoundaryAsWKT(resultImagePath);
			if (theGeom == null) {
				throw new NullPointerException("Occur a error to get wkt.");
			}
			imageMosaic.setThe_geom(theGeom);
			imageMosaic.setImage_dt(imageInfo.getImageDt());
			imageMosaic.setProject_id(projectId);
			
			ResponseEntity<APIResult> insertResult = aPIUtil.insertImageInfoForGeoServer(imageMosaic);
			log.info("@@@ {}", insertResult.getStatusCode());
			
			try {
				ResponseEntity<APIResult> checkResult = aPIUtil.checkGeoServerInfo(projectId);
				log.info("@@@ {}", checkResult.getStatusCode());
			} catch (HttpClientErrorException e) {
				ResponseEntity<APIResult> createResult = aPIUtil.createLayer(imageMosaic);
				log.info("@@@ {}", createResult.getStatusCode());
			}

		} catch (Exception e) {
			// TODO 결과 저장하는 API 호출 
			e.printStackTrace();
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
	
	/**
	 * 배경을 제거하고 alpha 밴드 생성 
	 * @throws IOException 
	 * @throws InterruptedException 
	 */
	public String removeBackgroud(String sourceImage) throws InterruptedException, IOException {
		log.info("Start nearblack .. {}", sourceImage);
		
		// TODO 확장자는 동적으로 처리 
		String targetImage = getTargetPath(sourceImage, "nb", "tif");
		checkFileExists(targetImage);
		
		Path cmdPath = Paths.get(gdalConfig.getCmdPath(), "nearblack");
		List<String> cmdList = new ArrayList<>();
		cmdList.add(cmdPath.toString());
		
		List<String> cmdOpt = Arrays.asList(gdalConfig.getNearblackOptions().split(","));
		if (cmdOpt != null) {
			cmdList.addAll(cmdOpt);
		}
		
		cmdList.add("-o");
		cmdList.add(targetImage);
		cmdList.add(sourceImage);
		
		ProcessRunner processRunner = new ProcessRunner();
		processRunner.execProcess(cmdList);
		
		return targetImage;
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
	
	/**
	 * 최종 변환 이미지 이동 
	 * @param sourceName
	 * @param sourceImage
	 * @return
	 * @throws IOException 
	 */
	private String moveResultImage(String sourceName, String resultImage) throws IOException {
		// 최종 이미지 결과
		Path resultFilePath = Paths.get(resultImage);
		
		// geoserver 등록 이미지 경로
		Path geoserverDirectoryPath = Paths.get(gdalConfig.getResultPath());
		geoserverDirectoryPath = geoserverDirectoryPath.resolve(String.valueOf(imageInfo.getProjectId()));
		checkDirectoryExists(geoserverDirectoryPath.toString());
		
		Path geoserverImageFilePath = geoserverDirectoryPath.resolve(String.format("%s.tif", sourceName));
		checkFileExists(geoserverImageFilePath.toString());
	
		Files.move(resultFilePath, geoserverImageFilePath);

		return geoserverImageFilePath.toString();
	}
	
	/**
	 * 이미지의 바운더리를 구함 
	 * @param image
	 * @return
	 * @throws NoSuchAuthorityCodeException
	 * @throws FactoryException
	 * @throws IllegalArgumentException
	 * @throws IOException
	 */
	private String getImageBoundaryAsWKT(String image) {
		String wkt = null;
		
		File imageFile = new File(image);
		
		AbstractGridCoverage2DReader abstractGridCoverage2DReader = null;
		Envelope2D envelope2D = null;
		try {
			CoordinateReferenceSystem coordinateReferenceSystem = CRS.decode("EPSG:4326");
			Hints hint = new Hints();
			hint.put(Hints.DEFAULT_COORDINATE_REFERENCE_SYSTEM, coordinateReferenceSystem);    
			hint.put(Hints.FORCE_LONGITUDE_FIRST_AXIS_ORDER, Boolean.TRUE);
			AbstractGridFormat abstractGridFormat = new GeoTiffFormat();
			
			abstractGridCoverage2DReader = abstractGridFormat.getReader(imageFile, hint);
			GridCoverage2D gridCoverage2D = abstractGridCoverage2DReader.read(null);
			envelope2D = gridCoverage2D.getEnvelope2D();
			wkt = String.format("POLYGON((%1$f %2$f, %1$f %4$f, %3$f %4$f, %3$f %2$f, %1$f %2$f))", 
					envelope2D.getMinX(), envelope2D.getMinY(), envelope2D.getMaxX(), envelope2D.getMaxY());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			abstractGridCoverage2DReader.dispose();
		}
		
		return wkt;
	}
	
	/**
	 * 파일 있는지 확인. 있으면 지움 
	 * @param path
	 */
	private void checkFileExists(String path) {
		File file = new File(path);
		// TODO 에러 처리 필요 
		if (file.exists()) {
			file.delete();
		}
	}
	
	/**
	 * 폴더 있는지 확인. 없으면 지움  
	 * @param path
	 */
	private void checkDirectoryExists(String path) {
		File directory = new File(path);
		// TODO 에러 처리 필요 
		if (!directory.exists()) {
			directory.mkdirs();
		}
	}
	
}
