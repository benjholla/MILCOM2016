package com.example.loginsidechannels;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class AuthUtils {

	public static String generateSalt() throws NoSuchAlgorithmException {
		String salt  = "";
		byte[] buffer = new byte[512];
		new SecureRandom().nextBytes(buffer);
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		md.update(buffer);
		byte[] digest = md.digest();
		for (int i=0; i<digest.length; i++) {
			salt += Integer.toString((digest[i] & 0xff) + 0x100, 16).substring(1).toUpperCase();
		}
		return salt;
	}
	
	// Using a minimum of 1000 hash rounds as recommended by https://en.wikipedia.org/wiki/PBKDF2
	private static int PBKDF2_ROUNDS = 1000;
	
	public static String hash(String password, String salt) throws NoSuchAlgorithmException {
		String hashedPassword = "";
		byte[] buffer = (password + salt).getBytes();
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		md.update(buffer);
		byte[] digest = md.digest();
		for (int i=0; i<digest.length; i++) {
			hashedPassword += Integer.toString((digest[i] & 0xff) + 0x100, 16).substring(1).toUpperCase();
		}
		
		for(int round=0; round<PBKDF2_ROUNDS; round++){
			hashedPassword = pbkdf2(hashedPassword);
		}
		
		return hashedPassword;
	}
	
	public static String pbkdf2(String password) throws NoSuchAlgorithmException {
		String hashedPassword = "";
		byte[] buffer = password.getBytes();
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		md.update(buffer);
		byte[] digest = md.digest();
		for (int i=0; i<digest.length; i++) {
			hashedPassword += Integer.toString((digest[i] & 0xff) + 0x100, 16).substring(1).toUpperCase();
		}
		return hashedPassword;
	}
	
}
