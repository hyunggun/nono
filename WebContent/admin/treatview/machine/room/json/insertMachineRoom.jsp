<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.MachineBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
MachineBiz machineBiz = null;
boolean isSuccess = false;
try {
	machineBiz = new MachineBiz();
	
	JSONParser jsonParser = new JSONParser();
	String jsonInfo = (String) paramMap.get("room_ids");
	if(!jsonInfo.equals("")) {
		JSONArray jsonArr = null;
		jsonArr = (JSONArray) jsonParser.parse(jsonInfo);
		if(jsonArr != null && jsonArr.size() > 0) {
			for(int lp0=0; lp0< jsonArr.size(); lp0++) {
				JSONObject data = (JSONObject) jsonArr.get(lp0);
				String room_id = (String) data.get("room_id");
				paramMap.put("room_id", room_id);
				isSuccess = machineBiz.insertMachineRoom(paramMap);
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