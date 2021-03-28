<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.NoticeBiz"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List list = null;
NoticeBiz noticeBiz = null;
Boolean isSuccess = false;
JSONArray noticeArr = new JSONArray();
JSONArray msgArr = new JSONArray();
try {
		paramMap.put("posi_type", "B");
		paramMap.put("single_multi", "M");
	
    noticeBiz = new NoticeBiz();
    list = noticeBiz.selectNoticeList(paramMap);    
    if( list != null ) {
      noticeArr = JsonUtils.getJsonArrayFromList(list);
    }
    
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
  "resultData":{
  	"noticeList":<%=noticeArr.toString()%>
  }
}