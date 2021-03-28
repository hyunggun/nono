<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.InpatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
InpatientBiz inpatBiz = null;
JSONObject jsonObj = new JSONObject();
try {
	inpatBiz = new InpatientBiz();
  resultMap = inpatBiz.selectInpatientCountForADST(paramMap);
  jsonObj = JsonUtils.getJsonObjectFromMap(resultMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":<%=(jsonObj.toString())%>
}