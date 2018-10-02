package gaia3d.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.geotools.coverage.grid.GridCoverage2D;
import org.geotools.coverage.grid.io.AbstractGridCoverage2DReader;
import org.geotools.coverage.grid.io.AbstractGridFormat;
import org.geotools.factory.Hints;
import org.geotools.gce.geotiff.GeoTiffFormat;
import org.geotools.geometry.Envelope2D;
import org.geotools.referencing.CRS;
import org.junit.Test;
import org.opengis.referencing.FactoryException;
import org.opengis.referencing.NoSuchAuthorityCodeException;
import org.opengis.referencing.crs.CoordinateReferenceSystem;

public class GeotoolsTest {

	@Test
	public void testGetImageBbox() throws IllegalArgumentException, IOException, NoSuchAuthorityCodeException, FactoryException {
		
		CoordinateReferenceSystem sourceCRS = CRS.decode("EPSG:4326");
		Hints hint = new Hints();
		hint.put(Hints.DEFAULT_COORDINATE_REFERENCE_SYSTEM, sourceCRS );    
		hint.put(Hints.FORCE_LONGITUDE_FIRST_AXIS_ORDER, Boolean.TRUE);
		
		Path targetPath = Paths.get("src", "test", "resources", "img", "DJI_0064_warp.tif");
		File targetFile = targetPath.toFile();
		
		AbstractGridFormat format = new GeoTiffFormat();
		AbstractGridCoverage2DReader reader = format.getReader(targetFile, hint);
        GridCoverage2D coverage = reader.read(null);
        
        Envelope2D e = coverage.getEnvelope2D();
        double minX = e.getMinX(); 
        double minY = e.getMinY();
        double maxX = e.getMaxX();
        double maxY = e.getMaxY();
        
        System.out.println(minX);
        System.out.println(minY);
        System.out.println(maxX);
        System.out.println(maxY);
        
        String wkt = makeWkt(minX, minY, maxX, maxY);
        System.out.println(wkt);
		
	}
	
	private String makeWkt(double minX, double minY, double maxX, double maxY) {
		String wkt = String.format("POLYGON((%1$f %2$f, %1$f %4$f, %3$f %4$f, %3$f %2$f, %1$f %2$f))", 
				minX, minY, maxX, maxY);
		return wkt;
		
	}
	
	
}
