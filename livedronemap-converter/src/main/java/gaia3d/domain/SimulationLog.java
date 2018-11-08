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
	// 드론 프로젝트 ID
	private Integer drone_project_id;
	// 시뮬레이션 상태. 0 : 성공, 1 : 실패, 2 : 진행중
	private String status;
	
}
