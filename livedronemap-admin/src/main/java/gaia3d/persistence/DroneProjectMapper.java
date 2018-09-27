package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.DroneProject;

@Repository
public interface DroneProjectMapper {

	/**
	 * drone project 등록
	 * @param droneProject
	 * @return
	 */
	int insertDroneProject(DroneProject droneProject);
}
