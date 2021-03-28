<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List list = null;
UserBiz userBiz = null;
try {
	paramMap.put("use_fg", "Y");
	
	userBiz = new UserBiz();
  list = userBiz.selectDoctorList(paramMap);
  JSONArray jsonArr = new JSONArray();
  jsonArr = JsonUtils.getJsonArrayFromList(list);
    
  out.print("{\"resultData\":"+jsonArr+"}");
} catch(Exception ex) {
    ex.printStackTrace();
}
%>