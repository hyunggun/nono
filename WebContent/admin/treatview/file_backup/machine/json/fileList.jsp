<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.FileBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List fileList = null;
FileBiz fileBiz = null;
JSONArray fileJAry = new JSONArray();
try {
	fileBiz = new FileBiz();
	fileList = fileBiz.selectFileList(paramMap);
	fileJAry = JsonUtils.getJsonArrayFromList(fileList);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "fileList":<%=(fileJAry.toString())%>
  }
}