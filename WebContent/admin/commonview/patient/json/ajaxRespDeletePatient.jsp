<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.PatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

PatientBiz patientBiz = null;
Boolean isSuccess = false;
try {
	patientBiz = new PatientBiz();
  isSuccess = patientBiz.deletePatient(paramMap);
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultData":{
    "resultCode":<%=isSuccess%>
  }
}