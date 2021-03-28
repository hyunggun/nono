<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.FileBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

FileBiz fileBiz = null;
boolean isSuccess = false;
try {
	fileBiz = new FileBiz();
  isSuccess = fileBiz.deleteFile(paramMap);
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultData":{
    "resultCode":"<%=isSuccess%>",
    "page_no":"<%=((String) paramMap.get("page_no"))%>",
    "search_type":"<%=((String) paramMap.get("search_type"))%>",
    "search_text":"<%=((String) paramMap.get("search_text"))%>"
  }
}