package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ImageInfo {
		
	private Long projectId;
	
	private Long imageId;
	
	// 절대 경로
	private String imagePath;
	
	// 2018-10-01 09:00:00.000 
	private String imageDt;
	
}
