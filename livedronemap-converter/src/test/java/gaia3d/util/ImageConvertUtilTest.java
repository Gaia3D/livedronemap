package gaia3d.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@TestPropertySource("classpath:gdal.properties")
public class ImageConvertUtilTest {
	
	@Autowired
	ImageConvertUtil imageConvertUtil;
	
	@Test
	public void test000ConvertProjection() throws InterruptedException, IOException {
		String srcImg = "/Volumes/macDATA/source/2018/livedronemap/livedronemap-converter/src/test/resources/img/DJI_0064.png";
		String targetImg = "/Volumes/macDATA/source/2018/livedronemap/livedronemap-converter/src/test/resources/img/result/DJI_0064.tif";
		String srcSrs = "EPSG:4326";
		String targetSrs = "EPSG:4326";
		List<String> cmdOpt = new ArrayList<>();
		
		// output 포맷 
		cmdOpt.add("-of");
		cmdOpt.add("GTiff");
		
		// 리샘플링 알고리즘 
		cmdOpt.add("-r");
		cmdOpt.add("cubic");
		
		imageConvertUtil.convertProjection(srcImg, targetImg, srcSrs, targetSrs, cmdOpt);
	}
	
	@Test
	public void test001CreateInnerTile() throws InterruptedException, IOException {
		String srcImg = "/Volumes/macDATA/source/2018/livedronemap/livedronemap-converter/src/test/resources/img/result/DJI_0064.tif";
		String targetImg = "/Volumes/macDATA/source/2018/livedronemap/livedronemap-converter/src/test/resources/img/result/DJI_0064_tiled.tif";
		List<String> cmdOpt = new ArrayList<>();
		
		// output 포맷 
		cmdOpt.add("-of");
		cmdOpt.add("GTiff");
		
		// 타일 생성 여부  
		cmdOpt.add("-co");
		cmdOpt.add("TILED=YES");
		
		imageConvertUtil.createInnerTile(srcImg, targetImg, cmdOpt);
	}
	
	@Test
	public void test002C() throws InterruptedException, IOException {
		String srcImg = "/Volumes/macDATA/source/2018/livedronemap/livedronemap-converter/src/test/resources/img/result/DJI_0064_tiled.tif";
		int overviewLevel = 7;
		List<String> cmdOpt = new ArrayList<>();
		
		// 리샘플링 알고리즘 
		cmdOpt.add("-r");
		cmdOpt.add("average");
		
		imageConvertUtil.createOverview(srcImg, overviewLevel, cmdOpt);
	}

}
