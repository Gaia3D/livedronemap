package gaia3d.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.PGStatActivity;
import gaia3d.persistence.MonitoringMapper;
import gaia3d.service.MonitoringService;

/**
 * postgresql 현황
 * @author jeongdae
 *
 */
@Service
public class MonitoringServiceImpl implements MonitoringService {
	
	@Autowired
	private MonitoringMapper monitoringMapper;
	
	/**
	 * DB 세션 목록
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<PGStatActivity> getListDBSession() {
		List<PGStatActivity> dbSessionList =  monitoringMapper.getListDBSession();
		if(dbSessionList == null) dbSessionList = new ArrayList<>();
		return dbSessionList;
	}
}
