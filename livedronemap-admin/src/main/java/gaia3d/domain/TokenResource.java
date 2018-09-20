package gaia3d.domain;

import java.io.Serializable;
import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TokenResource implements Serializable {

	private static final long serialVersionUID = 7982725571387538868L;
	
	private String user_id;
	private String api_key;
	
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDate expire_time;

	private String role;
}
