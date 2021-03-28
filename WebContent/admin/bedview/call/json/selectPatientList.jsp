<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.InpatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
HashMap resultMap = null;
InpatientBiz inpatBiz = null;
List list = null;
JSONArray jsonArr = null;
try {
	inpatBiz = new InpatientBiz();
	list = inpatBiz.selectInpatientList(paramMap);
  
	jsonArr = new JSONArray();
	jsonArr = JsonUtils.getJsonArrayFromList(list);
  
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":<%=(jsonArr.toString())%>
}