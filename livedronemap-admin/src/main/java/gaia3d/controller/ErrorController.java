package gaia3d.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ErrorController {

	/**
	 * Project 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/error")
	public String clientList(HttpServletRequest request, Model model) {
		
		log.info("@@@@@@@@@@ error");
		
		return "/error/error";
	}
}
