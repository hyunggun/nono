<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.InpatientBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
InpatientBiz inpatientBiz = null;
boolean isSuccess = false;
try {
	inpatientBiz = new InpatientBiz();
	
	JSONParser jsonParser = new JSONParser();
	String jsonInfo = (String) paramMap.get("inprm_ids");
	if(!jsonInfo.equals("")) {
		JSONArray jsonArr = null;
		jsonArr = (JSONArray) jsonParser.parse(jsonInfo);
		if(jsonArr != null && jsonArr.size() > 0) {
			for(int lp0=0; lp0< jsonArr.size(); lp0++) {
				JSONObject data = (JSONObject) jsonArr.get(lp0);
				String inprm_id = (String) data.get("inprm_id");
				paramMap.put("inprm_id", inprm_id);
				isSuccess = inpatientBiz.insertInpatientFile(paramMap);
			}
		}
	}
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultData":{
    "resultCode":<%=isSuccess%>
  }
}