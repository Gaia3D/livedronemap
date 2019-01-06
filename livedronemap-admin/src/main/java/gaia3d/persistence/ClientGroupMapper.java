package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.ClientGroup;

/**
 * @author jwpark
 *
 */
@Repository
public interface ClientGroupMapper {

	/**
	 * client group 정보를 취득
	 * @param client_group_id
	 * @return
	 */
	ClientGroup getClientGroup(int client_group_id);
	
	/**
	 * client group 목록
	 * @param ClientGroup
	 * @return
	 */
	List<ClientGroup> getListClientGroup(ClientGroup clientgroup);		
	
}
