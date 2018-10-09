package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.DroneProject;

@Repository
public interface DroneProjectMapper {
	
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
}
