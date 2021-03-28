<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

UserBiz userBiz = null;
Boolean isSuccess = false;
try {
	userBiz = new UserBiz();
  isSuccess = userBiz.updateUser(paramMap);
} catch(Exception e) {
    e.printStackTrace();
}
%>
<form name="basicForm" method="post" action="${contextPath}/admin/logoutProc.jsp">
</form>
<script type="text/javascript">
<%
if( isSuccess ) {
%>
alert("개인정보를 수정 하였습니다. 재 로그인이 필요합니다.");
basicForm.submit();
<%
} else {
%>
alert("개인정보 수정에 실패하였습니다.");
history.back();
<%
}
%>
</script>