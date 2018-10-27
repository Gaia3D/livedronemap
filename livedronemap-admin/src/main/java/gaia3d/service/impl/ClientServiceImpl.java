package gaia3d.service.impl;

import java.util.UUID;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.Client;
import gaia3d.persistence.ClientMapper;
import gaia3d.service.ClientService;

@Service
public class ClientServiceImpl implements ClientService {

	@Autowired
	private ClientMapper clientMapper;

	/**
	 *  ID를 이용하여 client 정보 취득
	 *  @param client_id
	 *  @return
	 */
	@Transactional(readOnly=true)
	public Client getClient(int client_id) {
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
	 *  client 리스트 조회 
	 *  @return
	 */
	@Transactional(readOnly=true)
	public List<Client> getClientList() {
		return clientMapper.getClientList();
	}

	
	/**
	 * API key 발행
	 * @return
	 */
	public String generateApikey() {
		return UUID.randomUUID().toString();
		//return Long.toString(System.nanoTime()).substring(4, 12);
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
