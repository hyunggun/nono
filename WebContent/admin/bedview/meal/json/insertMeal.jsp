<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.YRequest"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@page import="com.cofac.treat.ora.biz.non.MealBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
YRequest req = new YRequest(request);
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(req);

MealBiz mealBiz = null;
Boolean isSuccess = false;

try {
  mealBiz = new MealBiz();
  JSONParser jsonParser = new JSONParser();
  //fileList
  String jsonInsertList = (String)paramMap.get("mealList"); 
  JSONArray infoInsertArray = (JSONArray) jsonParser.parse(jsonInsertList);
  Integer insertSize = infoInsertArray.size();
  for(int lp0=0; lp0 < insertSize; lp0++) {
    JSONObject data = (JSONObject) infoInsertArray.get(lp0);
    String date = (String) data.get("date");
    String breakfast = (String) data.get("breakfast");
    String lunch = (String) data.get("lunch");
    String dinner = (String) data.get("dinner");
    String snack = (String) data.get("snack");
    paramMap.put("date", date);
    paramMap.put("breakfast", breakfast);
    paramMap.put("lunch", lunch);
    paramMap.put("dinner", dinner);
    paramMap.put("snack", snack);
    Integer isBeeing = 0;
    isBeeing = mealBiz.checkIsBeeing(paramMap);
    if( isBeeing == 0){
      isSuccess = mealBiz.insertMeal(paramMap);
    }else{
      paramMap.put("meal_id",isBeeing);
      isSuccess = mealBiz.updateMeal(paramMap);
    }
  }

} catch(Exception e) {
  e.printStackTrace();
}
%>
{
  "resultCode":<%=isSuccess%>
}