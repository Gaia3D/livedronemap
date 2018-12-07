package gaia3d.service;

import java.util.List;

import gaia3d.domain.HealthCheckLog;

public interface HealthCheckLogService {

	/**
	 * 상태 점검 이력 개수 조회 
	 * @param healthCheckLog
	 * @return
	 */
	long getHealthCheckLogTotalCount(HealthCheckLog healthCheckLog);

	/**
	 * 상태 점검 이력 리스트 조회
	 * @param healthCheckLog
	 * @return
	 */
	List<HealthCheckLog> gethealthCheckList(HealthCheckLog healthCheckLog);
	
	/**
	 * 상태 점검 이력 
	 * @param healthCheckLog
	 */
	int insertHealthCheckLog(HealthCheckLog healthCheckLog);

	/**
	 * 상태 점검 오류 메세지 조회 
	 * @param health_check_log_id
	 * @return
	 */
	String getHealthCheckLogMessage(Integer healthCheckLogId);
}
