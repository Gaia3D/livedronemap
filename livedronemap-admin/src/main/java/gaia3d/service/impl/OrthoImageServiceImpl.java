package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.OrthoImage;
import gaia3d.domain.TransferData;
import gaia3d.persistence.OrthoImageMapper;
import gaia3d.persistence.TransferDataMapper;
import gaia3d.service.OrthoImageService;

@Service
public class OrthoImageServiceImpl implements OrthoImageService {

	@Autowired
	private OrthoImageMapper orthoImageMapper;
	@Autowired
	private TransferDataMapper transferDataMapper;

	/**
	 * 개별 정사 영상 등록
	 * @param orthoImage
	 * @return
	 */
	@Transactional
	public int insertOrthoImage(OrthoImage orthoImage) {
		return orthoImageMapper.insertOrthoImage(orthoImage);
	}
	
	/**
	 * 개별 정사 영상 수정
	 * @param orthoImage
	 * @return
	 */
	@Transactional
	public int updateOrthoImage(OrthoImage orthoImage) {
		
		int result = orthoImageMapper.updateOrthoImage(orthoImage);
		
		Long transferDataId = orthoImageMapper.selectTransferDataId(orthoImage.getOrtho_image_id());
		TransferData transferData = new TransferData();
		transferData.setTransfer_data_id(transferDataId);
		transferData.setStatus(orthoImage.getStatus());
		transferDataMapper.updateTransferData(transferData);
		
		return result;
	}
}
