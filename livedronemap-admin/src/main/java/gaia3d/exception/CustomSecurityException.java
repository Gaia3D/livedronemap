package gaia3d.exception;

/**
 * 암호화 오류
 * @author Cheon JeongDae
 *
 */
public class CustomSecurityException extends RuntimeException {

	private static final long serialVersionUID = -1249512759746831800L;
	
	public CustomSecurityException(String message) {
		super(message);
	}
	
	public CustomSecurityException(Throwable throwable) {
		super(throwable);
	}
	
	public CustomSecurityException(String message, Throwable throwable) {
		super(message, throwable);
	}
}
