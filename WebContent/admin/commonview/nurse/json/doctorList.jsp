<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List doctorList = null;
UserBiz userBiz = null;
JSONArray doctorJAry = new JSONArray();
try {
	userBiz = new UserBiz();
	doctorList = userBiz.selectDoctorList(paramMap);
  doctorJAry = JsonUtils.getJsonArrayFromList(doctorList);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "doctorList":<%=(doctorJAry.toString())%>
  }
}