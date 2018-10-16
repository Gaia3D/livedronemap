package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gaia3d.domain.SimulationLog;
import gaia3d.persistence.SimulationLogMapper;
import gaia3d.service.SimulationLogService;

@Service
public class SimulationLogServiceImpl implements SimulationLogService{

	@Autowired
	SimulationLogMapper simulationLogMapper;
	
	@Override
	public int insertSimulationLog(SimulationLog simulationLog) {
		return simulationLogMapper.insertSimulationLog(simulationLog);
	}

}
