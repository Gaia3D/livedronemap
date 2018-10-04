package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.PostProcessingImage;
import gaia3d.persistence.PostProcessingImageMapper;
import gaia3d.service.PostProcessingImageService;

@Service
public class PostProcessingImageServiceImpl implements PostProcessingImageService {

	@Autowired
	private PostProcessingImageMapper postProcessingImageMapper;

	/**
	 * 후처리 영상 등록
	 * @param postProcessingImage
	 * @return
	 */
	@Transactional
	public int insertPostProcessingImage(PostProcessingImage postProcessingImage) {
		return postProcessingImageMapper.insertPostProcessingImage(postProcessingImage);
	}
	
	/**
	 * 후처리 영상 수정
	 * @param postProcessingImage
	 * @return
	 */
	@Transactional
	public int updatePostProcessingImage(PostProcessingImage postProcessingImage) {
		return postProcessingImageMapper.updatePostProcessingImage(postProcessingImage);
	}
}
