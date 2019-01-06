package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.ClientGroup;
import gaia3d.persistence.ClientGroupMapper;
import gaia3d.service.ClientGroupService;

@Service
public class ClientGroupServiceImpl implements ClientGroupService {

	@Autowired
	private ClientGroupMapper clientGroupMapper;

	/**
	 *  ID를 이용하여 client group 정보 취득
	 *  @param client_group_id
	 *  @return
	 */
	@Transactional(readOnly=true)
	public ClientGroup getClientGroup(Integer client_group_id) {
		return clientGroupMapper.getClientGroup(client_group_id);
	}
	
	/**
	 * client group 목록
	 * 
	 * @param client group
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<ClientGroup> getListClientGroup(ClientGroup clientgroup) {
		return clientGroupMapper.getListClientGroup(clientgroup);
	}
	
	
}
