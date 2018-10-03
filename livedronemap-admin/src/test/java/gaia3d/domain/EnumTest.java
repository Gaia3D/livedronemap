package gaia3d.domain;

import static org.junit.Assert.*;

import org.junit.Test;

import lombok.extern.slf4j.Slf4j;

public class EnumTest {

	@Test
	public void test() {
		System.out.println("============" + TransferDataType.ORTHO_IMAGE);
		
		if(TransferDataType.ORTHO_IMAGE.equals(TransferDataType.valueOf("0"))) {
			System.out.println("equals");
		} else {
			System.out.println("different");
		}
	}
}
