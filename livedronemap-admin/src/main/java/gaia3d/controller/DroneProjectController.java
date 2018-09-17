package gaia3d.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import gaia3d.domain.DroneProject;

@RequestMapping("/drone-project/")
@Controller
public class DroneProjectController {

	/**
	 * Project 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list")
	public String droneProjectList(Model model) {
		//List<DroneProject> projectList = projectService.getListProject(new Project());
		
//		model.addAttribute("projectListSize", projectList.size());
//		model.addAttribute("projectList", projectList);
		
		return "/drone-projects/list-project";
	}
}
