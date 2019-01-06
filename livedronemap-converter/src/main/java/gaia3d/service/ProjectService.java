package gaia3d.service;

import org.springframework.http.ResponseEntity;

import gaia3d.domain.APIResult;
import gaia3d.domain.SimulationLog;

public interface ProjectService {
	
	public SimulationLog getSimulationLog(Integer droneProjectId); 
	
	public ResponseEntity<APIResult> updateSimulationLog(Integer simulationLogId, String status, String message); 
	
	public ResponseEntity<APIResult> updateDroneProject(Integer droneProjectId, String status);
	
}
