package gaia3d.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/main/")
public class MainController {
	
	@GetMapping("/index")
	public String login(HttpServletRequest request, Model model) {
		log.info("@@@@@@@@@@ live drone header = {}", request.getHeader("live_drone_header"));
		
		//List<DroneProject> projectList = projectService.getListProject(new Project());
		
//		model.addAttribute("projectListSize", projectList.size());
//		model.addAttribute("projectList", projectList);
		
		return "/drone-project/list-drone-project";
	}
	
}
