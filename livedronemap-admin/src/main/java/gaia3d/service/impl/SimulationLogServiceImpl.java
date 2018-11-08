package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.DroneProject;
import gaia3d.domain.SimulationLog;
import gaia3d.persistence.DroneProjectMapper;
import gaia3d.persistence.SimulationLogMapper;
import gaia3d.service.SimulationLogService;

@Service
public class SimulationLogServiceImpl implements SimulationLogService{

	@Autowired
	SimulationLogMapper simulationLogMapper;
	@Autowired
	DroneProjectMapper droneProjectMapper;
	
	@Transactional
	public int insertSimulationLog(SimulationLog simulationLog) {
		return simulationLogMapper.insertSimulationLog(simulationLog);
	}
	
	@Transactional(readOnly=true)
	public Long getSimulationLogTotalCount(SimulationLog simulationLog) {
		return simulationLogMapper.getSimulationLogTotalCount(simulationLog);
	}
	
	@Transactional(readOnly=true)
	public SimulationLog getSimulationLogByDroneProjectId(Integer droneProjectId) {
		return simulationLogMapper.getSimulationLogByDroneProjectId(droneProjectId);
	}
	
	@Transactional(readOnly=true)
	public SimulationLog getSimulationLog(Integer simulationLogId) {
		return simulationLogMapper.getSimulationLog(simulationLogId);
	}
	
	@Transactional(readOnly=true)
	public List<SimulationLog> getSimulationLogList(SimulationLog simulationLog) {
		return simulationLogMapper.getSimulationLogList(simulationLog);
	}
	
	@Transactional
	public int updateSimulationLog(SimulationLog simulationLog) {
		int result = simulationLogMapper.updateSimulationLog(simulationLog);
		
		simulationLog = getSimulationLog(simulationLog.getSimulation_log_id());
		Integer droneProjectId = simulationLog.getDrone_project_id();
		if (droneProjectId != null && simulationLog.getStatus().equals("1")) {
			DroneProject droneProject = new DroneProject();
			droneProject.setDrone_project_id(droneProjectId);
			droneProject.setStatus("4");
			droneProject.setOrtho_image_count(0);
			droneProject.setPostprocessing_image_count(0);
			droneProject.setDetected_object_item1_count(0);
			droneProject.setDetected_object_item2_count(0);
			droneProject.setDetected_object_item3_count(0);
			droneProject.setDetected_object_item4_count(0);
			droneProjectMapper.updateDroneProject(droneProject);
			
		}
		
		return result;
	}

	@Transactional
	public int updateSimulationLogProjectId(SimulationLog simulationLog) {
		return simulationLogMapper.updateSimulationLogProjectId(simulationLog);
	}

	

	
	
}
