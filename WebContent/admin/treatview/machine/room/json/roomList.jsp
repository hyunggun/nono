<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.RoomBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List roomList = null;
RoomBiz roomBiz = null;
JSONArray roomJAry = new JSONArray();
try {
	roomBiz = new RoomBiz();
	roomList = roomBiz.selectRoomList(paramMap);
	roomJAry = JsonUtils.getJsonArrayFromList(roomList);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
    "roomList":<%=(roomJAry.toString())%>
  }
}