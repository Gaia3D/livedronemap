package gaia3d.domain;

import lombok.Data;

@Data
public class FileInfo {

	// validation
	private String error_code;
	

	/************ 테이블 ***********/
	// 고유번호
	private Long file_info_id;
	// 사용자 아이디
	private String user_id;
	// 업무 타입
	private String job_type;
	// 파일 이름
	private String file_name;
	// 파일 실제 이름
	private String file_real_name;
	// 파일 경로
	private String file_path;
	// 파일 사이즈
	private String file_size;
	// 파일 확장자
	private String file_ext;
	// 등록일
	private String insert_date;
	
	
	public String getViewInsertData() {
		if(this.insert_date == null || "".equals(insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
	
}
