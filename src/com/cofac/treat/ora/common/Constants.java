package com.cofac.treat.ora.common;

import java.util.ResourceBundle;

public class Constants {

	// page block length
	public static final Integer BLOCK_LENGTH = 5;
	
	// item length 
	public static final Integer LIST_LENGTH = 12; // 게시판
	public static final Integer CMT_LIST_LENGTH = 6; // 댓글
	
	public static String FILE_BASIS_PATH = "C:\\data\\tomcat-8.5\\webapps\\ROOT\\upload";
	public static String FILE_BASIS_URL = "http://192.168.1.100/upload/";
	public static String LOGO_BASIS_URL = "http://192.168.1.100/upload/logo/logo.png";
	public static String LOGO_MOBILE_URL = "http://192.168.1.100/upload/logo/mobile_logo.png";
	public static String CONST_PATH = "C:\\Users\\ksj\\Documents\\treat-ora2\\web\\src\\const.properties";

	public static String MACHINE_KEY_TYPE = "doctorKey";
	public static String EMR_DB_TYPE = "MYSQL";
	
	public static String THEME_COLOR = "brown";
	public static String FONT_COLOR = "#fff";
	
	public static String TREATVIEW_FG = "TRUE";
	public static String BEDVIEW_FG = "TRUE";
	public static String INPATVIEW_FG = "TRUE";
	public static String EMR_FG = "TRUE";
	public static String OPERATION_FG = "TRUE";

	static {
		ResourceBundle bundle = null;
		try {
			bundle = ResourceBundle.getBundle("const");
			if( bundle != null ) {
				FILE_BASIS_PATH = bundle.getString("FILE_BASIS_PATH");
				FILE_BASIS_URL = bundle.getString("FILE_BASIS_URL");
				LOGO_BASIS_URL = bundle.getString("LOGO_BASIS_URL");
				LOGO_MOBILE_URL = bundle.getString("LOGO_MOBILE_URL");
				MACHINE_KEY_TYPE = bundle.getString("MACHINE_KEY_TYPE");
				EMR_DB_TYPE = bundle.getString("EMR_DB_TYPE");
				CONST_PATH = bundle.getString("CONST_PATH");
				THEME_COLOR = bundle.getString("THEME_COLOR");
				FONT_COLOR = bundle.getString("FONT_COLOR");
				TREATVIEW_FG = bundle.getString("TREATVIEW_FG");
				BEDVIEW_FG = bundle.getString("BEDVIEW_FG");
				INPATVIEW_FG = bundle.getString("INPATVIEW_FG");
				EMR_FG = bundle.getString("EMR_FG");
				OPERATION_FG = bundle.getString("OPERATION_FG");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}