<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@page import="com.cofac.treat.ora.SessionManager"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
SessionManager sessionManager = SessionManager.getInstance(); 

RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

UserBiz userBiz = null;
Boolean isSuccess = false;
try {
	userBiz = new UserBiz();
    HashMap resultMap = userBiz.checkUser(paramMap);
    if( resultMap != null ) {
        String checkUser = (String) resultMap.get("checkUser");
        String checkPasswd = (String) resultMap.get("checkPasswd");

        if( "Valid".equals(checkUser) && "Right".equals(checkPasswd) ) { // 로그인 성공
        	
          Long user_id = (Long) resultMap.get("user_id");
          String sign_id = (String) resultMap.get("sign_id");
          String user_nm = (String) resultMap.get("user_nm");
          String user_role = (String) resultMap.get("role");
          String logo_url = Constants.LOGO_BASIS_URL;
          String theme_color = Constants.THEME_COLOR;
          String font_color = Constants.FONT_COLOR;
          
          String TREATVIEW_FG = Constants.TREATVIEW_FG;
          String BEDVIEW_FG = Constants.BEDVIEW_FG;
          String INPATVIEW_FG = Constants.INPATVIEW_FG;
          String EMR_FG = Constants.EMR_FG;
          String OPERATION_FG = Constants.OPERATION_FG;
          
          if( sign_id == null ) sign_id = "";
          if( user_nm == null ) user_nm = "";

          session.setAttribute("SESSION_USER_ID", user_id);
          session.setAttribute("SESSION_SIGN_ID", sign_id);
          session.setAttribute("SESSION_USER_NM", user_nm);
          session.setAttribute("SESSION_USER_ROLE", user_role);
          session.setAttribute("SESSION_LOGO_URL", logo_url);
          session.setAttribute("SESSION_THEME_COLOR", theme_color);
          session.setAttribute("SESSION_FONT_COLOR", font_color);
          session.setAttribute("SESSION_TREATVIEW_FG", TREATVIEW_FG);
          session.setAttribute("SESSION_BEDVIEW_FG", BEDVIEW_FG);
          session.setAttribute("SESSION_INPATVIEW_FG", INPATVIEW_FG);
          session.setAttribute("SESSION_EMR_FG", EMR_FG);
          session.setAttribute("SESSION_OPERATION_FG", OPERATION_FG);
          session.setMaxInactiveInterval(60*60*24*7);
          
          sessionManager.printloginUsers();
          if(sessionManager.isUsing(sign_id)) {
          	sessionManager.removeSession(sign_id);
          	sessionManager.setSession(session, sign_id);
          } else {
        	  sessionManager.setSession(session, sign_id);
          }

    	  	isSuccess = true;
        }
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>
<script type="text/javascript">
<%
if( isSuccess) {
%>
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