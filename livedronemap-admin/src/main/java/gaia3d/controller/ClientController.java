package gaia3d.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import gaia3d.domain.Client;
import gaia3d.domain.ClientGroup;
import gaia3d.service.ClientGroupService;
import gaia3d.service.ClientService;
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
	public String input(Model model) {
		Client client = new Client();
		ClientGroup clientGroup = new ClientGroup();
		clientGroup.setUse_yn(ClientGroup.IN_USE);
		List<ClientGroup> clientGroupList = clientgroupService.getListClientGroup(clientGroup);
		
		model.addAttribute(client);
		model.addAttribute(clientGroupList);
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
	public Map<String, Object> insert(HttpServletRequest request, Client client) {
		log.info("@@@@@@@@@@ client = {}", client);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			// 1.폼 체크
			client.setMethod_mode("insert");
			String errorcode = clientValidate(client);
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				log.info("validate error 발생: {} " ,map.toString());
				return map;
			}
			// 2.의도적인 접근 체크	
			log.info("generate_api_key_check: {} " ,client.getGenerate_api_key_check());
			if(!"1".equals(client.getGenerate_api_key_check())) {
				result = "client.input.invalid";
				log.info("의도적인 접근 발생: {} " ,map.toString());
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
	
	private String clientValidate(Client client) {
		if("insert".equals(client.getMethod_mode())) {
			if(client.getClient_group_id() == null || client.getClient_group_id().longValue() <= 0) {
				return "client.group.id.invalid";
			}
			if(client.getClient_name() == null || client.getClient_ip() == null) {
				return "client.input.invalid";
			}
			if(client.getApi_key() == null) {
				return "client.apikey.invalid";
			}
		}
		return null;
	}
	
	/**
	 * api key 생성
	 * @param request
	 * @return
	 */
	@PostMapping("/client/api-keys")
	@ResponseBody
	public Map<String, Object> generateApiKey(HttpServletRequest request) {		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String apikey = "";	
		try {
			apikey = clientService.generateApikey();
			log.info("@@@@@@@@@@ apikey = {}", apikey);
		} catch(Exception e) {
			e.printStackTrace();
			result = "exception";
		}
		map.put("result", result);
		map.put("apikey", apikey);

		return map;
	}
}
