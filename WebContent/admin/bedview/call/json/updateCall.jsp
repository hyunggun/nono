<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.CallBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
HashMap resultMap = null;
Boolean isSuccess = false;
CallBiz callBiz = null;
try {
	callBiz = new CallBiz();
	isSuccess = callBiz.updateCall(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultCode":<%=isSuccess%>
}