package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 내부용 Rest API 응답용 도메인 
 * @author Kim Jeaseon
 *
 */
@Getter
@Setter
@ToString
public class PrivateAPIResult {
	
	// result
	private String result;
	// http status code
	private int statusCode;
	// error message 
	private String message;
	
}
