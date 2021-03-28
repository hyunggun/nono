<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.MachineBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

boolean isSuccess = false;
MachineBiz machineBiz = null;
try {
	machineBiz = new MachineBiz();
	isSuccess = machineBiz.insertMachineAlert(paramMap);
	isSuccess = machineBiz.insertMachineAlertMulti(paramMap);
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