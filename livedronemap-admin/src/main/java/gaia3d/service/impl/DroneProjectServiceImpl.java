package gaia3d.service.impl;

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
	 * drone project 등록
	 * @param droneProject
	 * @return
	 */
	@Transactional
	public int insertDroneProject(DroneProject droneProject) {
		return droneProjectMapper.insertDroneProject(droneProject);
	}
}
