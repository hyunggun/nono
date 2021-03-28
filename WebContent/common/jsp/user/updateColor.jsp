<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%
String THEME_COLOR = "#fff";
String FONT_COLOR = "#fff";
THEME_COLOR = request.getParameter("theme_color");
FONT_COLOR = request.getParameter("font_color");
String CONST_PATH = Constants.CONST_PATH;
File file = new File(CONST_PATH);
BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));

String temp = "";
String line = "";
while ((line = br.readLine()) != null) {
    if(line.contains("THEME_COLOR")) {
    	line = "THEME_COLOR=" + THEME_COLOR;
    } else if(line.contains("FONT_COLOR")) {
    	line = "FONT_COLOR=" + FONT_COLOR;
    }
    
    temp += line + "\r\n";
}

FileWriter fw = new FileWriter(CONST_PATH);
fw.write(temp);
fw.close();
br.close();

session.setAttribute("SESSION_THEME_COLOR", THEME_COLOR);
session.setAttribute("SESSION_FONT_COLOR", FONT_COLOR);
%>
<form name="basicForm" method="post" action="${contextPath}/admin/"></form>
<script type="text/javascript">
alert("색상값을 변경하였습니다.");
basicForm.submit();
</script>