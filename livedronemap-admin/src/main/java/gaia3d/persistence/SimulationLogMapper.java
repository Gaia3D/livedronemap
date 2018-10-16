package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.SimulationLog;

@Repository
public interface SimulationLogMapper {
	
	/**
	 * 시뮬레이션 등록
	 * @param simulationLog
	 * @return
	 */
	public int insertSimulationLog(SimulationLog simulationLog);
}
