package gaia3d.service;

import java.util.List;

import gaia3d.domain.SimulationLog;

public interface SimulationLogService {

	/**
	 * 시뮬레이션 로그 등록
	 * @param simulationLog
	 * @return
	 */
	int insertSimulationLog(SimulationLog simulationLog);
	
	/**
	 * 시뮬레이션 로그 조회
	 * @param simulationLogId
	 * @return
	 */
	SimulationLog getSimulationLog(Integer simulationLogId);
	
	/**
	 * 시뮬레이션 로그 조회 by droneProjectId
	 * @param droneProjectId
	 * @return
	 */
	SimulationLog getSimulationLogByDroneProjectId(Integer droneProjectId);
	
	/**
	 * 시뮬레이션 로그 리스트 조회 
	 * @return
	 */
	List<SimulationLog> getSimulationLogList(SimulationLog simulationLog);
	
	/**
	 * 시뮬레이션 오류 메세지 조회 
	 * @param simulation_log_id
	 * @return
	 */
	String getSimulationMessage(Integer simulation_log_id);
	
	/**
	 * 시뮬레이션 로그 카운트
	 * @param simulationLog
	 * @return
	 */
	Long getSimulationLogTotalCount(SimulationLog simulationLog);

	/**
	 * 시뮬레이션 로그 상테 업데이트 
	 * @param simulationLog
	 * @return
	 */
	int updateSimulationLog(SimulationLog simulationLog);

	/**
	 * 시뮬레이션 로그 프로젝트 ID 업데이트 
	 * @param simulationLog
	 * @return
	 */
	int updateSimulationLogProjectId(SimulationLog simulationLog);
	
}
