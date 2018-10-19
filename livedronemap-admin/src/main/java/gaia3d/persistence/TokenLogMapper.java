package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.TokenLog;

/**
 * @author Cheon JeongDae
 *
 */
@Repository
public interface TokenLogMapper {

	/**
	 * 토근 로그 취득
	 * @param tokenLog
	 * @return
	 */
	TokenLog getTokenLog(TokenLog tokenLog);
	
	/**
	 * 토큰 로그 리스트 조회 
	 * @param tokenLog
	 * @return
	 */
	List<TokenLog> getListTokenLog(TokenLog tokenLog);
	
	/**
	 * token validation
	 * @param tokenLog
	 * @return
	 */
	TokenLog getValidToken(TokenLog tokenLog);
	
	/**
	 * 토근 이력 등록
	 * @param tokenLog
	 * @return
	 */
	int insertTokenLog(TokenLog tokenLog);
	
	/**
	 * token expires update
	 * @param tokenLog
	 * @return
	 */
	TokenLog updateTokenExpires(TokenLog tokenLog);

	/**
	 * token 로그 개수 조회
	 * @param tokenLog
	 * @return
	 */
	Long getTokenLogCount(TokenLog tokenLog);
}
