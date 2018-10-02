package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ImageMosaic {
	
	private int fid;
	
	// 파일 위치. 프로젝트ID/영상명
	private String location;
	
	// 영상 바운더리. WKT
	private String the_geom;
	
	// 영상 촬영일시 
	private String image_dt;
	
	// 프로젝트 ID 
	private Integer project_id;
	
}
