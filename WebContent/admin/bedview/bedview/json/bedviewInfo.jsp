<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
BedviewBiz bedviewBiz = null;
JSONObject bedviewObj = new JSONObject();
try {
	bedviewBiz = new BedviewBiz();
  resultMap = bedviewBiz.selectBedview(paramMap);
  bedviewObj = JsonUtils.getJsonObjectFromMap(resultMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "bedviewObj":<%=(bedviewObj.toString())%>
  }
}