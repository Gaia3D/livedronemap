package gaia3d.service;

import java.util.List;

import gaia3d.domain.APILog;

public interface APILogService {

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
	
	/**
	 * 오류 메세지 조회 
	 * @param api_log_id
	 * @return
	 */
	String getLogMessage(Integer api_log_id);
}
