<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.CallBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
HashMap resultMap = null;
CallBiz callBiz = null;
JSONObject jsonObj = new JSONObject();
try {
	callBiz = new CallBiz();
  resultMap = callBiz.selectCall(paramMap);
  jsonObj = JsonUtils.getJsonObjectFromMap(resultMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "callObj":<%=(jsonObj.toString())%>
  }
