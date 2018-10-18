package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.SimulationLog;

@Repository
public interface SimulationLogMapper {
	
	/**
	 * 시뮬레이션 로그 등록
	 * @param simulationLog
	 * @return
	 */
	public int insertSimulationLog(SimulationLog simulationLog);

	/**
	 * 시뮬레이션 로그 리스트 조회
	 * @return
	 */
	public List<SimulationLog> getSimulationLogList(SimulationLog simulationLog);
	
	/**
	 * 시뮬레이션 로그 카운트
	 * @return
	 */
	public Long getSimulationLogTotalCount(SimulationLog simulationLog);
}
