<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.InpatientBiz"%>
<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
InpatientBiz inpatientBiz = null;
JSONObject emrObj = new JSONObject();
try {
	inpatientBiz = new InpatientBiz();
  resultMap = inpatientBiz.selectInpatient(paramMap);
  emrObj = JsonUtils.getJsonObjectFromMap(resultMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "emrObj":<%=(emrObj.toString())%>
  }
}