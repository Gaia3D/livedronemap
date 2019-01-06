package gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import gaia3d.domain.Drone;
import gaia3d.service.DroneService;
import gaia3d.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 드론 관리
 * @author jwpark
 *
 */
@Slf4j
@Controller
public class DroneController {

	@Autowired
	private DroneService droneService;
	
	/**
	 * @param request
	 * @param drone
	 * @return
	 */
	@PostMapping("/drones")
	@ResponseBody
	public Map<String, Object> insertDrone(HttpServletRequest request, Drone drone) {
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
	
	/**
	 * Drone 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/drone/input-drone")
	public String inputDrone(Model model) {
		Drone drone = new Drone();	
		model.addAttribute(drone);
		return "/drone/input-drone";
	}
}
