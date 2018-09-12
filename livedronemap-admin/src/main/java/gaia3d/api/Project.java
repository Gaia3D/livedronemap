package gaia3d.api;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Project {

	private Long project_id;
	private String name;
	
	// 위도
	private BigDecimal start_latitude;
	// 경도
	private BigDecimal start_longitude;
	// 높이
	private BigDecimal start_height;
	
	// 위도
	private BigDecimal end_latitude;
	// 경도
	private BigDecimal end_longitude;
	// 높이
	private BigDecimal end_height;
	
	private Long drone_id;
}
