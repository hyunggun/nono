<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.CallBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
HashMap resultMap = null;
CallBiz callBiz = null;
List list = null;
JSONArray jsonArr = null;
try {
	callBiz = new CallBiz();
	list = callBiz.selectCallList(paramMap);
  
	jsonArr = new JSONArray();
	jsonArr = JsonUtils.getJsonArrayFromList(list);
  
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":<%=(jsonArr.toString())%>
}