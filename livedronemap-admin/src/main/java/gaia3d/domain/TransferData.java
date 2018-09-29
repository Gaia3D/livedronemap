package gaia3d.domain;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class TransferData {

	// transfer data 고유번호
	private Long transfer_data_id;
	// drone project 고유번호
	private Integer drone_project_id;
	// 데이터 타입. 0 : 개별 정사 영상, 1 : 후처리 영상
	private String data_type;
	// 파일 이름
	private String file_name;
	// 객체 탐지 개수
	private Integer detected_objects_count;
	// 상태. 0 : 전송 완료, 1 : 후처리 완료
	private String status;
	// 드론 위도
	private BigDecimal drone_latitude;
	// 드론 경도
	private BigDecimal drone_longitude;
	// 드론 높이
	private BigDecimal drone_altitude;
	// 드론 roll
	private BigDecimal drone_roll;
	// 드론 pitch
	private BigDecimal drone_pitch;
	// 드론 흔들림
	private BigDecimal drone_yaw;
	// 촬영일
	private String shooting_date;
	// 등록일
	private String insert_date;
}
