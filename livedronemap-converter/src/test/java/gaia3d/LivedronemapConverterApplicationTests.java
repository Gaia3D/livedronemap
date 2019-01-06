package gaia3d;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
@PropertySources({ 
	@PropertySource("classpath:gdal.properties")
})
public class LivedronemapConverterApplicationTests {

	@Test
	public void contextLoads() {
	}

}
