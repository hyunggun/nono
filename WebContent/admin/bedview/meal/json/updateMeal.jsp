<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.MealBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

MealBiz mealBiz = null;
Boolean isSuccess = false;
try {
	mealBiz = new MealBiz();
  isSuccess = mealBiz.updateMeal(paramMap);
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultCode":<%=isSuccess%>
}