package gaia3d.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/client/")
@Controller
public class ClientController {

	/**
	 * Project 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-client")
	public String clientList(HttpServletRequest request, Model model) {
		
		log.info("@@@@@@@@@@ list-client");
		
		return "/client/list-client";
	}
}
