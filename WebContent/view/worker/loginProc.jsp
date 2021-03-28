<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="workerPath" value="${contextPath}/view/worker" />
<%
String userAgent = request.getHeader("User-Agent");
if (userAgent.indexOf("Trident") > -1) {
	userAgent = "MSIE";
} else if (userAgent.indexOf("Chrome") > -1) {
	userAgent = "Chrome";
} else if (userAgent.indexOf("Opera") > -1) {
	userAgent = "Opera";
} else if (userAgent.indexOf("iPhone") > -1
  && userAgent.indexOf("Mobile") > -1) {
	userAgent = "iPhone";
} else if (userAgent.indexOf("Android") > -1
  && userAgent.indexOf("Mobile") > -1) {
	userAgent = "Android";
}

RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
System.out.println("\n----paramMap:[ "+ paramMap + " ]----");

UserBiz userBiz = null;
Boolean isSuccess = false;
String resultStr = "로그인에 실패하였습니다.";
String workerView = (String) paramMap.get("view_type");
// String logo_url = (String) paramMap.get("logo_url");
try {
		userBiz = new UserBiz();
    HashMap resultMap = userBiz.checkUser(paramMap);
    if( resultMap != null ) {
      String checkUser = (String) resultMap.get("checkUser");
      String checkPasswd = (String) resultMap.get("checkPasswd");
      
      if( "Valid".equals(checkUser) && "Right".equals(checkPasswd) ) { // 로그인 성공
    	  Long user_id = (Long) resultMap.get("user_id");
// 				Integer user_id = (int)(long) resultMap.get("user_id");
				String sign_id = (String) resultMap.get("sign_id");
				String user_nm = (String) resultMap.get("user_nm");
				String user_role = String.valueOf(resultMap.get("role"));
				String logo_url = Constants.LOGO_MOBILE_URL;
				String emr_doctor_key = (String) resultMap.get("emr_doctor_key");
				
				if( sign_id == null ) sign_id = "";
        if( user_nm == null ) user_nm = "";
        if( user_role == null ) user_role = "";

        session.setAttribute("SESSION_MOBILE_USER_ID", user_id);
        session.setAttribute("SESSION_MOBILE_SIGN_ID", sign_id);
        session.setAttribute("SESSION_MOBILE_USER_NM", user_nm);
        session.setAttribute("SESSION_MOBILE_USER_ROLE", user_role);
				session.setAttribute("SESSION_MOBILE_LOGO_URL", logo_url);
				session.setAttribute("SESSION_MOBILE_DOCTOR_KEY", emr_doctor_key);
        session.setMaxInactiveInterval(60*60*24*7);
            
				if(user_role.equals("N")) {
					isSuccess = true;
	       	resultStr = "간호사 로그인에 성공하였습니다.";
				} else if(user_role.equals("M")) {
					isSuccess = true;
					resultStr = "관리자 로그인에 성공하였습니다.";
				} else {
					resultStr = "접수 담당자만 로그인 할 수 있습니다.";
				}
    	}
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>

<script type="text/javascript">
alert( "<%=resultStr%>" );
<%
if( isSuccess ) {
%>
	viewPager('<%=userAgent%>', '<%=workerView%>');
<%
} else {
%>
	alert( "<%=resultStr%>" );
	history.back();
<%
}
%>

function viewPager(browser, view_type) {
	var height = 700;
	if(browser == "MSIE") height = 750;
	if(view_type == "single") {
		window.open('${workerPath}/single.jsp','workerSingleView','width=400,height='+height+',left='+(screen.availWidth-400)/2+',top='+(screen.availHeight-800)/2+',location=no,resizable=no,directories=no,status=no,toolbar=no,scrollbars=no,menubar=no');
	} else {
		window.open('${workerPath}/multi.jsp','workerMultiView','width='+screen.availWidth+',height='+screen.availHeight+',top='+(screen.availHeight-600)/2+',location=no,resizable=yes,directories=no,status=no,toolbar=no,scrollbars=yes,menubar=no');
	}
	self.close();
}
</script>