package gaia3d.security;

/**
 * @author Cheon JeongDae
 *
 */
public interface JWTEncryption {

	/**
	 * @param privateKey
	 * @param secretKey
	 * @param receivedValue
	 * @return
	 */
	boolean verify(String privateKey, String secretKey, String receivedValue);
}
