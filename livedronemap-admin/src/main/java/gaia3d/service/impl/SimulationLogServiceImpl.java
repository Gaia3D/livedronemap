package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gaia3d.domain.SimulationLog;
import gaia3d.persistence.SimulationLogMapper;
import gaia3d.service.SimulationLogService;

@Service
public class SimulationLogServiceImpl implements SimulationLogService{

	@Autowired
	SimulationLogMapper simulationLogMapper;
	
	public int insertSimulationLog(SimulationLog simulationLog) {
		return simulationLogMapper.insertSimulationLog(simulationLog);
	}

	public List<SimulationLog> getSimulationLogList(SimulationLog simulationLog) {
		return simulationLogMapper.getSimulationLogList(simulationLog);
	}

	public Long getSimulationLogTotalCount(SimulationLog simulationLog) {
		return simulationLogMapper.getSimulationLogTotalCount(simulationLog);
	}

	
	
}
