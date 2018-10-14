package gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import gaia3d.domain.APIHeader;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIValidationType;
import gaia3d.domain.CacheManager;
import gaia3d.domain.CacheName;
import gaia3d.domain.CacheParams;
import gaia3d.domain.CacheType;
import gaia3d.domain.Drone;
import gaia3d.domain.DroneProject;
import gaia3d.domain.Policy;
import gaia3d.domain.TokenLog;
import gaia3d.service.DroneService;
import gaia3d.util.StringUtil;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DroneController {

	@Autowired
	private DroneService droneService;
	
	@PostMapping("/drones")
	@ResponseBody
	public Map<String, Object> insertProject(HttpServletRequest request, Drone drone) {
		log.info("@@@@@@@@@@ drone = {}", drone);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(drone == null || StringUtil.isEmpty(drone.getDrone_name())) {
				result = "drone.name.require";
				map.put("result", result);
				return map;
			}
			
			droneService.insertDrone(drone);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
}
