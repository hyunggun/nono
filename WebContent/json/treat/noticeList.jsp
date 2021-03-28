<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.cofac.treat.ora.biz.non.NoticeBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
paramMap.put("posi_type", "T");
paramMap.put("single_multi", "M");

NoticeBiz noticeBiz = null;
JSONArray noticeSingleJAry = new JSONArray();
JSONArray noticeMultiJAry = new JSONArray();
List noticeMultiList = null;
List noticeSingleList = null;
try {
	noticeBiz = new NoticeBiz();
	
	String machine_id = (String) paramMap.get("machine_id");
	if(machine_id != null && !machine_id.equals("")) {
		paramMap.put("target_id", machine_id);
		noticeSingleList = noticeBiz.selectNoticeTargetList(paramMap);
		noticeSingleJAry = JsonUtils.getJsonArrayFromList(noticeSingleList);
	}
	
	noticeMultiList = noticeBiz.selectNoticeList(paramMap);
	noticeMultiJAry = JsonUtils.getJsonArrayFromList(noticeMultiList);
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "resultData":{
  	"singleList":<%=(noticeSingleJAry.toString())%>,
  	"multiList":<%=(noticeMultiJAry.toString())%>
  }
}