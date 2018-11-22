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
	 * 시뮬레이션 로그 조회
	 * @param simulationLogId
	 * @return
	 */
	public SimulationLog getSimulationLog(Integer simulationLogId);
	
	/**
	 * 시뮬레이션 로그 조회 by droneProjectId
	 * @param droneProjectId
	 * @return
	 */
	public SimulationLog getSimulationLogByDroneProjectId(Integer droneProjectId);
	
	/**
	 * 시뮬레이션 로그 리스트 조회
	 * @return
	 */
	public List<SimulationLog> getSimulationLogList(SimulationLog simulationLog);
	
	/**
	 * 시뮬레이션 오류 메세지 조회 
	 * @param simulation_log_id
	 * @return
	 */
	public String getSimulationMessage(Integer simulation_log_id);
	
	/**
	 * 시뮬레이션 로그 카운트
	 * @return
	 */
	public Long getSimulationLogTotalCount(SimulationLog simulationLog);

	/**
	 * 시뮬레이션 로그 상테 업데이트 
	 * @param simulationLog
	 * @return
	 */
	public int updateSimulationLog(SimulationLog simulationLog);

	/**
	 * 시뮬레이션 로그 프로젝트 ID 업데이트 
	 * @param simulationLog
	 * @return
	 */
	public int updateSimulationLogProjectId(SimulationLog simulationLog);

}
