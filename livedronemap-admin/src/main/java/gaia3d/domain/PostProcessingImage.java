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
public class PostProcessingImage extends FileInfo {

	// 고유번호
	private Long postprocessing_image_id;
	// 전송 데이터 고유번호
	private Long transfer_data_id;
	// 파일 유형(이건 없는게 맞는거 같음)
	private String file_type;
	// 상태. 0 : 전송 완료
	private String status;
}
