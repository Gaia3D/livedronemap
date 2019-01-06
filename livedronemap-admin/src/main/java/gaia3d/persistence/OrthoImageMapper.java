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
	 * get transfer data id using ortho image id
	 * @param ortho_image_id
	 * @return
	 */
	Long selectTransferDataId(Long ortho_image_id);
	
	/**
	 * @param orthoImage
	 * @return
	 */
	int updateOrthoImage(OrthoImage orthoImage);

}
