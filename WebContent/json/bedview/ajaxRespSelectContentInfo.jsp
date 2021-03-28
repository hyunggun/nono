<%@page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.MenuBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
MenuBiz menuBiz = null;
Boolean isSuccess = false;
JSONObject jsonObj = new JSONObject();
try {
	menuBiz = new MenuBiz();
    resultMap = menuBiz.selectMenuContent(paramMap);
    if(resultMap != null){
      jsonObj = JsonUtils.getJsonObjectFromMap(resultMap);
      isSuccess = true;
    }
    
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":<%=jsonObj.toString()%>,
  "resultCode":<%=isSuccess%>
}