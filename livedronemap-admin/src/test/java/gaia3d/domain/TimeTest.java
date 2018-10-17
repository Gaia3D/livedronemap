package gaia3d.domain;

import static org.junit.Assert.*;

import java.util.Date;

import org.junit.Ignore;
import org.junit.Test;

import gaia3d.util.DateUtil;
import gaia3d.util.FormatUtil;

public class TimeTest {

	@Ignore
	public void test() {
		String time = "2018-10-16-T20:38:00.000000";
		//2001-01-10T10:10:24.000Z
		System.out.println(
				time.substring(0,4) + "-" + time.substring(4,6) + "-" + time.substring(6,8) + "T" 
				+ time.substring(8,10) + ":" + time.substring(10,12) + ":" + time.substring(12,14) + "." + time.substring(14, 17) + "Z");
	}

	@Test
	public void date() {
		//20181016203800
		
		System.out.println(DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14));
	}
}
