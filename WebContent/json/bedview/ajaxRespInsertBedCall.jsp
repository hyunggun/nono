<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.CallBiz"%>
<%@ page import="org.json.simple.JSONObject" %>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
JSONObject json = new JSONObject();
Boolean isSuccess = false;
try {
  CallBiz callBiz = new CallBiz();
  isSuccess = callBiz.insertCall(paramMap);
} catch (Exception e) {
    e.printStackTrace();
}
%>
{
  "resultCode":<%=isSuccess%>
}