package gaia3d.service;

import gaia3d.domain.Client;

public interface ClientService {

	/**
	 * api key를 이용하여 client 정보를 취득
	 * @param api_key
	 * @return
	 */
	Client getClientByAPIKey(String api_key);
}
