<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.RoomBiz"%>
<%
  RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

// TreatBiz treatBiz = null;
RoomBiz treatBiz = null;
JSONArray acceptJAry = new JSONArray();
HashMap roomMap = null;
List acceptList = null;
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

if(hour < 12) paramMap.put("time", "A");
else paramMap.put("time", "P");

try {
  
  treatBiz = new RoomBiz();
//   treatBiz = new TreatBiz();
  acceptList = treatBiz.selectRoomStatus(paramMap);
  acceptJAry = JsonUtils.getJsonArrayFromList(acceptList);
  
} catch (Exception ex) {
  ex.printStackTrace();
}
%>
{
  "resultData":{
    "acceptList":<%=(acceptJAry.toString())%>
  }
}