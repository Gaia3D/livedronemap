package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 상태 점검 이력
 * @author jskim
 *
 */
@Getter
@Setter
@ToString
public class HealthCheckLog {
	
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
	
	private String search_value;
	// 검색 옵션. 0 : 일치, 1 : 포함
	private String search_option;
	private String search_status;
	private String search_http_code;
	private String search_start_date;
	private String search_end_date;
	private String order_word;
	private String order_value;
	private Long list_counter = 10l;

	// 상태 점검 이력 ID
	private Long health_check_log_id;
	// client 고유키
	private Integer client_id;
	// client명(중복)
	private String client_name;
	// 상태 점검 상태 
	private String status;
	// HTTP 응답 코드 
	private Integer status_code;
	// 상세 메세지
	private String message;
	// 시뮬레이션 등록일 
	private String insert_date;
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
