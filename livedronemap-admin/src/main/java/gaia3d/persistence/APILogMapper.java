package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.APILog;

@Repository
public interface APILogMapper {

	/**
	 * api log 등록
	 * @param aPILog
	 * @return
	 */
	public int insertAPILog(APILog aPILog);
	
	/**
	 * api log 조회 
	 * @return
	 */
	public List<APILog> getListAPILog(APILog aPILog);

	/**
	 * api log 개수 조회 
	 * @param aPILog
	 * @return
	 */
	public Long getAPILogTotalCount(APILog aPILog);
}
