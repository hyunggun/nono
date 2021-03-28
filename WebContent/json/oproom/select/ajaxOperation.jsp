<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.OperationBiz"%>
<%
  RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

OperationBiz oproomBiz = null;
JSONArray acceptJAry = new JSONArray();
JSONObject roomJObj = new JSONObject();
HashMap roomMap = null;
List acceptList = null;
try {
  roomJObj = JsonUtils.getJsonObjectFromMap(roomMap);
  
  oproomBiz = new OperationBiz();
  acceptList = oproomBiz.selectOperationList(paramMap);
  acceptJAry = JsonUtils.getJsonArrayFromList(acceptList);
  
} catch (Exception ex) {
  ex.printStackTrace();
}
%>
{
  "resultData":{
    "acceptList":<%=(acceptJAry.toString())%>
  }
}