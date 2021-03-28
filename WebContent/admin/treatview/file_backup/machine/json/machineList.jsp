<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.MachineBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List machineList = null;
MachineBiz machineBiz = null;
JSONArray machineJAry = new JSONArray();
try {
	machineBiz = new MachineBiz();
	machineList = machineBiz.selectMachineList(paramMap);
	machineJAry = JsonUtils.getJsonArrayFromList(machineList);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "machineList":<%=(machineJAry.toString())%>
  }
}