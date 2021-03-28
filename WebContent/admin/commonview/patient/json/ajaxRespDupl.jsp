<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.PatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
PatientBiz patientBiz = null;
try {
	patientBiz = new PatientBiz();
  resultMap = patientBiz.selectPatient(paramMap);
  if(resultMap != null) {
    out.println("{");
    out.println("\"resultCode\":\"dupl\"");
    out.println("}");
  } else {
  	out.println("{");
    out.println("\"resultCode\":\"none\"");
    out.println("}");
  }
} catch(Exception ex) {
    ex.printStackTrace();
}
%>