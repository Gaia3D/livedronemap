package gaia3d.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gaia3d.domain.Client;
import gaia3d.domain.ClientGroup;
import gaia3d.service.ClientGroupService;
import gaia3d.service.ClientService;
import gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Client 관리
 * @author jwpark
 *
 */
@Slf4j
@Controller
public class ClientController { 
	
	@Autowired
	private ClientService clientService;
	@Autowired
	private ClientGroupService clientgroupService;

	/**
	 * client 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/client/input-client")
	public String inputClient(Model model) {
		Client client = new Client();
		ClientGroup clientGroup = new ClientGroup();
		clientGroup.setUse_yn(clientGroup.IN_USE);
		List<ClientGroup> clientGroupList = clientgroupService.getListClientGroup(clientGroup);
		String apikey = clientService.generateApikey();
		
		model.addAttribute(client);
		model.addAttribute(clientGroupList);
		model.addAttribute("apikey",apikey);
		return "/client/input-client";
	}
	
	
	/**
	 * client 추가
	 * @param request
	 * @param client
	 * @return
	 */
	@PostMapping("/clients")
	@ResponseBody
	public Map<String, Object> insertClient(HttpServletRequest request, Client client) {
		log.info("@@@@@@@@@@ client = {}", client);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			// TODO client group 도 체크 해야 함
			if(client == null || StringUtil.isEmpty(client.getClient_name())) {
				result = "client.name.require";
				map.put("result", result);
				return map;
			}
			
			clientService.insertClient(client);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value = "/client/ajax-generate-api-key")
	@ResponseBody
	public Map<String, Object> ajaxGenerateApiKey(HttpServletRequest request) {		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String Apikey = " ";
		
		try {
			Apikey = clientService.generateApikey();
//			log.info("@@@@@@@@@@ apikey = {}", Apikey);
		
		} catch(Exception e) {
			e.printStackTrace();
			result = "exception";
		}
		map.put("result", result);
		map.put("apikey", Apikey);

		return map;
	}


}
