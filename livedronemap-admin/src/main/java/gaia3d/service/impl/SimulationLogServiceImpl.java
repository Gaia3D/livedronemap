package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.SimulationLog;
import gaia3d.persistence.SimulationLogMapper;
import gaia3d.service.SimulationLogService;

@Service
public class SimulationLogServiceImpl implements SimulationLogService{

	@Autowired
	SimulationLogMapper simulationLogMapper;
	
	@Transactional
	public int insertSimulationLog(SimulationLog simulationLog) {
		return simulationLogMapper.insertSimulationLog(simulationLog);
	}
	
	@Transactional(readOnly=true)
	public List<SimulationLog> getSimulationLogList(SimulationLog simulationLog) {
		return simulationLogMapper.getSimulationLogList(simulationLog);
	}

	@Transactional(readOnly=true)
	public Long getSimulationLogTotalCount(SimulationLog simulationLog) {
		return simulationLogMapper.getSimulationLogTotalCount(simulationLog);
	}

	@Transactional
	public int updateSimulationLog(SimulationLog simulationLog) {
		return simulationLogMapper.updateSimulationLog(simulationLog);
	}

	@Transactional
	public int updateSimulationLogProjectId(SimulationLog simulationLog) {
		return simulationLogMapper.updateSimulationLogProjectId(simulationLog);
	}
	
}
