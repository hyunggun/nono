<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.TreatBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

TreatBiz treatBiz = null;
HashMap resultMap = null;
Boolean isSuccess = false;
try {
	  treatBiz = new TreatBiz();
	  long rank = Long.parseLong((String) paramMap.get("rank"));
	  long pre_rank = Long.parseLong((String) paramMap.get("pre_rank"));
	  if(rank != 0 && pre_rank != rank) {
		  if(pre_rank < rank) {
			  rank = rank + 1;
		  } else {
			  rank = rank - 1;
		  }
		  
		  paramMap.put("rank_data", String.valueOf(rank));
	  }
	  
    isSuccess = treatBiz.updateTreat(paramMap);
    out.print("{\"resultCode\":"+isSuccess.toString()+"}");
} catch(Exception ex) {
    ex.printStackTrace();
}
%>