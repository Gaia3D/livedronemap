package gaia3d.service;

import java.util.List;

import gaia3d.domain.TokenLog;

public interface TokenLogService {

	/**
	 * token 로그 총 건수
	 * @param tokenLog
	 * @return
	 */
	Long getTokenLogTotalCount(TokenLog tokenLog);
	
	/**
	 * 토큰 로그 목록
	 * @param tokenLog
	 * @return
	 */
	List<TokenLog> getListTokenLog(TokenLog tokenLog);
	
	/**
	 * 토근 생성
	 * @param tokenLog
	 * @return
	 */
	TokenLog getToken(TokenLog tokenLog);
	
	/**
	 * token validation
	 * @param tokenLog
	 * @return
	 */
	TokenLog getValidToken(TokenLog tokenLog);
	
	/**
	 * 토근 로그 취득
	 * @param tokenLog
	 * @return
	 */
	TokenLog getTokenLog(TokenLog tokenLog);
	
	/**
	 * token expires update
	 * @param tokenLog
	 * @return
	 */
	TokenLog updateTokenExpires(TokenLog tokenLog);
}
