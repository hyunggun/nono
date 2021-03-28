<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="startkr.util.*" %>
<%@page import="com.cofac.treat.ora.common.*"%>
<%@ page import="startkr.basic.common.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="<%= request.getContextPath() %>"/>
<c:set var="imagePath" value="${contextPath}/startkr/common/images"/>
<%
	Integer totalCount = 0;
	Integer currentPage = 1;
	String listUrl = request.getRequestURI();
	if( StringUtils.isNotEmpty( request.getParameter("totalCount") ) ) {
		totalCount = Integer.parseInt(request.getParameter("totalCount"));
	}
	if( StringUtils.isNotEmpty( request.getParameter("currentPage") ) ) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	if( StringUtils.isNotEmpty( request.getParameter("listUrl") ) ) {
		listUrl = request.getParameter("listUrl");
	}
    int itemLength = Constants.LIST_LENGTH; // 한 페이지에 보이는 항목 수

    // 마지막 페이지
    int lastPage = (int) Math.ceil( (double) totalCount / (double) itemLength );
    // 하단 페이징 개수
    int blockLength = Constants.BLOCK_LENGTH;
    int startPage = ( (int) Math.ceil( (double) ( currentPage ) / (double) blockLength ) - 1 ) * blockLength + 1;
    
    int endPage = startPage + blockLength - 1;
    if( endPage > lastPage ) endPage = lastPage;
    if( endPage == 0 ) endPage = 1;
%>

<script type="text/javascript">
function goPage( targetPage ) {
	// list 페이지에 반드시 mainForm 객체 필요
	mainForm.action = "<%=listUrl%>";
	mainForm.currentPage.value = targetPage;
	mainForm.submit();
}
</script>

        <!-- Pagination -->
        <div class="row text-center">
            <div class="col-lg-12">
                <ul class="pagination">
	<%
		if( currentPage > 1 ) { // 첫 페이지가 아니면 링크
	%>
                    <li>
                        <a href="#" onclick="goPage(1)">&laquo;</a>
                    </li>
	<%		
		} else { // 첫 페이지 없음 - 이미지만
	%>
                    <li>
                        <a href="#">&laquo;</a>
                    </li>
	<%
		}
		if( startPage > 1 ) { // 이전 페이지 있으면 링크
    %>
                    <li>
                        <a href="#" onclick="goPage(<%= startPage - 1 %>)">&laquo;</a>
                    </li>
    <%		
    	} else { // 이전 페이지 없음 - 이미지만
    		
    %>
                    <li>
                        <a href="#">&laquo;</a>
                    </li>
    <%
    	}

		for( int lp1=startPage ; lp1<=endPage ; lp1++ ) {

			if( lp1 == currentPage || lastPage == 0 ) {
	%>
                    <li class="active">
                        <a href="#"onclick="goPage(<%= lp1 %>)"><%= lp1 %></a>
                    </li>
	<%
			} else {
	%>
                    <li>
                        <a href="#"onclick="goPage(<%= lp1 %>)"><%= lp1 %></a>
                    </li>
	<%
			}
			 
//			if( lp1 < endPage) out.print(" | ");
		}

    	if( endPage < lastPage ) { // 다음 페이지 있으면 링크
    %>
                    <li>
                        <a href="#" onclick="goPage(<%= endPage + 1 %>)">&raquo;</a>
                    </li>
    <%		
    	} else { // 다음 페이지 없음 - 이미지만
   	%>
                    <li>
                        <a href="#">&raquo;</a>
                    </li>
   	<%
    	}

    	if( currentPage < lastPage ) { // 마지막 페이지가 아니면 링크
    %>
                    <li>
                        <a href="#" onclick="goPage(<%= lastPage %>)">&raquo;</a>
                    </li>
    <%		
    	} else { // 마지막 페이지 없음 - 이미지만
   	%>

                    <li>
                        <a href="#">&raquo;</a>
                    </li>
     	<%
    	}
   	%>
                </ul>
            </div>
        </div>
        <!-- /.row -->