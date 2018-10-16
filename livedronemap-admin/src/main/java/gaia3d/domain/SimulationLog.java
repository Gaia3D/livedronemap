package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SimulationLog {
	
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
	private String completat_date;
	
}
