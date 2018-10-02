package gaia3d.exception;

/**
 * GeoServer RestAPI 호출 오류 
 * @author Cheon JeongDae
 *
 */
public class GeoserverException extends RuntimeException{

	private static final long serialVersionUID = 5830350872315076072L;

	public GeoserverException(String message) {
		super(message);
	}
	
	public GeoserverException(Throwable throwable) {
		super(throwable);
	}
	
	public GeoserverException(String message, Throwable throwable) {
		super(message, throwable);
	}
	
}
