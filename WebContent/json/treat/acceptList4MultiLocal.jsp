<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.RoomBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.TreatBiz"%>

<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
TreatBiz treatBiz = null;
RoomBiz roomBiz = null;
JSONArray acceptJAry = new JSONArray();
JSONArray roomJAry = new JSONArray();
List acceptList = null;
List roomList = null;
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
	
		roomBiz = new RoomBiz();
		//roomList = roomBiz.selectRoomList(paramMap);
		roomList = roomBiz.selectRoomDoctorMultiList(paramMap);
		roomJAry = JsonUtils.getJsonArrayFromList(roomList);	
	
	  treatBiz = new TreatBiz();
	  acceptList = treatBiz.selectTreatMultiList(paramMap);
    acceptJAry = JsonUtils.getJsonArrayFromList(acceptList);   
} catch(Exception ex) {
    ex.printStackTrace();
}

%>
{
  "resultData":{
    "roomList":<%=(roomJAry.toString())%>,
    "acceptList":<%=(acceptJAry.toString())%>
  }
}