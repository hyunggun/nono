<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.OproomBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

OproomBiz oproomBiz = null;
boolean isSuccess = false;
try {
	oproomBiz = new OproomBiz();
  isSuccess = oproomBiz.updateOproom(paramMap);
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultData":{
    "resultCode":<%=isSuccess%>
  }
}