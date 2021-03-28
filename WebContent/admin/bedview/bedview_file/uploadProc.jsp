<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="startkr.util.YRequest"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
YRequest req = new YRequest(request);
RequestUtils util = new RequestUtils();
// HashMap paramMap = util.makeParamMap(req);
BedviewBiz bedviewBiz = null;
Boolean isSuccess = false;
try {
	bedviewBiz = new BedviewBiz();
	int fileId = bedviewBiz.uploadFile(req, "bedviewImage");
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
location.href = "index.jsp";
<%
} else {
%>
alert("저장 실패하였습니다.");
history.back();
<%
}
%>
</script>