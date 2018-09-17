package gaia3d.util;

import java.io.IOException;
import java.lang.ProcessBuilder.Redirect;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runners.MethodSorters;

/**
 * GDAL command test 
 * @author Kim JeaSeon
 *
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class GdalTest {
	
	private String gdalPath = "/Library/Frameworks/GDAL.framework/Versions/Current/Programs";
	
	private String imgPath = "/Volumes/macDATA/source/2018/livedronemap/livedronemap-converter/src/test/resources/img/DJI_0064.png";
	private String imgPathGdalwarp = "/Volumes/macDATA/source/2018/livedronemap/livedronemap-converter/src/test/resources/img/result/DJI_0064.tif";
	private String imgPathGdaltranslate = "/Volumes/macDATA/source/2018/livedronemap/livedronemap-converter/src/test/resources/img/result/DJI_0064_tiled.tif";
	
	@Test
	@Ignore
	public void test001gdalwrap() throws IOException, InterruptedException {
		String sourceSrs = "EPSG:4326";
		String targetSrs = "EPSG:4326";
		
		String[] commandArray = {gdalPath + "/gdalwarp", "-r", "cubic", "-of", "GTiff", "-s_srs", sourceSrs, "-t_srs", targetSrs, imgPath, imgPathGdalwarp};
		
		byProcessBuilderRedirect(commandArray);
		
	}
	
	@Test
	@Ignore
	public void test002gdalTranslate() throws IOException, InterruptedException {
		String[] commandArray = {gdalPath + "/gdal_translate", "-of", "GTiff", "-co", "TILED=YES", imgPathGdalwarp, imgPathGdaltranslate};
		byProcessBuilderRedirect(commandArray);
		
	}
	
	@Test
	@Ignore
	public void test003gdaladdo() throws IOException, InterruptedException {
		String[] commandArray = {gdalPath + "/gdaladdo", "-r", "average", imgPathGdaltranslate, "2", "4", "8", "16", "32", "64", "128"};
		byProcessBuilderRedirect(commandArray);
		
	}
	
	public void byProcessBuilderRedirect(String[] command)  
	        throws IOException, InterruptedException {
		ProcessBuilder builder = new ProcessBuilder(command);
	    builder.redirectOutput(Redirect.INHERIT);
	    builder.redirectError(Redirect.INHERIT);
	    Process process = builder.start();
	    process.waitFor();
	}
	
}
