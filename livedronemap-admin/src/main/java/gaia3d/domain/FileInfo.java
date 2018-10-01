package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 파일 관리
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class FileInfo {
	
	// validation
	private String error_code;
	
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
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
