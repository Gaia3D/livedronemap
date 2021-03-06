package gaia3d.util;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import gaia3d.config.GdalConfig;
import gaia3d.domain.ImageInfo;
import gaia3d.service.GeoserverService;
import gaia3d.service.LogService;
import gaia3d.service.ProjectService;

@RunWith(SpringRunner.class)
@SpringBootTest
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ImageProcessingTest {
	
	@Autowired
	private GeoserverService geoserverService;
	@Autowired
	private LogService logService;
	@Autowired
	private ProjectService simulationService;
	@Autowired
	private GdalConfig gdalConfig;
	
	@Test
	public void test000ConvertProjection() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "sample.tif");
		String srcImg = targetPath.toAbsolutePath().toString();
		
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		ImageProcessing imageConvertUtil = new ImageProcessing(geoserverService, logService, simulationService, gdalConfig, imageInfo);
		imageConvertUtil.convertProjection(srcImg);
	}
	
	@Test
	public void test001CreateInnerTile() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "sample.tif");
		String srcImg = targetPath.toAbsolutePath().toString();
				
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		ImageProcessing imageConvertUtil = new ImageProcessing(geoserverService, logService, simulationService, gdalConfig, imageInfo);
		imageConvertUtil.createInnerTile(srcImg);
	}
	
	@Test
	public void test002CreateOverview() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "sample.tif");
		String srcImg = targetPath.toAbsolutePath().toString();
		
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		ImageProcessing imageConvertUtil = new ImageProcessing(geoserverService, logService, simulationService, gdalConfig, imageInfo);
		imageConvertUtil.createOverview(srcImg);
	}
	
	@Test
	public void test003RemoveBackground() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "sample.tif");
		String srcImg = targetPath.toAbsolutePath().toString();
		
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		ImageProcessing imageConvertUtil = new ImageProcessing(geoserverService, logService, simulationService, gdalConfig, imageInfo);
		imageConvertUtil.removeBackground(srcImg);
	}
	
	@Test
	@Ignore
	public void testConvertImage() throws InterruptedException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "sample.tif");
		String srcImg = targetPath.toAbsolutePath().toString();
//		String srcImg = "/Users/jskim/macDATA/data/ldm/marine_surveillance_2.tif";
		
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		Runnable imageConvertUtil = new ImageProcessing(geoserverService, logService, simulationService, gdalConfig, imageInfo);
		Thread thread = new Thread(imageConvertUtil);
		thread.start();
		
		thread.join();
	}

}
