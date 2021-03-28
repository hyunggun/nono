package startkr.util;

import javax.crypto.*;
import javax.crypto.spec.*;

import org.mindrot.jbcrypt.BCrypt;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class CrytoUtils {
	
	public void CrytoUtils() {
		
	}

	public static String decrypt(String text, String key) throws Exception
	{
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		byte[] keyBytes = new byte[16];
		byte[] bt = key.getBytes("UTF-8");
		int len = bt.length;
		if (len > keyBytes.length) len = keyBytes.length;
		System.arraycopy(bt, 0, keyBytes, 0, len);
		SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
		IvParameterSpec ivSpec = new IvParameterSpec(keyBytes);
		cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);

		BASE64Decoder decoder = new BASE64Decoder();
		byte [] results = cipher.doFinal(decoder.decodeBuffer(text));
		return new String(results,"UTF-8");
	}

	public static String encrypt(String text, String key) throws Exception
	{
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		byte[] keyBytes = new byte[16];
		byte[] bt = key.getBytes("UTF-8");
		int len = bt.length;
		if (len > keyBytes.length) len = keyBytes.length;
		System.arraycopy(bt, 0, keyBytes, 0, len);
		SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
		IvParameterSpec ivSpec = new IvParameterSpec(keyBytes);
		cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);

		BASE64Encoder encoder = new BASE64Encoder();
		byte[] results = cipher.doFinal(text.getBytes("UTF-8"));
		return encoder.encode(results);
	}
	
	public static String getBCrypt(String text) throws Exception
	{
		return BCrypt.hashpw(text, BCrypt.gensalt());
	}

	public Boolean compareBCrypt(String text, String hash) throws Exception
	{
		return BCrypt.checkpw(text, hash);
	}
}
