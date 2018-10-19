package gaia3d.service;

import java.util.List;

import gaia3d.domain.ClientGroup;

public interface ClientGroupService {

	/**
	 *  ID를 이용하여 client group 정보 취득
	 *  @param client_group_id
	 *  @return
	 */
	ClientGroup getClientGroup(int client_group_id);
	
	/**
	 * client group 목록
	 * 
	 * @param client group
	 * @return
	 */
	List<ClientGroup> getListClientGroup(ClientGroup clientgroup);
}
