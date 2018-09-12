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

@RunWith(SpringRunner.class)
@SpringBootTest
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
//@TestPropertySource("classpath:gdal.properties")
public class ImageConvertUtilTest {
	
	@Autowired
	GdalConfig gdalConfig;
	
	@Test
	@Ignore
	public void test000ConvertProjection() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "DJI_0064.png");
		String srcImg = targetPath.toAbsolutePath().toString();
		ImageConvertUtil imageConvertUtil = new ImageConvertUtil(gdalConfig, srcImg);
		imageConvertUtil.convertProjection(srcImg);
	}
	
	@Test
	@Ignore
	public void test001CreateInnerTile() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "DJI_0064_warp.tif");
		String srcImg = targetPath.toAbsolutePath().toString();
		ImageConvertUtil imageConvertUtil = new ImageConvertUtil(gdalConfig, srcImg);
		imageConvertUtil.createInnerTile(srcImg);
	}
	
	@Test
	@Ignore
	public void test002CreateOverview() throws InterruptedException, IOException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "DJI_0064_warp_tiled.tif");
		String srcImg = targetPath.toAbsolutePath().toString();
		ImageConvertUtil imageConvertUtil = new ImageConvertUtil(gdalConfig, srcImg);
		imageConvertUtil.createOverview(srcImg);
	}
	
	@Test
	public void test003() throws InterruptedException {
		Path targetPath = Paths.get("src", "test", "resources", "img", "DJI_0064.png");
		String srcImg = targetPath.toAbsolutePath().toString();
		Runnable imageConvertUtil = new ImageConvertUtil(gdalConfig, srcImg);
		Thread thread = new Thread(imageConvertUtil);
		thread.start();
		
		thread.join();
	}

}
