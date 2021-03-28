<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.OratreatBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.TestemrBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
OratreatBiz treatBiz = null;
JSONObject treatObj = new JSONObject();
try {
	treatBiz = new OratreatBiz();
  resultMap = treatBiz.selectTreat(paramMap);
  treatObj = JsonUtils.getJsonObjectFromMap(resultMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "treatObj":<%=(treatObj.toString())%>
  }
}