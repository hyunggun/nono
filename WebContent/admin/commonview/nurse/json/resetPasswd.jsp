<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
UserBiz userBiz = null;
boolean isSuccess = false;
try {
	userBiz = new UserBiz();
  isSuccess = userBiz.resetPassword(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "resultCode":<%=isSuccess%>
  }
}