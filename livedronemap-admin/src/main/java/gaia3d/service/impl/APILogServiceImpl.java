package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.APILog;
import gaia3d.persistence.APILogMapper;
import gaia3d.service.APILogService;

@Service
public class APILogServiceImpl implements APILogService {

	@Autowired
	private APILogMapper aPILogMapper;
	
	/**
	 * api log 개수 조회 
	 * @param aPILog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getAPILogTotalCount(APILog aPILog) {
		return aPILogMapper.getAPILogTotalCount(aPILog);
	}
	
	/**
	 * api log 조회 
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<APILog> getListAPILog(APILog aPILog) {
		return aPILogMapper.getListAPILog(aPILog);
	}

	/**
	 * api log 등록
	 * @param aPILog
	 * @return
	 */
	@Transactional
	public int insertAPILog(APILog aPILog) {
		return aPILogMapper.insertAPILog(aPILog);
	}
}
