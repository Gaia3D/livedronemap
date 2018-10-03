package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.TransferData;

/**
 * @author Cheon JeongDae
 *
 */
@Repository
public interface TransferDataMapper {

	/**
	 * transfer data insert
	 * @param transferData
	 * @return
	 */
	int insertTransferData(TransferData transferData);
	
}
