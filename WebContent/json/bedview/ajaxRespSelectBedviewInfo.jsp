<%@page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.InpatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
BedviewBiz bedviewBiz = null;
Boolean isSuccess = false;
JSONObject jsonObj = new JSONObject();
List inpatientList = null;
InpatientBiz inpatientBiz = null;
try {
	bedviewBiz = new BedviewBiz();
  resultMap = bedviewBiz.selectBedview(paramMap);
  if(resultMap != null){
    inpatientBiz = new InpatientBiz();
    HashMap patientMap = (HashMap) inpatientBiz.selectInpatient(paramMap);
    resultMap.put("patient_nm", (String) patientMap.get("patient_nm") );
    resultMap.put("ward", (String) patientMap.get("WARD") );
    resultMap.put("doctor_nm", (String) patientMap.get("doctor_nm") );
    resultMap.put("patient_day", (String) patientMap.get("patient_day") );
    

    jsonObj = JsonUtils.getJsonObjectFromMap(resultMap);
    isSuccess = true;
  }
    
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":<%=jsonObj.toString()%>,
  "resultCode":<%=isSuccess%>
}