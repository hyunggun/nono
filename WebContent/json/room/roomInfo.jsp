<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.InpatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
InpatientBiz inpatientBiz = null;
JSONObject inpatientRoomJObj = new JSONObject();
HashMap inpatientRoom = new HashMap();
JSONArray inpatientFileJAry = new JSONArray();
List inpatientFileList = null;
try {
	inpatientBiz = new InpatientBiz();
	inpatientRoom = inpatientBiz.selectInpatientRoom(paramMap);
	if( inpatientRoom != null ) inpatientRoomJObj = JsonUtils.getJsonObjectFromMap(inpatientRoom);
	
	inpatientFileList = inpatientBiz.selectInpatientFileList(paramMap);
	if( inpatientFileList != null ) inpatientFileJAry = JsonUtils.getJsonArrayFromList(inpatientFileList);
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "resultData":{
    "inpatientRoom":<%=(inpatientRoomJObj.toString())%>,
    "inpatientFileList":<%=(inpatientFileJAry.toString())%>
  }
}