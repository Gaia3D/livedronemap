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
	 * 프로젝트 정보 조회
	 * @param drone_project_id
	 * @return
	 */
	DroneProject getDroneProject(Integer drone_project_id);

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

	/**
	 * drone project 종료 
	 */
	int updateDroneProjectClose();
}
