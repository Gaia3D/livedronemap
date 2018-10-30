package gaia3d.service;

import java.util.List;

import gaia3d.domain.Client;

public interface ClientService {

	/**
	 *  client 리스트 조회 
	 *  @return
	 */
	 List<Client> geListClient();
	
	/**
	 *  ID를 이용하여 client 정보 취득
	 *  @param client_id
	 *  @return
	 */
	 Client getClient(Integer client_id);
	
	/**
	 * api key를 이용하여 client 정보를 취득
	 * @param api_key
	 * @return
	 */
	 Client getClientByAPIKey(String api_key);
	
	/**
	 * API key 발행
	 * @return
	 */
	 String generateApikey();
	 	
	/**
	 * client 등록
	 * @param client
	 * @return
	 */
	 int insertClient(Client client);
}
