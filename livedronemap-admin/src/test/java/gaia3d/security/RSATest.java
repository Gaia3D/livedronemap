package gaia3d.security;

import static org.junit.Assert.*;

import java.security.*;
import java.security.Security;
import java.security.spec.RSAPrivateKeySpec;
import java.security.spec.RSAPublicKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;

import org.apache.commons.codec.binary.Base64;
import org.junit.Ignore;
import org.junit.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RSATest {

	@Test
	public void createKey() throws Exception {
		
		//SecureRandom secureRandom = new SecureRandom();
		KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        //keyPairGenerator.initialize(2048, secureRandom);
        keyPairGenerator.initialize(512);
        
        KeyPair keyPair = keyPairGenerator.genKeyPair();
        Key publicKey = keyPair.getPublic();
        Key privateKey = keyPair.getPrivate();
        
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        RSAPublicKeySpec rSAPublicKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
        RSAPrivateKeySpec rSAPrivateKeySpec = keyFactory.getKeySpec(privateKey, RSAPrivateKeySpec.class);
        
        byte[] bPublicKey1 = publicKey.getEncoded();
        String encodedPublicKey = Base64.encodeBase64String(bPublicKey1);

        byte[] bPrivateKey1 = privateKey.getEncoded();
        String encodedPrivateKey = Base64.encodeBase64String(bPrivateKey1);

        log.info("@@@@@@@@@ public key = {}", encodedPublicKey);
        log.info("@@@@@@@@@ private key = {}", encodedPrivateKey);
	}
	
	@Ignore
	public void createKeyFromString() throws Exception {
		// 오류남
		
		String encodedPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA84HdUDSa9SPH4rbiYhv5+gmYwq+LdTXD0CFecnUQ/32qhVkK71uWysxCookgSCHDqPJg9cot+WZgoUt5Pk/K9ObHWyptsOh0zRhu9nkOnFcJUzL4ehp0SloWEwtq1I1rLX9XN3oTaDK0yi9wIsAy1T4ZzpT+EhlDpFEImMXldOT0E3ubqjqc5Ozhs2PBgkZehfEc2VLPnfyDA04Xejo4sO8O1XAQE6tB1orTw17ICQDDH4oB3sQBZuZRBuywMzPNPb99byb+0kXeRoB4fDQwcKMvxRAXb51KZFvsyey4Jak/qdWsB0BcYa2ZONSSH3HhlarxesEPW1t57pst98YAkQIDAQAB";
		String encodedPrivateKey = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDzgd1QNJr1I8fituJiG/n6CZjCr4t1NcPQIV5ydRD/faqFWQrvW5bKzEKiiSBIIcOo8mD1yi35ZmChS3k+T8r05sdbKm2w6HTNGG72eQ6cVwlTMvh6GnRKWhYTC2rUjWstf1c3ehNoMrTKL3AiwDLVPhnOlP4SGUOkUQiYxeV05PQTe5uqOpzk7OGzY8GCRl6F8RzZUs+d/IMDThd6Ojiw7w7VcBATq0HWitPDXsgJAMMfigHexAFm5lEG7LAzM809v31vJv7SRd5GgHh8NDBwoy/FEBdvnUpkW+zJ7LglqT+p1awHQFxhrZk41JIfceGVqvF6wQ9bW3numy33xgCRAgMBAAECggEALMqLghBbHJJ7Vxma5L8OqU6QmeceeO3t2d/5doZQHR7peePaHhMz1pPiAfHFTV9glTgYW73X3RNW3PR8FdkplQjKTNuuF6d6rKs85ft4k4ty/KnYiOVK1M5jVxd3jCeDOng8+8hpv3XsSXCWaN3/u7fTmWtQnNWm2pfJRAjK30hOPFAlNUclpqXn4IbQFHe4sQnRP1ClTSDB+eQy33DOe7YJMMPvtqYu9kZJNxkPVtElbJbb8I+QxBxq9tgjYkZNqraJXWe2phw61cwd8spcA8AYbkRImUJ7ZEFqEueFGvK8rPi+++VKh09GSADvI7QYt+YLE62dZzaAcUJPDOMWPQKBgQD9XHItysOuGUPRwwg3ByF7Pp1MKzx5sS67+rAtBA+48JdPvJcIFzFpdi13+AnwRKtZBu0LxMOqlLyfVzLnoCug1oCxnUJVPLLwxTGe6PFGgb1nxtFgtQ1fkgrWven+C2ok3fLOlv6sgifSI0icmJ1ETBPNTLn+B/DupB4xap3lbwKBgQD2CyUA8cihE31ur0wMCTIoLF48aE7aUKd8m+KDXlMld1KGRhPokNU19Cl39155hi/SU/ukNOWISVXdBgbSpxXZxg9KIgPV8zS/S4Sq1jZC43L0ThPBlw3KW3aEqJIyer8J0FY4SzGlEo6OjEs6jSdiJTJrY9ifcNnvK0Fe2UN5/wKBgQCXSQVQvJt9sM5jSX71RMfETM4mNkcFLzyFuJpMNvmgZ+EiFq1kglzZ6VwbH7vngUmDfnQ7K8HecLP0vV/DGUwT3SG5bPq35OfAhy8rAVNY042ikwBhK5sRryXTtlErhetamkErBNSLc6iNfM4V27dEmdzVIPSKcHl4Nf1lapFf9wKBgQCCix8zBRYCAKlIlNGwgSCPmBrXyjAsPSbgQoVIVj+fXVP30i618kJtwgJOmH0T1VKCMfUOBtLSILbh8lSkZ+p8BU4Pc0S9u7B83sChM87OZoeTf+mTiWXTu/uCHz6ScfXyawuUCrFoeBQTJfS0ODhxJnM971f8IJBBCZ5BiNz4WQKBgD3BfJQNUImJlOBD3CHkBCF0EUYsn2D2k0cqo+tGHadDo1TWiAHA7+7PtfRys54qfVF8dfDDORp7b1Rqs8WXJtZYDSLnxlsDHZjeaSxmCtIy2owXzyoZUybQhPogE7CSEply0mCJnQm9EL7ibsVSVLeZf2BAHOcsbKbU8py3sYSL";

		byte[] bPublicKey = Base64.decodeBase64(encodedPublicKey.getBytes());
        byte[] bPrivateKey = Base64.decodeBase64(encodedPrivateKey.getBytes());
        
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(bPublicKey);
        X509EncodedKeySpec privateKeySpec = new X509EncodedKeySpec(bPrivateKey);
        
        Key publicKey = keyFactory.generatePublic(publicKeySpec);
        Key privateKey = keyFactory.generatePrivate(privateKeySpec);
        
		
        // TODO 하기 싫다. 너무 길고 복잡해 
        // https://blog.naver.com/wideeyed/220857831536
	}
}
