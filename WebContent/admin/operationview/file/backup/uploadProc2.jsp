<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="startkr.util.YRequest"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.InpatientBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
YRequest req = new YRequest(request);
RequestUtils util = new RequestUtils();
String inprm_id = req.getParameter("inprm_id");
// HashMap paramMap = util.makeParamMap(req);
InpatientBiz inpatientBiz = null;
Boolean isSuccess = false;
try {
	inpatientBiz = new InpatientBiz();
	int fileId = inpatientBiz.uploadFile(req, "inpImage");
    if(fileId > 0) {
      isSuccess = true;
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>
<script type="text/javascript">
<%
if( isSuccess ) {
%>
alert("저장하였습니다.");
location.href = "editView.jsp?inprm_id=<%=inprm_id%>";
<%
} else {
%>
alert("저장 실패하였습니다.");
history.back();
<%
}
%>
</script>