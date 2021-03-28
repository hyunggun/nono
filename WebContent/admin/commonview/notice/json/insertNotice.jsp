<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.NoticeBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

NoticeBiz noticeBiz = null;
boolean isSuccess = false;
try {
	noticeBiz = new NoticeBiz();
  isSuccess = noticeBiz.insertNotice(paramMap);
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultData":{
    "resultCode":"<%=isSuccess%>"
  }
}