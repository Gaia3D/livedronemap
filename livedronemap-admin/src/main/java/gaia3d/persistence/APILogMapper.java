package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.APILog;

@Repository
public interface APILogMapper {

	/**
	 * api log 개수 조회 
	 * @param aPILog
	 * @return
	 */
	Long getAPILogTotalCount(APILog aPILog);

	/**
	 * api log 조회 
	 * @return
	 */
	List<APILog> getListAPILog(APILog aPILog);
	
	/**
	 * api log 등록
	 * @param aPILog
	 * @return
	 */
	int insertAPILog(APILog aPILog);
}
