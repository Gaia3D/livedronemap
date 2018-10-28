package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class APILog extends SearchFilter {
	
	// 고유키
	private Long api_log_id;
	// client 고유키
	private Integer client_id;
	// client 명(중복 허용)
	private String client_name;
	// request ip
	private String request_ip;
	// 사용자 아이디
	private String user_id;
	// url
	private String url;
	// http status code
	private Integer status_code;
	// message
	private String message;
	private String insert_date;
	
	public String getViewInsert_date() {
		if(this.insert_date == null || "".equals(insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
	
}
