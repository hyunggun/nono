<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.TreatBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
TreatBiz treatBiz = null;
try {
		treatBiz = new TreatBiz();
    resultMap = treatBiz.selectTreat(paramMap);
    
    JSONObject jsonObj = new JSONObject();
    jsonObj = JsonUtils.getJsonObjectFromMap(resultMap);
      
    out.print("{\"resultData\":"+jsonObj+"}");
} catch(Exception ex) {
    ex.printStackTrace();
}
%>