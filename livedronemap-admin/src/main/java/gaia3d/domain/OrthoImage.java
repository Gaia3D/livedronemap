package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class OrthoImage {

	// 고유번호
	private Long ortho_image_id;
	// 전송 데이터 고유번호
	private Long transfer_data_id;
	// 사용자 아이디
	private String user_id;
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
	// 상태. 0 : 전송 완료, 1 : 이미지 후처리 완료
	private String status;
	// 등록일
	private String insert_date;
}
