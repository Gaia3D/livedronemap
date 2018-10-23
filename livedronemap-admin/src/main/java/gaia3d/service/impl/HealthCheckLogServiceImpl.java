package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.HealthCheckLog;
import gaia3d.persistence.HealthCheckLogMapper;
import gaia3d.service.HealthCheckLogService;

@Service
public class HealthCheckLogServiceImpl implements HealthCheckLogService {

	@Autowired
	HealthCheckLogMapper healthCheckLogMapper;
	
	/**
	 * 상태 점검 이력 
	 * @param healthCheckLog
	 */
	@Transactional
	public int insertHealthCheckLog(HealthCheckLog healthCheckLog) {
		return healthCheckLogMapper.insertHealthCheckLog(healthCheckLog);
	}

	/**
	 * 상태 점검 이력 리스트 조회
	 * @param healthCheckLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<HealthCheckLog> gethealthCheckList(HealthCheckLog healthCheckLog) {
		return healthCheckLogMapper.gethealthCheckList(healthCheckLog);
	}

	/**
	 * 상태 점검 이력 개수 조회 
	 * @param healthCheckLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public long getHealthCheckLogTotalCount(HealthCheckLog healthCheckLog) {
		return healthCheckLogMapper.getHealthCheckLogTotalCount(healthCheckLog);
	}

}
