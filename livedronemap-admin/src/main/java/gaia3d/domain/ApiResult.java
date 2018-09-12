package gaia3d.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApiResult implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -64139596070084106L;
	
	//	timestamp
//	status : 401
//	error : Unauthorized
//	exception : xxxException
//	message : Unauthorized
	private int statusCode;
	private String reasonPhrase;
	private String error;
	private String exception;
	private String message;
	private String documentationUrl;
}
