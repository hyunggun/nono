<%@page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.cofac.treat.ora.common.Constants"%>
<%
String THEME_COLOR = "#fff";
String FONT_COLOR = "#fff";
String CONST_PATH = Constants.CONST_PATH;
File file = new File(CONST_PATH);

Boolean isSuccess = false;
BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
try {
	String temp = "";
	String line = "";
	
	while ((line = br.readLine()) != null) {
	    if(line.contains("THEME_COLOR")) {
	    	THEME_COLOR = line.replace("THEME_COLOR=", "");
	    } else if(line.contains("FONT_COLOR")) {
	    	FONT_COLOR = line.replace("FONT_COLOR=", "");
	    }
	}
    
	session.setAttribute("SESSION_THEME_COLOR", THEME_COLOR);
	session.setAttribute("SESSION_FONT_COLOR", FONT_COLOR);
	
	isSuccess = true;
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultCode":<%=isSuccess%>
}