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
public class OrthoImage extends FileInfo {

	// 고유번호
	private Long ortho_image_id;
	// 전송 데이터 고유번호
	private Long transfer_data_id;
	// 상태. 0 : 전송 완료
	private String status;
}
