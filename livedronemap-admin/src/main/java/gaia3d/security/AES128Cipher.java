package gaia3d.security;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class AES128Cipher {
	 
	final static byte[] secretKey   = { 114, 101, 115, 116, 97, 112, 105, 115, 99, 114, 101, 101, 116, 107, 101, 121 };
	static byte[] IV                = { 114, 101, 115, 116, 97, 112, 105, 115, 99, 114, 101, 101, 116, 107, 101, 121 };
	 
	/**
	 * @param plainText
	 * @return
	 * @throws Exception
	 */
	public static String encode(String plainText) throws Exception {
		byte[] keyData = secretKey;
		SecretKey secureKey = new SecretKeySpec(keyData, "AES");
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.ENCRYPT_MODE, secureKey, new IvParameterSpec(IV));
	 
		byte[] encrypted = c.doFinal(plainText.getBytes("UTF-8"));
		String enStr = new String(Base64.encodeBase64(encrypted));
		
		return enStr;
	}
	 
	/**
	 * @param encodedText
	 * @return
	 * @throws Exception
	 */
	public static String decode(String encodedText) throws Exception {
		byte[] keyData = secretKey;
		SecretKey secureKey = new SecretKeySpec(keyData, "AES");
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.DECRYPT_MODE, secureKey, new IvParameterSpec(IV));
	 
		byte[] byteStr = Base64.decodeBase64(encodedText.getBytes());
		
		return new String(c.doFinal(byteStr),"UTF-8");
	}
}
