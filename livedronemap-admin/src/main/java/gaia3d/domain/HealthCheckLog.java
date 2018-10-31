package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 상태 점검 이력
 * @author jskim
 *
 */
@Getter
@Setter
@ToString(callSuper=true)
public class HealthCheckLog extends SearchDomain {
	
	// 상태 점검 이력 ID
	private Long health_check_log_id;
	// client 고유키
	private Integer client_id;
	// client명(중복)
	private String client_name;
	// 상태 점검 상태 
	private String status;
	// HTTP 응답 코드 
	private Integer status_code;
	// 상세 메세지
	private String message;
	// 시뮬레이션 등록일 
	private String insert_date;
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
