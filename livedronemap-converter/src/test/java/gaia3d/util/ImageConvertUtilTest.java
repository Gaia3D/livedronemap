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

@RunWith(SpringRunner.class)
@SpringBootTest
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
//@TestPropertySource("classpath:gdal.properties")
public class ImageConvertUtilTest {
	
	@Autowired
	private APIUtil aPIUtil;
	@Autowired
	private GdalConfig gdalConfig;
	
	@Test
	@Ignore
	public void test000ConvertProjection() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "DJI_0064.png");
		String srcImg = targetPath.toAbsolutePath().toString();
//		String srcImg = "/Users/jskim/macDATA/data/ldm/marine_surveillance_1_nb.tif";
		
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		ImageConvertUtil imageConvertUtil = new ImageConvertUtil(aPIUtil, gdalConfig, imageInfo);
		imageConvertUtil.convertProjection(srcImg);
	}
	
	@Test
	@Ignore
	public void test001CreateInnerTile() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "DJI_0064_warp.tif");
		String srcImg = targetPath.toAbsolutePath().toString();
//		String srcImg = "/Users/jskim/macDATA/data/ldm/marine_surveillance_1_nb_warp.tif";
				
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		ImageConvertUtil imageConvertUtil = new ImageConvertUtil(aPIUtil, gdalConfig, imageInfo);
		imageConvertUtil.createInnerTile(srcImg);
	}
	
	@Test
	@Ignore
	public void test002CreateOverview() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "DJI_0064_warp_tiled.tif");
		String srcImg = targetPath.toAbsolutePath().toString();
//		String srcImg = "/Users/jskim/macDATA/data/ldm/marine_surveillance_1_nb_warp_tiled.tif";
		
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		ImageConvertUtil imageConvertUtil = new ImageConvertUtil(aPIUtil, gdalConfig, imageInfo);
		imageConvertUtil.createOverview(srcImg);
	}
	
	@Test
	@Ignore
	public void test003RemoveBackground() throws InterruptedException, IOException {
		String srcImg = "/Users/jskim/macDATA/data/ldm/marine_surveillance_1.tif";
		
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		ImageConvertUtil imageConvertUtil = new ImageConvertUtil(aPIUtil, gdalConfig, imageInfo);
		imageConvertUtil.removeBackgroud(srcImg);
	}
	
	@Test
	@Ignore
	public void testConvertImage() throws InterruptedException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "DJI_0064.png");
		String srcImg = targetPath.toAbsolutePath().toString();
//		String srcImg = "/Users/jskim/macDATA/data/ldm/marine_surveillance_2.tif";
		
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(1);
		imageInfo.setImageId(1L);
		imageInfo.setImagePath(srcImg);
		
		Runnable imageConvertUtil = new ImageConvertUtil(aPIUtil, gdalConfig, imageInfo);
		Thread thread = new Thread(imageConvertUtil);
		thread.start();
		
		thread.join();
	}

}
