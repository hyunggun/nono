<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

UserBiz userBiz = null;
boolean isSuccess = false;
try {
	userBiz = new UserBiz();
  isSuccess = userBiz.updateUser(paramMap);
  isSuccess = userBiz.updateNurse(paramMap);
  
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultData":{
    "resultCode":<%=(isSuccess)%>
  }
}