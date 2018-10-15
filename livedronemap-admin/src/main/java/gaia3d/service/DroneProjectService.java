package gaia3d.service;

import java.util.List;

import gaia3d.domain.DroneProject;

public interface DroneProjectService {

	/**
	 * 총건수
	 * @param droneProject
	 * @return
	 */
	Long getDroneProjectTotalCount(DroneProject droneProject);
	
	/**
	 * 목록
	 * @param droneProject
	 * @return
	 */
	List<DroneProject> getListDroneProject(DroneProject droneProject);
	
	/**
	 * drone project 등록
	 * @param droneProject
	 * @return
	 */
	int insertDroneProject(DroneProject droneProject);
	
	/**
	 * drone project 수정
	 * @param droneProject
	 * @return
	 */
	int updateDroneProject(DroneProject droneProject);
}
