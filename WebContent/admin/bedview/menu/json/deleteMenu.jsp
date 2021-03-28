<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.MenuBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

boolean isSuccess = false;
MenuBiz menuBiz = null;
try {
  
	menuBiz = new MenuBiz();
	isSuccess = menuBiz.deleteMenu(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
	"resultCode":<%=isSuccess%>
}