<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.InpatientBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.DocBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
InpatientBiz inpatientBiz = null;
JSONArray inpatientJAry = new JSONArray();
List inpatientList = null;
List<HashMap<String, String>> inpatientWithColorList = new ArrayList<HashMap<String, String>>(); //화면에 보낼때 쓰일 복제 데이터
try {
	inpatientBiz = new InpatientBiz();
	inpatientList = inpatientBiz.selectInpatientList(paramMap);
	HashMap patientMap = new HashMap();
	
	inpatientJAry = JsonUtils.getJsonArrayFromList(inpatientWithColorList);
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "resultData":{
    "oraInpatientList":<%=(inpatientJAry.toString())%>
  }
}