package gaia3d.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import gaia3d.service.DroneProjectService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ProjectCheckManager {
	
	@Autowired
	DroneProjectService droneProjectService;
	
	@Scheduled(fixedDelay = 180 * 60 * 1000)
	public void closeDroneProject() throws Exception {
		log.info("@@@@@@@@@@@@@ ProjectCheckManager project close execute.");
		
		// 하루 지난 프로젝트는 프로젝트는 강제 종료, 에러 프로젝트는 제외 
		droneProjectService.updateDroneProjectClose();
	}
	
}
