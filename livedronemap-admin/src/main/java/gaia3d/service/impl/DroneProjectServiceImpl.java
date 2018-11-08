package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.DroneProject;
import gaia3d.domain.SimulationLog;
import gaia3d.persistence.DroneProjectMapper;
import gaia3d.persistence.SimulationLogMapper;
import gaia3d.service.DroneProjectService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DroneProjectServiceImpl implements DroneProjectService {

	@Autowired
	private DroneProjectMapper droneProjectMapper;
	@Autowired
	private SimulationLogMapper simulationLogMapper;
	
	/**
	 * 총건수
	 * @param droneProject
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDroneProjectTotalCount(DroneProject droneProject) {
		return droneProjectMapper.getDroneProjectTotalCount(droneProject);
	}
	
	/**
	 * 목록
	 * @param droneProject
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DroneProject> getListDroneProject(DroneProject droneProject) {
		return droneProjectMapper.getListDroneProject(droneProject);
	}
	
	/**
	 * 프로젝트 정보 조회
	 * @param drone_project_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DroneProject getDroneProject(Integer drone_project_id) {
		return droneProjectMapper.getDroneProject(drone_project_id);
	}

	/**
	 * drone project 등록
	 * @param droneProject
	 * @return
	 */
	@Transactional
	public int insertDroneProject(DroneProject droneProject) {
		return droneProjectMapper.insertDroneProject(droneProject);
	}
	
	/**
	 * drone project 수정
	 * @param droneProject
	 * @return
	 */
	@Transactional
	public int updateDroneProject(DroneProject droneProject) {
		int result = droneProjectMapper.updateDroneProject(droneProject);
		
		droneProject = droneProjectMapper.getDroneProject(droneProject.getDrone_project_id());
		
		if (droneProject.getDrone_project_type().equals("1") && droneProject.getStatus().equals("4")) {
			SimulationLog simulationLog = new SimulationLog();
			simulationLog.setDrone_project_id(droneProject.getDrone_project_id());
			simulationLog.setStatus("0");
			simulationLogMapper.updateSimulationLog(simulationLog);
		}
		
		return result;
	}
}
