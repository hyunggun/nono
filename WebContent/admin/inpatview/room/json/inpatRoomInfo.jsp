<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.InpatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
InpatientBiz inpatientBiz = null;
JSONObject inpatientObj = new JSONObject();
try {
	inpatientBiz = new InpatientBiz();
  resultMap = inpatientBiz.selectInpatientRoom(paramMap);
  inpatientObj = JsonUtils.getJsonObjectFromMap(resultMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "inpatientObj":<%=(inpatientObj.toString())%>
  }
}