package gaia3d.security;

import java.util.UUID;
import org.junit.Test;

public class TokenTest {

	@Test
	public void test() {
		String token = UUID.randomUUID().toString();
		System.out.println("string token = " + token);
		String time = Long.toString(System.nanoTime());
		System.out.println("time = " + time);
		System.out.println("time length = " + time.length());
		System.out.println("sub time = " + time.substring(4, 12));
	}

}
