<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.PatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

boolean isSuccess = false;
PatientBiz patientBiz = null;
List list = null;

try {
	paramMap.put("reg_user_id", session.getAttribute("SESSION_MOBILE_USER_ID"));
	paramMap.put("status", "S");
	
	patientBiz = new PatientBiz();
	isSuccess = patientBiz.insertPatient(paramMap);
	
  if(isSuccess) {
    out.println("{");
    out.println("\"resultCode\":\"success\"");
    out.println("}");
  } else {
  	out.println("{");
    out.println("\"resultCode\":\"fail\"");
    out.println("}");
  }
  
} catch(Exception ex) {
    ex.printStackTrace();
}
%>