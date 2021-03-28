<%@ page language="java" contentType="application/json;" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.YRequest"%>
<%@page import="com.cofac.treat.ora.biz.non.MenuBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.FileBiz"%>
<%
YRequest req = new YRequest(request);
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(req);

boolean isSuccess = false;
MenuBiz menuBiz = null;
try {
	
	menuBiz = new MenuBiz();
	int file_id = menuBiz.uploadFile(req, "uploadFile");
	paramMap.put("file_id", file_id);
	isSuccess = menuBiz.insertMenu(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
{
	"resultCode":<%=isSuccess%>
}