package gaia3d.domain;

import java.math.BigDecimal;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Drone Project
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class DroneProject extends SearchDomain {
	
	/****** validator ********/
	private String method_mode;
	
	/****** DB 데이터 화면 표시용 ********/
	// location 의 latitude
	private BigDecimal location_latitude;
	// location 의 longitude
	private BigDecimal location_longitude;
	
	// 개별 정사 영상 개수
	private Integer ortho_image_count;
	// 후처리 영상 개수
	private Integer postprocessing_image_count;
	// 객체 탐지 개수
	private Integer ortho_detected_object_count;
	
	// 고유번호
	private Integer drone_project_id;
	// drone 고유번호
	private Integer drone_id;
	// drone project명
	private String drone_project_name;
	// 프로젝트 구분
	private String drone_project_type;
	// 촬영 지역
	private String shooting_area;
	// 촬영 시작 지점의 좌상단 위도
	private BigDecimal shooting_upper_left_latitude;
	// 촬영 시작 지점의 좌상단 경도
	private BigDecimal shooting_upper_left_longitude;
	// 촬영 시작 지점의 우상단 위도
	private BigDecimal shooting_upper_right_latitude;
	// 촬영 시작 지점의 우상단 경도
	private BigDecimal shooting_upper_right_longitude;
	// 촬영 시작 지점의 우하단 위도
	private BigDecimal shooting_lower_right_latitude;
	// 촬영 시작 지점의 우하단 경도
	private BigDecimal shooting_lower_right_longitude;
	// 촬영 시작 지점의 좌하단 위도
	private BigDecimal shooting_lower_left_latitude;
	// 촬영 시작 지점의 좌하단 경도
	private BigDecimal shooting_lower_left_longitude;
	
	// Multi Polygon
	@Setter(AccessLevel.NONE)
	private String location;
	// 촬영 일시
	private String shooting_date;
	// 상태. 0:준비중, 1:점검/테스트, 2:개별 정사영상, 3:후처리 영상 , 4:프로젝트 종료, 5:에러
	private String status;
	
	// 설명
	private String description;
	// 수정일
	private String update_date;
	// 등록일
	private String insert_date;
	
	public void setLocation(String location) {
		this.location = location;
		if(this.location != null && !"".equals(this.location)) {
			String[] temp = this.location.substring(this.location.indexOf("(") + 1, this.location.indexOf(")")).split(" ");
			this.location_longitude = new BigDecimal(temp[0]);
			this.location_latitude = new BigDecimal(temp[1]);
		}
	}
	
	public String getViewShootingDate() {
		if(this.shooting_date == null || "".equals( shooting_date)) {
			return "";
		}
		return shooting_date.substring(0, 19);
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
