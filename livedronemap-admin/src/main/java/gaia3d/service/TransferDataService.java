package gaia3d.service;

import gaia3d.domain.FileInfo;
import gaia3d.domain.TransferDataResource;

/**
 * transfer data
 * @author Cheon JeongDae
 *
 */
public interface TransferDataService {

	/**
	 * transfer data insert
	 * @param fileInfo
	 * @param transferDataResource
	 * @return
	 */
	int insertTransferData(FileInfo fileInfo, TransferDataResource transferDataResource);
	
}
