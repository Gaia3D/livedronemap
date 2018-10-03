package gaia3d.service;

import gaia3d.domain.OrthoImage;

/**
 * 개별 정사 영상
 * @author Cheon JeongDae
 *
 */
public interface OrthoImageService {

	/**
	 * @param orthoImage
	 * @return
	 */
	int insertOrthoImage(OrthoImage orthoImage);
	
}
