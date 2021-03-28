<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="startkr.util.YRequest"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.FileBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
YRequest req = new YRequest(request);
RequestUtils util = new RequestUtils();
String inprm_id = req.getParameter("inprm_id");
// HashMap paramMap = util.makeParamMap(req);
FileBiz fileBiz = null;
Boolean isSuccess = false;
try {
	fileBiz = new FileBiz();
	int fileId = fileBiz.uploadFile(req, "uploadFile", "L");
	
	if(fileId > 0) {
    isSuccess = true;
  }
	
	fileId = fileBiz.uploadFile(req, "m_uploadFile", "M");
  
	if(fileId > 0) {
    isSuccess = true;
  }
} catch(Exception e) {
    e.printStackTrace();
}
%>
<form name="basicForm" method="post" action="${contextPath}/admin/logoutProc.jsp"></form>
<script type="text/javascript">
<%
if( isSuccess ) {
%>
alert("저장하였습니다.");
basicForm.submit();
<%
} else {
%>
alert("저장 실패하였습니다.");
history.back();
<%
}
%>
</script>