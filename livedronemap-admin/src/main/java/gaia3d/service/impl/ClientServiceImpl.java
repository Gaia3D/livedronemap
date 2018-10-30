package gaia3d.service.impl;

import java.util.UUID;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.context.config.*;
import org.springframework.test.context.ActiveProfiles; 
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.Assert.*;
import gaia3d.domain.Client;
import gaia3d.persistence.ClientMapper;
import gaia3d.service.ClientService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ClientServiceImpl implements ClientService {

	private int count = 0;
	@Autowired
	private ClientMapper clientMapper;
	
	public ClientService clientService;
	
	/**
	 *  client 리스트 조회 
	 *  @return
	 */
	@Transactional(readOnly=true)
	public List<Client> geListClient() {
		return clientMapper.geListClient();
	}
	
	/**
	 *  ID를 이용하여 client 정보 취득
	 *  @param client_id
	 *  @return
	 */
	@Transactional(readOnly=true)
	public Client getClient(Integer client_id) {
		return clientMapper.getClient(client_id);
	}	
	
	/**
	 * api key를 이용하여 client 정보를 취득
	 * @param api_key
	 * @return
	 */
	@Transactional(readOnly=true)
	public Client getClientByAPIKey(String api_key) {
		return clientMapper.getClientByAPIKey(api_key);
	}
	
	/**
	 * API key 발행
	 * @return
	 */
	public String generateApikey() {
		// 1. 생성
		String apiKey = UUID.randomUUID().toString();
//		log.info("@@@@@@@@@@ apiKey = {}", apiKey);
		// 2. DB 조회
		int apikeyCount = clientMapper.getClientByAPIKeyTotalCount(apiKey);
		// 3. 중복여부 판단
		if (apikeyCount != 0) {
			log.info("@@@@@@@@@@ apiKey duplication");
			generateApikey();
		}
		return apiKey;
	}
		
	/**
	 * client 등록
	 * @param client
	 * @return
	 */
	@Transactional
	public int insertClient(Client client) {
		return clientMapper.insertClient(client);
	}	
}