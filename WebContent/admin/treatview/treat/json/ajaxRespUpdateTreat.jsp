<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.cofac.treat.ora.biz.non.TreatBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

TreatBiz treatBiz = null;
HashMap resultMap = null;
Boolean isSuccess = false;
try {
		treatBiz = new TreatBiz();
		
		String selectedRank = (String) paramMap.get("rank");
	  String preRank = (String) paramMap.get("treatment_id");
	  if(!selectedRank.isEmpty() && !selectedRank.equals(preRank)) {
		  resultMap = treatBiz.selectRank(paramMap);
		  
		  long rank_data = Long.parseLong((String) resultMap.get("rank"));
		  long pre_rank = Long.parseLong((String) resultMap.get("pre_rank"));
		  if(rank_data != 0 && pre_rank != rank_data) {
			  if(pre_rank < rank_data) {
			  	rank_data = rank_data + 1;
			  } else {
				  rank_data = rank_data - 1;
			  }
			  
			  paramMap.put("rank_data", String.valueOf(rank_data));
		  }
	  }
		  
		isSuccess = treatBiz.updateTreat(paramMap);
} catch(Exception e) {
    e.printStackTrace();
}
%>
{
  "resultData":{
    "resultCode":<%=isSuccess%>
  }
}