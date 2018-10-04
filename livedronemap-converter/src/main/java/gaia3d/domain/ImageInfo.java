package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ImageInfo {
		
	private Integer projectId;
	
	private Long imageId;
	
	// 0 개별 정사 영상, 1 후처리
	private String dataType;
	
	// 절대 경로
	private String imagePath;
	
	// 2018-10-01 09:00:00.000 
	private String imageDatetime;
	
}
