<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.NoticeBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="treatviewPath" value="${contextPath}/admin/treatview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
NoticeBiz noticeBiz = null;
try {
	noticeBiz = new NoticeBiz();
	paramMap.put("single_multi", "S");
  resultMap = noticeBiz.selectNoticePage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
    <script type="text/javascript">
    $(document).ready(function() {
    	  var searchData = "${paramMap.search_type}";
    	  if(searchData != "") jQuery("#search_type").val("${paramMap.search_type}");
    	  
    		searchData = "${paramMap.posi_type}";
  	  	if(searchData != "") jQuery("#s_posi_type").val("${paramMap.posi_type}");
	    });

      function evClickRow( noticeKey, posiType ) {
    	  if(posiType == "T") {
    		  location.href = "editView.jsp?notice_id="+noticeKey;
    	  } else {
    		  location.href = "editBedView.jsp?notice_id="+noticeKey;
    	  }
    	  
      }

    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">공지사항 파일</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">공통 관리 메뉴</a></li>
            <li class="active">공지사항</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="cfSearchForm" name="searchForm" method="POST">
              	<input type="hidden" name="page_no">
              	<div class="col-sm-2">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm cf-mobile-margin">
	                    <select id="s_posi_type" name="posi_type" class="form-control input-sm">
	                    	<option value="">전체</option>
	                    	<option value="T">현황판</option>
	                    	<option value="B">병상용</option>
	                    </select>
	                  </div>
	                </div>
	              </div>
	              
	              <div class="col-sm-2">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm cf-mobile-margin">
	                    <select id="search_type" name="search_type" class="form-control input-sm">
	                    	<option value="C">내용</option>
	                    	<option value="W">작성자</option>
	                    </select>
	                  </div>
	                </div>
	              </div>
	
	              <div class="col-sm-4 col-xs-8">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm">
	                    <input name="search_text" type="text" placeholder="검색 내용을 입력하세요" class="form-control input-sm" value="${param.search_text}">
	                    <span class="input-group-btn">
	                      <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                    </span>
	                  </div>
	                </div>
	              </div>
	              
              </form>
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-12">
              <div class="panel panel-default panel-table">
                <div class="panel-body">
                  <table id="mainDataTable" class="table table-striped table-hover table-fw-widget">
                    <thead>
                      <tr class="text-center">
                        <th class="text-center">No.</th>
                        <th class="text-center">설정</th>
                        <th class="text-center">내용</th>
                        <th class="text-center">타입</th>
                        <th class="text-center">작성자</th>
                        <th class="text-center">작성날짜</th>
                        <th class="text-center">연동</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
<c:if test="${data.posi_type eq 'T' }">
												<td>현황판</td>
</c:if>
<c:if test="${data.posi_type eq 'B' }">
												<td>병상용</td>
</c:if>
                        <td>${data.content}</td>
<c:if test="${data.single_multi eq 'M' }">
												<td>전체공지</td>
</c:if>
<c:if test="${data.single_multi eq 'S' }">
												<td>개인공지</td>
</c:if>
                        <td>
                        	${data.writer_nm}
                        </td>
                        <td>${data.writed_dttm}</td>
                        <td><button type="button" class="btn btn-primary" onclick="javascript:evClickRow('${data.notice_id}', '${data.posi_type}')">연동</button></td>
                      </tr>
</c:forEach>
                    </tbody>
                  </table>
                </div><!-- /.panel-body -->
              </div><!-- /.panel -->
            </div><!-- /.col-sm-12 -->
          </div><!-- /.row -->

        </div><!-- /.main-content -->
      </div><!-- /.be-content -->

    <script src="${contextPath}/common/js/main.js" type="text/javascript"></script>
    <script src="${contextPath}/common/js/dataTableOption.js" type="text/javascript"></script>
    <script src="${contextPath}/common/js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="${contextPath}/common/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/dataTables.buttons.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.html5.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.flash.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.print.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.colVis.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.bootstrap.js" type="text/javascript"></script>

    <script type="text/javascript">
      $(document).ready(function(){
        //initialize the javascript
        App.init();
        setMainDataTable('#mainDataTable');
        var pageNo = "${paramMap.page_no}";
        if(pageNo != "") {
        	jQuery("#mainDataTable").dataTable().fnPageChange(${paramMap.page_no});
        }
      });
    </script>

</body>