package gaia3d.service;

import gaia3d.domain.SimulationLog;

public interface SimulationLogService {

	/**
	 * 시뮬레이션 등록
	 * @param simulationLog
	 * @return
	 */
	public int insertSimulationLog(SimulationLog simulationLog);
}
