package gaia3d.service;

import gaia3d.domain.APIResult;
import gaia3d.domain.ImageInfo;

/**
 * 이미지 변환 인터페이스 
 * @author Kim JeaSeon
 *
 */
public interface ImageConverterService {
	
	public APIResult createConvertedImage(ImageInfo imageInfo);
	
}
