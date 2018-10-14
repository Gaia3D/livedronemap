package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gaia3d.domain.Drone;
import gaia3d.persistence.DroneMapper;
import gaia3d.service.DroneService;

@Service
public class DroneServiceImpl implements DroneService {

	@Autowired
	private DroneMapper droneMapper;
	
	@Override
	public int insertDrone(Drone drone) {
		return droneMapper.insertDrone(drone);
	}
}
