<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.MachineBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

MachineBiz machineBiz = null;
JSONArray machineFileJAry = new JSONArray();
List machineFileList = null;
try {
	machineBiz = new MachineBiz();
	machineFileList = machineBiz.selectMachineFileList(paramMap);
	if( machineFileList != null ) machineFileJAry = JsonUtils.getJsonArrayFromList(machineFileList);
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "resultData":{
    "machineFileList":<%=(machineFileJAry.toString())%>
  }
}