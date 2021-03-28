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

List list = null;
RoomBiz roomBiz = null;
try {
	paramMap.put("use_fg", "Y");
	
	roomBiz = new RoomBiz();
  list = roomBiz.selectRoomList(paramMap);
  JSONArray jsonArr = new JSONArray();
  jsonArr = JsonUtils.getJsonArrayFromList(list);
    
  out.print("{\"resultData\":"+jsonArr+"}");
} catch(Exception ex) {
    ex.printStackTrace();
}
%>