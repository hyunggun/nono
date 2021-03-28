<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.OratreatBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.TestemrBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.RoomBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

RoomBiz roomBiz = null;
OratreatBiz treatBiz = null;
JSONArray acceptJAry = new JSONArray();
JSONArray roomJAry = new JSONArray();
List roomList = null;
List acceptList = null;

try {
	
	Calendar cal = Calendar.getInstance();
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	int hour = cal.get(Calendar.HOUR);
	switch(dayOfWeek){
		case 1: paramMap.put("day", "SU"); break;
		case 2: paramMap.put("day", "M"); break;
		case 3: paramMap.put("day", "T"); break;
		case 4: paramMap.put("day", "W"); break;
		case 5: paramMap.put("day", "TH"); break;
		case 6: paramMap.put("day", "F"); break;
		case 7: paramMap.put("day", "S"); break;
	}
	
	if(hour > 12) paramMap.put("time", "A");
	else paramMap.put("time", "P");
	paramMap.put("not_status", "C");
	
	roomBiz = new RoomBiz();
	//roomList = roomBiz.selectRoomList(paramMap);
	roomList = roomBiz.selectRoomDoctorMultiList(paramMap);
	roomJAry = JsonUtils.getJsonArrayFromList(roomList);
	
// 	treatBiz = new OratreatBiz();
	treatBiz = new OratreatBiz();
	acceptList = treatBiz.selectTreatList(paramMap);
	acceptJAry = JsonUtils.getJsonArrayFromList(acceptList);
	
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "resultData":{
    "roomList":<%=(roomJAry.toString())%>,
    "acceptList":<%=(acceptJAry.toString())%>
  }
}