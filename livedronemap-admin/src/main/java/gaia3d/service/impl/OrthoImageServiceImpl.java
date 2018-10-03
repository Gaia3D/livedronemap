package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.OrthoImage;
import gaia3d.persistence.OrthoImageMapper;
import gaia3d.service.OrthoImageService;

@Service
public class OrthoImageServiceImpl implements OrthoImageService {

	@Autowired
	private OrthoImageMapper orthoImageMapper;

	/**
	 * 개별 정사 영상 등록
	 * @param orthoImage
	 * @return
	 */
	@Transactional
	public int insertOrthoImage(OrthoImage orthoImage) {
		return orthoImageMapper.insertOrthoImage(orthoImage);
	}
}
