<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.MenuBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
HashMap resultMap = null;
MenuBiz menuBiz = null;
try {
	menuBiz = new MenuBiz();
  resultMap = menuBiz.selectMenu(paramMap);
  
  JSONObject jsonObj = new JSONObject();
  jsonObj = JsonUtils.getJsonObjectFromMap(resultMap);
  
  out.print("{\"resultData\":"+jsonObj+"}");
} catch(Exception ex) {
    ex.printStackTrace();
}
%>