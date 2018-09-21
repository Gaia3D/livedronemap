package gaia3d.service;

import gaia3d.domain.TokenLog;

public interface TokenLogService {

	/**
	 * 토근 생성
	 * @param tokenLog
	 * @return
	 */
	TokenLog getToken(TokenLog tokenLog);
	
	/**
	 * 토근 로그 취득
	 * @param tokenLog
	 * @return
	 */
	TokenLog getTokenLog(TokenLog tokenLog);
}
