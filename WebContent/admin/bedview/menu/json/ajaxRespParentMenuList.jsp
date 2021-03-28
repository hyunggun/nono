<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.MenuBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
List list = null;
MenuBiz menuBiz = null;
JSONArray jsonArr = null;
try {
	menuBiz = new MenuBiz();

  list = menuBiz.selectMenuList(paramMap);
  jsonArr = new JSONArray();
  jsonArr = JsonUtils.getJsonArrayFromList(list);
  
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
	"resultData":<%=(jsonArr.toString())%>
}