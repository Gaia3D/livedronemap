package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.APILog;

@Repository
public interface APILogMapper {

	/**
	 * api log 등록
	 * @param aPILog
	 * @return
	 */
	public APILog insertAPILog(APILog aPILog);
}
