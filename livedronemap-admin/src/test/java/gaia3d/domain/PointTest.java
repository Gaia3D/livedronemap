package gaia3d.domain;

import static org.junit.Assert.*;

import org.junit.Test;

public class PointTest {

	@Test
	public void test() {
		String point = "POINT(126.262715 36.370818)";
		String[] temp = point.substring(point.indexOf("(") + 1, point.indexOf(")")).split(" ");
		
		System.out.println(temp[0]);
		System.out.println(temp[1]);
	}

}
