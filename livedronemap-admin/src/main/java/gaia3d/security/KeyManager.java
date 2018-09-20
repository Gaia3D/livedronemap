package gaia3d.security;

import java.util.Base64;

public class KeyManager {

	private static final String randomKeyword = "ZW5vcmRldmlsQCBzaSBlbWFuIHltIC5hZWRpIGRhYiBhIGVrYW0gdG9uIG9kIGVzYWVscCAseWVrIHBhbSBkbnVvZiBldmFoIHVveSBmSQ==";

	public static String getInitKey() {
		String result = null;
		try {
			byte[] base64decodedBytes = Base64.getDecoder().decode(randomKeyword.getBytes("UTF-8"));
			result = new String(base64decodedBytes, "UTF-8");
		} catch(Exception e) {
			e.printStackTrace();
		}
		result = reverseString(result);
		
		return parse(result);
	}
	
	private static String reverseString(String value) {
		if(value == null) return "";
		return (new StringBuffer(value)).reverse().toString();
	}
	
	private static String parse(String value) {
		return value.substring(69, 79) + value.substring(18, 21) + value.substring(22, 25);
	}
}
