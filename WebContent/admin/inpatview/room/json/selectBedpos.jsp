<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.BedposBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
BedposBiz bedposBiz = null;
JSONArray inpatientJAry = new JSONArray();
HashMap<String, String> resultMap = new HashMap<String, String>();
String bedpos = "";
try {
	bedposBiz = new BedposBiz();
	resultMap = bedposBiz.selectBedpos(paramMap);
	
	bedpos = resultMap.get("bedpos");
	
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "bedpos" : <%=bedpos%>
}