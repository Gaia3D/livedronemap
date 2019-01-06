package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.Client;

/**
 * @author Cheon JeongDae
 *
 */
@Repository
public interface ClientMapper {
	
	/**
	 * 해당 api_Key를 포함한 client 총 건수
	 * @param api_key
	 * @return
	 */
	Integer getClientByAPIKeyTotalCount(String api_key);

	/**
	 *  client 리스트 조회 
	 *  @return
	 */
	 List<Client> getListClient();
	
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
