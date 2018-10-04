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
	private String image_datetime;
	
	// 프로젝트 ID 
	private Integer project_id;
	
	// 영상 종류 구분, 0 개별 정사 영상, 1 후처리
	private String data_type;
}
