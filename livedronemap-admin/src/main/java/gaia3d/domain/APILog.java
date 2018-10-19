package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class APILog {
	
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
	
	/********** 검색 조건 ************/
	private String search_word;
	// 검색 옵션. 0 : 일치, 1 : 포함
	private String search_option;
	private String search_value;
	private String search_status;
	private String search_start_date;
	private String search_end_date;
	private String order_word;
	private String order_value;
	private Long list_counter = 10l;

	// 고유키
	private Long api_log_id;
	// client 고유키
	private Integer client_id;
	// client 명(중복 허용)
	private String client_name;
	// request ip
	private String request_ip;
	// 사용자 아이디
	private String user_id;
	// url
	private String url;
	// http status code
	private Integer status_code;
	// message
	private String message;
	private String insert_date;
	
	public String getViewInsert_date() {
		if(this.insert_date == null || "".equals(insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
	
}
