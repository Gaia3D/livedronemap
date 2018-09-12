package gaia3d.domain;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class ProjectException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6272893742050516466L;

	public ProjectException(Long project_id) {
		super(" not found " + project_id);
	}
}
