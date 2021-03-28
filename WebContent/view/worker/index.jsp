<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="workerPath" value="${contextPath}/view/worker" />
<script>
window.open('${workerPath}/login.jsp','workerLoginView','width=400,height=700,left='+(screen.availWidth-400)/2+',top='+(screen.availHeight-800)/2+',location=no,resizable=no,directories=no,status=no,toolbar=no,scrollbars=no,menubar=no');
self.close();
</script>