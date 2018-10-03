package gaia3d.service;

import gaia3d.domain.PostProcessingImage;

/**
 * 후처리 영상
 * @author Cheon JeongDae
 *
 */
public interface PostProcessingImageService {

	/**
	 * @param postProcessingImage
	 * @return
	 */
	int insertPostProcessingImage(PostProcessingImage postProcessingImage);
	
}
