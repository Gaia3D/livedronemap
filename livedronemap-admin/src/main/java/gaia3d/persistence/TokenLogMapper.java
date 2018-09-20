package gaia3d.persistence;

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
	 * 토근 이력 등록
	 * @param tokenLog
	 * @return
	 */
	TokenLog insertTokenLog(TokenLog tokenLog);
}
