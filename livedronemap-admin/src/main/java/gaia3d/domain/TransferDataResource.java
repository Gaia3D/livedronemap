package gaia3d.domain;

import java.io.Serializable;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

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

	private Integer drone_project_id;
	private String data_type;
	private String file_name;
	private List<OrthoDetectedObject> detected_objects;
	private Drone drone;
	private String shooting_date;
	
	/**
	 * 무시하기 위해
	 */
	@JsonIgnore
	private MultipartFile file;
}
