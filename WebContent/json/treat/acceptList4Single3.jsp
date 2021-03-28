<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.OratreatBiz"%>
<%-- <%@page import="com.cofac.treat.ora.biz.non.OratreatBiz"%> --%>
<%@page import="com.cofac.treat.ora.biz.non.RoomBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

OratreatBiz treatBiz = null;
RoomBiz roomBiz = null;
JSONArray acceptJAry = new JSONArray();
JSONObject roomJObj = new JSONObject();
HashMap roomMap = null;
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
	roomMap = roomBiz.selectRoomDoctor(paramMap);
	if(roomMap == null) {
		roomMap = roomBiz.selectRoom(paramMap);
	}
	roomJObj = JsonUtils.getJsonObjectFromMap(roomMap);
	
  paramMap.put("doctorKey", roomMap.get("room_code"));
  
  treatBiz = new OratreatBiz();
  if(roomMap.get("room_code").equals("51") || roomMap.get("room_code").equals("53") || roomMap.get("room_code").equals("70")) {
	  paramMap.put("dupl", "Y");
		acceptList = treatBiz.selectTreatCheckList(paramMap);
		acceptJAry = JsonUtils.getJsonArrayFromList(acceptList);
  } else {
		acceptList = treatBiz.selectTreatList(paramMap);
		acceptJAry = JsonUtils.getJsonArrayFromList(acceptList);
  }
	
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "resultData":{
  	"roomObj":<%=(roomJObj.toString())%>,
    "acceptList":<%=(acceptJAry.toString())%>
  }
}