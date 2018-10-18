package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.DroneProject;
import gaia3d.persistence.DroneProjectMapper;
import gaia3d.service.DroneProjectService;

@Service
public class DroneProjectServiceImpl implements DroneProjectService {

	@Autowired
	private DroneProjectMapper droneProjectMapper;
	
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
		return droneProjectMapper.updateDroneProject(droneProject);
	}
}
