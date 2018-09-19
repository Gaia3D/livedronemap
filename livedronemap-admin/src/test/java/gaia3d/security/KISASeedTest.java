package gaia3d.security;

import static org.junit.Assert.*;

import org.junit.Test;

public class KISASeedTest {
	
	byte pbUserKey[]  = {(byte)0x88, (byte)0xE3, (byte)0x4F, (byte)0x8F, (byte)0x08, (byte)0x17, (byte)0x79, (byte)0xF1,
            (byte)0xE9, (byte)0xF3, (byte)0x94, (byte)0x37, (byte)0x0A, (byte)0xD4, (byte)0x05, (byte)0x89};

byte pbData[]     = {(byte)0xD7, (byte)0x6D, (byte)0x0D, (byte)0x18, (byte)0x32, (byte)0x7E, (byte)0xC5, (byte)0x62, (byte)0xB1, (byte)0x5E, (byte)0x6B, (byte)0xC3, (byte)0x65, (byte)0xAC, (byte)0x0C, (byte)0x0F};

byte pbData1[]    = {(byte)0x00, (byte)0x01};
byte pbData2[]     = {(byte)0x00, (byte)0x01, (byte)0x02, (byte)0x03, (byte)0x04, (byte)0x05, (byte)0x06, (byte)0x07, (byte)0x08, (byte)0x09, (byte)0x0A, (byte)0x0B, (byte)0x0C, (byte)0x0D, (byte)0x0E, (byte)0x0F, (byte)0x00, (byte)0x01};


	@Test
	public void test() {
		String screetKey = "restapiscreetkey";
		System.out.println(screetKey.getBytes().length);
		
		String name = "테스트";
		
		
		String KISASeed.SEED_ECB_Encrypt(screetKey.getBytes(), name.getBytes(), 0, 16);
		//KISASeed.SEED_ECB_Decrypt(pbszUserKey, pbData, offset, length);
		
	}

}
