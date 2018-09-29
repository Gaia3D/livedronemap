package gaia3d.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Drone implements Serializable {
	
	private static final long serialVersionUID = -6806258038108261370L;

	// 드론 고유번호
	private Integer drone_id;
	// 드론명
	private String drone_name;
	
	// 드론 위도
	private BigDecimal latitude;
	// 드론 경도
	private BigDecimal longitude;
	// 드론 높이
	private BigDecimal altitude;
	// 드론 roll
	private BigDecimal roll;
	// 드론 pitch
	private BigDecimal pitch;
	// 드론 흔들림
	private BigDecimal yaw;
	
	// 등록일
	private String insert_date;
}
