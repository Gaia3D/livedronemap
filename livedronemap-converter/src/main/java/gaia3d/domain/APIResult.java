package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class APIResult {
	
	private String result;
	
	private int statusCode;
	
	private String message;
	
}
