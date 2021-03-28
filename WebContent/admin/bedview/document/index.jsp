<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.DocBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="bedviewPath" value="${contextPath}/admin/bedview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
DocBiz docBiz = null;
try {
	docBiz = new DocBiz();
  resultMap = docBiz.selectDocPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<head>
    <script type="text/javascript">
    jQuery(document).ready(function(){

    });
    
    function evClickDelete(idx) {
    	$.ajax({
          url : "${bedviewPath}/document/json/deleteDoc.jsp",
          type : "POST",
          dataType:"json",
          data : {"doc_id":idx},
          success: function( result ) {
            if(result.resultCode){
              alert("층 정보가 삭제되었습니다.");
            } else {
          	  alert("층 정보 삭제에 실패하였습니다.");
            }
            location.reload();
          },
          error: function(request,status,error) {
          },
          complete: function(jqXHR, textStatus) {
            
          }
      });
    }
    </script>
</head>

<body>
  <div class="be-content">
    <div class="page-head">
      <h2 class="page-head-title">재증명발급 관리</h2>
      <ol class="breadcrumb page-head-nav">
        <li><a href="#">병상용 관리 메뉴</a></li>
        <li class="active">재증명발급 관리</li>
      </ol>
    </div>

    <div class="main-content container-fluid">
    	<div class="cf-search-area">
      	<form id="searchForm" name="searchForm" action="index.jsp" method="post">
      		<input type="hidden" id="page_no" name="page_no"/>
	        <div class="row">
	          <div class="col-sm-4 col-xs-8">
	            <div class="email-search">
	              <div class="input-group input-search input-group-sm">
	                <input name="s_bedview_nm" type="text" placeholder="환자명을 입력하세요" class="form-control input-sm" value="${param.s_bedview_nm}">
	                <span class="input-group-btn">
	                  <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                </span>
	              </div>
	            </div>
	          </div>
	        </div>
      	</form>
      </div>
      
      <div class="row">
        <div class="col-sm-12">
          <div class="panel panel-default panel-table">
            <div class="panel-body">
              <table id="mainDataTable" class="table table-striped table-hover table-fw-widget">
                <thead>
                  <tr>
                    <th class="text-center">No.</th>
                    <th class="text-center">병실명</th>
                    <th class="text-center">환자명</th>
                    <th class="text-center">재증명 발급내역</th>
                    <th class="text-center">생성시각</th>
                    <th class="text-center">설정</th>
                  </tr>
                </thead>
                <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                  <tr>
                    <td class="text-center">${status.count}</td>
                    <td class="text-center">${data.ward}</td>
                    <td class="text-center">${data.patient_nm}</td>
                    <td class="text-center">${data.content}</td>
                    <td class="text-center">${data.date}</td>
                    <td class="text-center">
                      <button type="button" class="btn btn-danger" onclick="evClickDelete(${data.doc_id})">삭제</button>
                    </td>
                  </tr>
</c:forEach>
                </tbody>
              </table>
            </div>
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
      });
    </script>

</body>