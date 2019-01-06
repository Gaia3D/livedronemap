package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.Drone;

@Repository
public interface DroneMapper {

	/**
	 * drone 등록
	 * @param drone
	 * @return
	 */
	int insertDrone(Drone drone);
}
