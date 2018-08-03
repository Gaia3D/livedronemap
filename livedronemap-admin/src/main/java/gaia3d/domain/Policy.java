package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Policy {
	public static final String Y = "Y";
	
	// 업로딩 가능 확장자. 3ds,obj,ifc,dae 등
	private String user_upload_type = "js, css, jpg, 3ds, obj, dae, ifc, 3DS, OBJ, DAE, IFC, txt, JPG, PNG, png";
	// 최대 업로딩 사이즈(단위M). 기본값 500M
	private Long user_upload_max_filesize = 500000l;
	// 1회, 최대 업로딩 파일 수. 기본값 50개
	private Integer user_upload_max_count= 20;	
	
		
	// 등록일
	private String insert_date;
	
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
