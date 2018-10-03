package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.OrthoDetectedObject;

/**
 * @author Cheon JeongDae
 *
 */
@Repository
public interface OrthoDetectedObjectMapper {

	/**
	 * @param orthoDetectedObject
	 * @return
	 */
	int insertOrthoDetectedObject(OrthoDetectedObject orthoDetectedObject);
	
}
