package gaia3d.service;

import gaia3d.persistence.ImageInfo;

/**
 * 이미지 변환 인터페이스 
 * @author Kim JeaSeon
 *
 */
public interface ImageConverterService {
	
	public void createConvertedImage(ImageInfo imageInfo);
	
}
