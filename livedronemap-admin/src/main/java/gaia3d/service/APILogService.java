package gaia3d.service;

import gaia3d.domain.APILog;

public interface APILogService {

	/**
	 * api log 등록
	 * @param aPILog
	 * @return
	 */
	int insertAPILog(APILog aPILog);
}
