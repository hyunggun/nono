<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.MenuBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
List list = null;
HashMap resultMap = null;
MenuBiz menuBiz = null;
JSONArray jsonArr = new JSONArray();
Boolean isSuccess = false;
try {
	menuBiz = new MenuBiz();
  list = menuBiz.selectMenuList(paramMap);
  if(list != null) {
	  jsonArr = JsonUtils.getJsonArrayFromList(list);
	  isSuccess = true;
  }
  
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":<%=jsonArr.toString()%>,
  "resultCode":<%=isSuccess%>
}