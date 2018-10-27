package gaia3d.security;

import org.junit.Test;

public class AES128CipherTest {

	@Test
	public void test() {
		String secretKey   = "1234567890123456";
		byte[] keyBytes = secretKey.getBytes();
		for(int i=0; i<keyBytes.length; i++) {
			System.out.print(keyBytes[i] + ",");
		}
		
		System.out.println(secretKey.getBytes().toString());
		
		byte[] test = {49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54};
		System.out.println(new String(test));
	}
	
	@Test
	public void byteTest() {
		//System.out.println(new String(AES128Cipher.secretKey));
	}
}
