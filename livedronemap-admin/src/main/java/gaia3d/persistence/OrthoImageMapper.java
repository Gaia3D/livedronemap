package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.OrthoImage;

/**
 * @author Cheon JeongDae
 *
 */
@Repository
public interface OrthoImageMapper {

	/**
	 * @param orthoImage
	 * @return
	 */
	int insertOrthoImage(OrthoImage orthoImage);
	
	/**
	 * @param orthoImage
	 * @return
	 */
	int updateOrthoImage(OrthoImage orthoImage);
	
}
