package gaia3d.service;

import gaia3d.domain.OrthoDetectedObject;

/**
 * 객체 탐지
 * @author Cheon JeongDae
 *
 */
public interface OrthoDetectedObjectService {

	/**
	 * @param orthoDetectedObject
	 * @return
	 */
	int insertOrthoDetectedObject(OrthoDetectedObject orthoDetectedObject);
	
}
