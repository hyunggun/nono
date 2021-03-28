<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.InpatientBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
RequestUtils util = new RequestUtils();
String inprm_id = request.getParameter("inprm_id");

HashMap paramMap = util.makeParamMap(request);
InpatientBiz inpatientBiz = null;
Boolean isSuccess = false;
try {
	inpatientBiz = new InpatientBiz();
	isSuccess = inpatientBiz.deleteInpatientFile(paramMap);
} catch(Exception e) {
    e.printStackTrace();
}
%>
<script type="text/javascript">
<%
if( isSuccess ) {
%>
alert("삭제하였습니다.");
location.href = "editView.jsp?inprm_id=<%=inprm_id%>";
<%
} else {
%>
alert("오류가 발생했습니다.");
history.back();
<%
}
%>
</script>