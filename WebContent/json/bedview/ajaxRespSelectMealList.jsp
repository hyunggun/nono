<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.MealBiz"%>
<%@ page import="org.json.simple.JSONArray"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
List list = null;
HashMap resultMap = null;
MealBiz mealBiz = null;
JSONArray jsonArr = new JSONArray();
try {
	mealBiz = new MealBiz();
  list = mealBiz.selectWeekMealList(paramMap);
  jsonArr = JsonUtils.getJsonArrayFromList(list);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":<%=jsonArr.toString()%>
}