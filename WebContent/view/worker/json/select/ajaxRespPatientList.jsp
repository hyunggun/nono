<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.PatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List list = null;
PatientBiz patientBiz = null;
try {
  paramMap.put("use_fg", "Y");
  
	patientBiz = new PatientBiz();
  list = patientBiz.selectPatientList(paramMap);
  JSONArray jsonArr = new JSONArray();
  jsonArr = JsonUtils.getJsonArrayFromList(list);
    
  out.print("{\"resultData\":"+jsonArr+"}");
} catch(Exception ex) {
    ex.printStackTrace();
}
%>