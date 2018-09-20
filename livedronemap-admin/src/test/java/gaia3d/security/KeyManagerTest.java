package gaia3d.security;

import java.util.Base64;

import org.junit.Test;

public class KeyManagerTest {

	@Test
	public void test() throws Exception {
		String key = KeyManager.getInitKey();
		System.out.println(key);
		
		String encryptKey = "ZW5vcmRldmlsQCBzaSBlbWFuIHltIC5hZWRpIGRhYiBhIGVrYW0gdG9uIG9kIGVzYWVscCAseWVrIHBhbSBkbnVvZiBldmFoIHVveSBmSQ==";
		byte[] base64decodedBytes = Base64.getDecoder().decode(encryptKey.getBytes("UTF-8"));
		String result = new String(base64decodedBytes, "UTF-8");
		result = (new StringBuffer(result)).reverse().toString();
		System.out.println("1 ===== " + result);
		result = result.substring(69, 79) + result.substring(18, 21) + result.substring(22, 25);
		System.out.println("2 ===== " + result);
	}

	@Test
	public void 키_암호화() throws Exception {
		String key = "If you have found map key, please do not make a bad idea. my name is @livedrone";
		System.out.println("key = " + key);
		String reverseKey =  new StringBuffer(key).reverse().toString();
		System.out.println("reverseKey = " + reverseKey);
		String encryptKey = new String(Base64.getEncoder().encode(reverseKey.getBytes("UTF-8")));
		System.out.println("encryptKey = " + encryptKey);
	}
}
