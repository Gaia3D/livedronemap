package gaia3d.service;

import gaia3d.domain.DroneProject;

public interface DroneProjectService {

	/**
	 * drone project 등록
	 * @param droneProject
	 * @return
	 */
	int insertDroneProject(DroneProject droneProject);
}
