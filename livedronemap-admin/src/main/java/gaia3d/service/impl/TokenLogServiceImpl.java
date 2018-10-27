package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.TokenLog;
import gaia3d.persistence.TokenLogMapper;
import gaia3d.service.TokenLogService;

@Service
public class TokenLogServiceImpl implements TokenLogService {

	@Autowired
	private TokenLogMapper tokenLogMapper;
	
	/**
	 * token 정보를 취득
	 * @param api_key
	 * @return
	 */
	@Transactional
	public TokenLog getToken(TokenLog tokenLog) {
		tokenLog.setToken(generateToken());
		tokenLogMapper.insertTokenLog(tokenLog);
		return tokenLog;
	}

	/**
	 * 토큰 로그 리스트 조회 
	 * @param tokenLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<TokenLog> getListTokenLog(TokenLog tokenLog) {
		return tokenLogMapper.getListTokenLog(tokenLog);
	}
	
	/**
	 * 토근 로그 취득
	 * @param tokenLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public TokenLog getTokenLog(TokenLog tokenLog) {
		return tokenLogMapper.getTokenLog(tokenLog);
	}
	
	/**
	 * token validation
	 * @param tokenLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public TokenLog getValidToken(TokenLog tokenLog) {
		return tokenLogMapper.getValidToken(tokenLog);
	}
	
	/**
	 * token 발행
	 * @return
	 */
	private String generateToken() {
		//return UUID.randomUUID().toString();
		return Long.toString(System.nanoTime()).substring(4, 12);
	}
	
	/**
	 * token expires update
	 * @param tokenLog
	 * @return
	 */
	@Transactional
	public TokenLog updateTokenExpires(TokenLog tokenLog) {
		return tokenLogMapper.updateTokenExpires(tokenLog);
	}

	/**
	 * token 로그 개수 조회
	 * @param tokenLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getTokenLogTotalCount(TokenLog tokenLog) {
		return tokenLogMapper.getTokenLogTotalCount(tokenLog);
	}

}
