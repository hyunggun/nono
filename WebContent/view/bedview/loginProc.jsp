<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="com.cofac.treat.ora.SessionManager"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
SessionManager sessionManager = SessionManager.getInstance(); 
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
BedviewBiz bedviewBiz = new BedviewBiz();
Boolean isSuccess = false;
HashMap resultMap = null;
try {
    resultMap = bedviewBiz.checkBedView(paramMap);
      if((Integer)resultMap.get("result") == 1 ){
        isSuccess = true;
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>
<script type="text/javascript">
<%
if( isSuccess) {
  String m_logo_url = Constants.LOGO_MOBILE_URL;
  String theme_color = Constants.THEME_COLOR;
  String font_color = Constants.FONT_COLOR;
  
  Integer bedview_id = (int) resultMap.get("bedview_id");
  String sign_id = (String) resultMap.get("sign_id");
  Integer patient_id = (int) resultMap.get("patient_id");
  String patient_code = (String) resultMap.get("patient_code");
  

  session.setAttribute("SESSION_MOBILE_LOGO_URL", m_logo_url);
  session.setAttribute("SESSION_THEME_COLOR", theme_color);
  session.setAttribute("SESSION_FONT_COLOR", font_color);
  session.setAttribute("SESSION_BEDVIEW_ID", bedview_id);
  session.setAttribute("SESSION_PATIENT_ID", patient_id);
  session.setAttribute("SESSION_PATIENT_CODE", patient_code);
  session.setMaxInactiveInterval(60*60*24*31);
  
  sessionManager.printloginUsers();
  if(sessionManager.isUsing(sign_id)) {
  	sessionManager.removeSession(sign_id);
  	sessionManager.setSession(session, sign_id);
  } else {
	  sessionManager.setSession(session, sign_id);
  }
%>
if(window.MtvAndroidApp != null) {
	window.MtvAndroidApp.executeType("{bedview_id:"+"<%=bedview_id%>"+", m_logo_url:"+"\"<%=m_logo_url%>\""+"}");
}
location.href = "index.jsp";
<%
} else {
%>
		alert("로그인 실패하였습니다.");
		history.back();
<%
}
%>
</script>