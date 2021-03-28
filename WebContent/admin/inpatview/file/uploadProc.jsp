<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="startkr.util.YRequest"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.FileBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
YRequest req = new YRequest(request);
RequestUtils util = new RequestUtils();
String page_no = req.getParameter("page_no");
// HashMap paramMap = util.makeParamMap(req);
FileBiz fileBiz = null;
Boolean isSuccess = false;
try {
	fileBiz = new FileBiz();
	int fileId = fileBiz.uploadFile(req, "inpatImage", "R");
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
location.href = "index.jsp?page_no=<%=page_no%>";
<%
} else {
%>
alert("저장 실패하였습니다.");
history.back();
<%
}
%>
</script>