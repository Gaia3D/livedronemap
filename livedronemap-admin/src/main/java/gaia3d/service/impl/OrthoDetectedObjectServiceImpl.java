package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.OrthoDetectedObject;
import gaia3d.persistence.OrthoDetectedObjectMapper;
import gaia3d.service.OrthoDetectedObjectService;

@Service
public class OrthoDetectedObjectServiceImpl implements OrthoDetectedObjectService {

	@Autowired
	private OrthoDetectedObjectMapper orthoDetectedObjectMapper;

	/**
	 * 객체 탐지 등록
	 * @param orthoDetectedObject
	 * @return
	 */
	@Transactional
	public int insertOrthoDetectedObject(OrthoDetectedObject orthoDetectedObject) {
		return orthoDetectedObjectMapper.insertOrthoDetectedObject(orthoDetectedObject);
	}
}
