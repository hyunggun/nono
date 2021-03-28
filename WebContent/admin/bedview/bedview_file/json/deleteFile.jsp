<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
BedviewBiz bedviewBiz = null;
Boolean isSuccess = false;
try {
	bedviewBiz = new BedviewBiz();
	isSuccess = bedviewBiz.deleteBedviewFile(paramMap);
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultCode":<%=isSuccess%>
}