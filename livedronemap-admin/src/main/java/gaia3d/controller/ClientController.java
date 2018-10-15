package gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import gaia3d.domain.Client;
import gaia3d.service.ClientService;
import gaia3d.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ClientController {
	
	@Autowired
	private ClientService clientService;

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
}
