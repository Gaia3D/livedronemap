package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SimulationLog extends SearchFilter {
	
	// 시뮬레이션 ID
	private Integer simulation_log_id;
	// 시뮬레이션 종류, 0: 전체, 1: 클라이언트(시립대), 2: 가이아쓰리디
	private String simulation_type;
	// client 고유키
	private Integer client_id;
	// client명(중복)
	private String client_name;
	// 드론 프로젝트 ID
	private Integer drone_project_id;
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
