<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.TreatBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

boolean isSuccess = false;
TreatBiz treatBiz = null;
List list = null;
try {
	treatBiz = new TreatBiz();
	isSuccess = treatBiz.updateTreat(paramMap);
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