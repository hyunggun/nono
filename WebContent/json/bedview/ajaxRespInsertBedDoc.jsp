<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.DocBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

DocBiz docBiz = null;
boolean isSuccess = false;
try {
	docBiz = new DocBiz();
	isSuccess = docBiz.insertDoc(paramMap);
// 	JSONParser jsonParser = new JSONParser();
// 	String jsonInfo = (String) paramMap.get("contents");
// 	if(!jsonInfo.equals("")) {
// 		JSONArray jsonArr = null;
// 		jsonArr = (JSONArray) jsonParser.parse(jsonInfo);
// 		if(jsonArr != null && jsonArr.size() > 0) {
// 			for(int lp0=0; lp0< jsonArr.size(); lp0++) {
// 				String content = (String) jsonArr.get(lp0);
// 				paramMap.put("content", content);
// 				isSuccess = docBiz.insertDoc(paramMap);
// 			}
// 		}
// 	}
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultData":{
    "resultCode":<%=isSuccess%>
  }
}