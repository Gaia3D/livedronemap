package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.TransferData;

/**
 * @author Cheon JeongDae
 *
 */
@Repository
public interface TransferDataMapper {

	/**
	 * all list transfer data by drone_project_id
	 * @param drone_project_id
	 * @return
	 */
	List<TransferData> getListTransferData(Integer drone_project_id);

	/**
	 * count of total transfer data
	 * @param drone_project_id
	 * @return
	 */
	int getTransferDataCount(Integer drone_project_id);
	
	/**
	 * transfer data insert
	 * @param transferData
	 * @return
	 */
	int insertTransferData(TransferData transferData);
	
	/**
	 * transfer data update
	 * @param transferData
	 * @return
	 */
	int updateTransferData(TransferData transferData);

	
}
