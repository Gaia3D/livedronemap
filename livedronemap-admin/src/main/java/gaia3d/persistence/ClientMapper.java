package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.Client;

/**
 * @author Cheon JeongDae
 *
 */
@Repository
public interface ClientMapper {

	/**
	 * client 정보를 취득
	 * @param client_id
	 * @return
	 */
	Client getClient(int client_id);
	
	/**
	 * client 정보를 취득
	 * @param api_key
	 * @return
	 */
	Client getClientByAPIKey(String api_key);
	
	/**
	 * client 등록
	 * @param client
	 * @return
	 */
	int insertClient(Client client);
	
}
