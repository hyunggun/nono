<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.MachineBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

MachineBiz machineBiz = null;
JSONObject machineJObj = new JSONObject();
HashMap machineInfo = new HashMap();
String logo_url = Constants.LOGO_MOBILE_URL;
try {
	machineBiz = new MachineBiz();
	machineInfo = machineBiz.selectMachine(paramMap);
	if( machineInfo != null ) machineJObj = JsonUtils.getJsonObjectFromMap(machineInfo);
	
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "resultData":{
	  "machineObj":<%=(machineJObj.toString())%>,
	  "logo_url":"<%=logo_url%>"
  }
}