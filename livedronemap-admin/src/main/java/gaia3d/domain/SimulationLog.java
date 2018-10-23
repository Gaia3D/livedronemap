package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SimulationLog {
	
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
	
	/********** 검색 조건 ************/
	private String search_value;
	// 검색 옵션. 0 : 일치, 1 : 포함
	private String search_option;
	private String search_type;
	private String search_status;
	// 시작일 또는 완료일
	private String search_date;
	private String search_start_date;
	private String search_end_date;
	private String order_word;
	private String order_value;
	private Long list_counter = 10l;
	
	// 시뮬레이션 ID
	private Integer simulation_log_id;
	// 시뮬레이션 종류, 0: 전체, 1: 클라이언트(시립대), 2: 가이아쓰리디
	private String simulation_type;
	// client 고유키
	private Integer client_id;
	// client명(중복)
	private String client_name;
	// 시뮬레이션 상태. 0 : 성공, 1 : 실패, 2 : 진행중
	private String status;
	// 상세 메세지
	private String message;
	// 시뮬레이션 시작일
	private String start_date;
	// 시뮬레이션 완료일
	private String complete_date;
	// 등록일
	private String insert_date;
	
	public String getViewStart_date() {
		if(this.start_date == null || "".equals(start_date)) {
			return "";
		}
		return start_date.substring(0, 19);
	}
	
	public String getViewComplete_date() {
		if(this.complete_date == null || "".equals( complete_date)) {
			return "";
		}
		return complete_date.substring(0, 19);
	}

}
