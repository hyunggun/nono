<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.InpatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List inpatientList = null;
InpatientBiz inpatientBiz = null;
JSONArray inpatientJAry = new JSONArray();
try {
	inpatientBiz = new InpatientBiz();
	inpatientList = inpatientBiz.selectInpatientRoomList(paramMap);
	inpatientJAry = JsonUtils.getJsonArrayFromList(inpatientList);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":<%=(inpatientJAry.toString())%>
}