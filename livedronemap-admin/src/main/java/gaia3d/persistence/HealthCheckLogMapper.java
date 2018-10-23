package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.HealthCheckLog;

/**
 * 상태 점검 처리
 * @author jskim
 *
 */
@Repository
public interface HealthCheckLogMapper {

	/**
	 * 상태 점검 이력 
	 * @param healthCheckLog
	 */
	int insertHealthCheckLog(HealthCheckLog healthCheckLog);

	/**
	 * 상태 점검 이력 리스트 조회
	 * @param healthCheckLog
	 * @return
	 */
	List<HealthCheckLog> gethealthCheckList(HealthCheckLog healthCheckLog);

	/**
	 * 상태 점검 이력 개수 조회 
	 * @param healthCheckLog
	 * @return
	 */
	long getHealthCheckLogTotalCount(HealthCheckLog healthCheckLog);
	
}
