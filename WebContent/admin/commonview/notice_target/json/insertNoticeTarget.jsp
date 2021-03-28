<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.NoticeBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

NoticeBiz noticeBiz = null;
boolean isSuccess = false;
try {
	noticeBiz = new NoticeBiz();
	
	JSONParser jsonParser = new JSONParser();
	String jsonInfo = (String) paramMap.get("target_arr");
	if(!jsonInfo.equals("")) {
		JSONArray jsonArr = null;
		jsonArr = (JSONArray) jsonParser.parse(jsonInfo);
		if(jsonArr != null && jsonArr.size() > 0) {
			for(int lp0=0; lp0< jsonArr.size(); lp0++) {
				JSONObject data = (JSONObject) jsonArr.get(lp0);
				long target_id = (long) data.get("target_id");
				paramMap.put("target_id", target_id);
				isSuccess = noticeBiz.insertNoticeTarget(paramMap);
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