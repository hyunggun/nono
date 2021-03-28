package startkr.util;

public class StringUtils {
	public static Boolean isNull( String str ) {
		if( str == null ) return true;
		return false;
	}
	
	public static Boolean isNotNull( String str ) {
		if( str == null ) return false;
		return true;
	}

	public static Boolean isEmpty( String str ) {
		if( str == null ) return true;
		if( str.length() == 0 ) return true;
		return false;
	}
	
	public static Boolean isNotEmpty( String str ) {
		if( str == null ) return false;
		if( str.length() == 0 ) return false;
		return true;
	}
	
	public static String checkNull( String str ) {
		if( str != null ) return str;
		return "";
	}

	public static String checkNull( String str, String defaultVal ) {
		if( str != null ) return str;
		if( defaultVal != null ) return defaultVal;
		return "";
	}
	
	public static String checkEmpty( String str, String defaultVal ) {
		if( str != null && str.length() > 0 ) return str;
		if( defaultVal != null ) return defaultVal;
		return "";
	}
	
	public static int checkIntEmpty( String str, int defaultVal ) {
		if( str != null && str.length() > 0 ) return Integer.parseInt(str);
		return defaultVal;
	}
	
	// DB에는 TextArea나 에디터에 있는 값을 그대로 저장한다.
	// DB에 저장된 값은 TextArea 안, 태그 안, 태그의 속성, 스크립트 등에서 조회될 수 있는데, 필요에 따라 변환될 필요가 있다.  
	public static String convertText2HTML( String str ) { // TextArea에서 작성한 것을 일반 태그 내에서 보여줄 때.
		if( str == null || str.length() < 0 ) return "";
		return str.replaceAll("\n", "<br/>\n").replaceAll("  ", "&nbsp; "); // .replaceAll("'", "&quot;")
	}

	public static String convertHTML2Text( String str ) {
		if( str == null || str.length() < 0 ) return "";
		return str.replaceAll("<br/>\n", "\n").replaceAll("&nbsp;", " ");
	}
	
	public static String convertTagView( String str ) { // Tag 그 자체를 보여줘야 할 때.
		if( str == null || str.length() < 0 ) return "";
		return str.replaceAll("'", "&quot;")
				.replaceAll("&", "&amp;")
				.replaceAll("<", "&lt;")
				.replaceAll(">", "&gt;");
	}

	public static String convertUnTag( String str ) {
		if( str == null || str.length() < 0 ) return "";
		return str.replaceAll("&quot;", "'")
				.replaceAll("&amp;", "&")
				.replaceAll("&lt;", "<")
				.replaceAll("&gt;", ">");
	}

	public static String convertScript( String str ) { // 스크립트 값이나, 태그의 속성에서 ''안에 '가 들어갈 때.
		if( str == null || str.length() < 0 ) return "";
		return str.replaceAll("'", "\'");
	}

	public static String convertUnScript( String str ) {
		if( str == null || str.length() < 0 ) return "";
		return str.replaceAll("\'", "'");
	}

}