package gaia3d.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * token log
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class TokenLog {

	// 고유키
	private Integer token_log_id;
	// client 고유키
	private Integer client_id;
	// 사용자 아이디
	private String user_id;
	// 토큰
	private String token;
	// 토큰 상태. 토큰 상태. 0 : 사용중, 1 : 시간만료
	private String token_status;
	// 토근 유효 시간
	private Integer rest_api_token_max_age;
	// 토큰 지속 시간. 240분(기본값)
	private Date expires;
	// 년
	private String year;
	// 월
	private String month;
	// 일
	private String day;
	// 일년중 몇주
	private String year_week;
	// 이번달 몇주
	private String week;
	// 시간
	private String hour;
	// 분
	private String minute;
	// 수정일
	private String update_date;
	// 등록일
	private String insert_date;
}
