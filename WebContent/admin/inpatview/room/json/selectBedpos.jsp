<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.InpatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
InpatientBiz inpatientBiz = null;
JSONArray inpatientJAry = new JSONArray();
HashMap<String, String> resultMap = new HashMap<String, String>();
String bedpos = "";
try {
	inpatientBiz = new InpatientBiz();
	resultMap = inpatientBiz.selectBedpos(paramMap);
	
	bedpos = resultMap.get("bedpos");
	
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "resultData":{
    "bedpos":<%=bedpos%>
  }
}