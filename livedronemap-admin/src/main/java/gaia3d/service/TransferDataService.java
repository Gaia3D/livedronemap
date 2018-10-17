package gaia3d.service;

import java.util.List;

import gaia3d.domain.FileInfo;
import gaia3d.domain.TransferData;
import gaia3d.domain.TransferDataResource;

/**
 * transfer data
 * @author Cheon JeongDae
 *
 */
public interface TransferDataService {
	
	/**
	 * all list transfer data by drone_project_id
	 * @param drone_project_id
	 * @return
	 */
	List<TransferData> getListTransferData(Integer drone_project_id);

	/**
	 * transfer data insert
	 * @param fileInfo
	 * @param transferDataResource
	 * @return
	 */
	int insertTransferData(FileInfo fileInfo, TransferDataResource transferDataResource);
	
}
