package gaia3d.security;

import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordTest {

	@Test
	public void test() {
//		String salt = BCrypt.gensalt();
//		ShaPasswordEncoder shaPasswordEncoder = new ShaPasswordEncoder(512);
//		shaPasswordEncoder.setIterations(1000);
//		String encryptPassword = shaPasswordEncoder.encodePassword("test", salt);
//		System.out.println("salt = " + salt);
//		System.out.println(encryptPassword);
		
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
		getSalt();
	}
	
	private String getSalt() {
		String salt = BCrypt.gensalt();
		log.info("salt = {}, length = {}", salt, salt.length());
		return salt;
	}

}
	