package gaia3d.service.impl;

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
	 * api log 등록
	 * @param aPILog
	 * @return
	 */
	@Transactional
	public int insertAPILog(APILog aPILog) {
		return aPILogMapper.insertAPILog(aPILog);
	}
}
