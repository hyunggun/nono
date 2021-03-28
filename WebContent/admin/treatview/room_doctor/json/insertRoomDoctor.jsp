<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.RoomBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

RoomBiz roomBiz = null;
boolean isSuccess = false;
try {
	roomBiz = new RoomBiz();
	JSONParser jsonParser = new JSONParser();
  String days = (String) paramMap.get("days"); 
  JSONArray jsonArr = (JSONArray) jsonParser.parse(days);
  for(int lp0=0; lp0 < jsonArr.size(); lp0++) {
	  String day = (String) jsonArr.get(lp0);
	  paramMap.put("day", day);
	  
	  HashMap resultMap = new HashMap();
	  resultMap = roomBiz.selectRoomDoctorDupl(paramMap);
	  if(resultMap != null) roomBiz.deleteRoomDoctor(resultMap);
	  isSuccess = roomBiz.insertRoomDoctor(paramMap);
  }
  
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultCode":<%=isSuccess%>
}