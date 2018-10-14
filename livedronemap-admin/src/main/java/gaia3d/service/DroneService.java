package gaia3d.service;

import gaia3d.domain.Drone;

public interface DroneService {

	/**
	 * drone 등록
	 * @param drone
	 * @return
	 */
	int insertDrone(Drone drone);
}
