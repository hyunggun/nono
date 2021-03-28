<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.InpatientBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="inpatviewPath" value="${contextPath}/admin/inpatview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List fileList = null;
InpatientBiz inpatientBiz = null;
try {
	inpatientBiz = new InpatientBiz();
	fileList = inpatientBiz.selectInpatientFileList(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="fileList" value="<%=fileList%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
    <script type="text/javascript">

      function evClickDelete( fileKey ) {
    	  deleteForm.file_id.value = fileKey;
    	  deleteForm.submit();
      }
      
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">입원실 이미지</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">입원실 관리 메뉴</a></li>
            <li class="active">입원실 이미지</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
        
        	<div class="cf-search-area">
	          <div class="row">
	            <div class="col-sm-12">
                <form id="cfMainForm" name="mainForm" method="POST" action="uploadProc.jsp" enctype="multipart/form-data">
                	<input name="inprm_id" type="hidden" value="${param.inprm_id}" />
                  <table class="table" style="margin:0;">
                    <tbody>
                    	<tr class="text-center">
                        <td class="text-center" style="border:0; font-weight:bold;">용도</td>
                        <td style="border:0;">
                          <select name="use_type">
                            <option value="T">상단</option>
                            <option value="B">하단</option>
                            <option value="N">간호사</option>
                          </select>
                        </td>
                        <td class="text-center" style="border:0; font-weight:bold;">파일</td>
                        <td style="border:0;"> <input name="inpImage" type="file" /></td>
                        <td style="border:0;">
                          <button type="submit" class="btn btn-success">저장</button>
                          <button type="button" class="btn btn-warning" onclick="location.href='${inpatviewPath}/inpat_file'">목록</button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </form>
	            </div><!-- /.col-sm-12 -->
	          </div><!-- /.row -->
	        </div>
        	
          <div class="row">
            <div class="col-sm-12">
              <div class="panel panel-default panel-table">
                <div class="panel-body">
                <form id="cfDeleteForm" name="deleteForm" action="deleteProc.jsp">
                <input name="inprm_id" type="hidden" value="${param.inprm_id}" />
                <input name="file_id" type="hidden" />
                </form>
                  <table id="mainDataTable" class="table table-striped table-hover table-fw-widget">
                    <thead>
                      <tr class="text-center">
                        <th class="text-center">No.</th>
                        <th class="text-center">용도</th>
                        <th class="text-center">이미지명</th>
                        <th class="text-center">이미지</th>
                        <th class="text-center">삭제</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${fileList}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>${data.use_type}</td>
                        <td>${data.file_nm}</td>
                        <td> <img alt="${data.file_nm}" src="${data.file_url}"  style="max-width:300px; max-height:150px;"/> </td>
                        <td>
                          <button onclick="evClickDelete(${data.file_id})">삭제</button>
                        </td>
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