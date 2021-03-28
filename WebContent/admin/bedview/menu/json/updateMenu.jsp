<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.YRequest"%>
<%@page import="com.cofac.treat.ora.biz.non.MenuBiz"%>
<%
YRequest req = new YRequest(request);
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(req);

boolean isSuccess = false;
MenuBiz menuBiz = null;
try {
  
	menuBiz = new MenuBiz();
	int file_id = menuBiz.uploadFile(req, "uploadFile");
	if(file_id > 0) paramMap.put("file_id", file_id);
	isSuccess = menuBiz.updateMenu(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
	"resultCode":<%=isSuccess%>
}