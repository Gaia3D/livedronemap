package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.APILog;
import gaia3d.persistence.APILogMapper;

@Service
public class APILogServiceImpl {

	@Autowired
	private APILogMapper aPILogMapper;
	
	/**
	 * api log 등록
	 * @param aPILog
	 * @return
	 */
	@Transactional(readOnly=true)
	public APILog insertAPILog(APILog aPILog) {
		return aPILogMapper.insertAPILog(aPILog);
	}
}
