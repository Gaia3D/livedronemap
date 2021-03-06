package gaia3d.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 데이터 전송 관련 처리를 담당
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class TransferDataResource implements Serializable {

	private static final long serialVersionUID = -509511198494213847L;
	
	// 개별 정사 영상
	public static final String ORTHO_IMAGE = "0";
	// 후처리 영상
	public static final String POSTPROCESSING_IMAGE = "1";

	private Integer drone_project_id;
	// 0 : 개별 정사 영상, 1 : 후처리 영상
	private String data_type;
	private String file_name;
	private List<OrthoDetectedObject> detected_objects;
	private Drone drone;
	private String shooting_date;
}
