package gaia3d.security;

import javax.crypto.Mac;

import org.junit.Test;

public class HMACTest {
	
	@Test
	public void test() {
		String keyId = "d36cb306-9341-466f-a794-d49fbc485d8b";
		String payload = "{\"command\": \"buy\", \"amount\":10, \"currency\":\"EURUSD\"}";
		String secret = "se1cr2et3w0r4d";


		String comareValue = "577a7927f55bc6ed1eaec08f7298e7c7596b6f951c4c6e8f24324fd9a1f0790adfdecbbd5ab73ad543fec7e6c3c23246a5dd8fae526e0b802ae99faccd06a29c";
		
		//Mac mac = HmacUtils
	}

}
