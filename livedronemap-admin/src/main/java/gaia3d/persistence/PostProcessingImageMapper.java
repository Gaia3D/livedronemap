package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.PostProcessingImage;

/**
 * @author Cheon JeongDae
 *
 */
@Repository
public interface PostProcessingImageMapper {

	/**
	 * @param postProcessingImage
	 * @return
	 */
	int insertPostProcessingImage(PostProcessingImage postProcessingImage);
	
}
