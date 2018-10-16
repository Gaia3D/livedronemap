package gaia3d.service.impl;

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
	 * api key를 이용하여 client 정보를 취득
	 * @param api_key
	 * @return
	 */
	@Transactional(readOnly=true)
	public Client getClientByAPIKey(String api_key) {
		return clientMapper.getClientByAPIKey(api_key);
	}

	/**
	 *  ID를 이용하여 client 정보 취득
	 *  @param client_id
	 *  @return
	 */
	@Override
	public Client getClientByClientId(int client_id) {
		return clientMapper.getClientByClientId(client_id);
	}
	
	
}
