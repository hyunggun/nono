
<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.NoticeBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
NoticeBiz noticeBiz = null;
JSONObject noticeObj = new JSONObject();
try {
	noticeBiz = new NoticeBiz();
  resultMap = noticeBiz.selectNotice(paramMap);
  noticeObj = JsonUtils.getJsonObjectFromMap(resultMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "noticeObj":<%=(noticeObj.toString())%>
  }
}