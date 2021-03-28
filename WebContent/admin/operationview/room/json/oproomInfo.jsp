<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.OproomBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
OproomBiz oproomBiz = null;
JSONObject oproomObj = new JSONObject();
try {
	oproomBiz = new OproomBiz();
  resultMap = oproomBiz.selectOproom(paramMap);
  oproomObj = JsonUtils.getJsonObjectFromMap(resultMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "oproomObj":<%=(oproomObj.toString())%>
  }
}