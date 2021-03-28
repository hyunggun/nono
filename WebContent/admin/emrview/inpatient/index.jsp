<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.InpatientBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="emrviewPath" value="${contextPath}/admin/emrview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
List roomList = null;
InpatientBiz inpatientBiz = null;
try {
	inpatientBiz = new InpatientBiz();
  resultMap = inpatientBiz.selectInpatientPage(paramMap);
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
	    });
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">EMR 조회</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">입원실 관리 메뉴</a></li>
            <li class="active">EMR 조회</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="cfSearchForm" name="search_form" method="POST">
	              <div class="col-sm-4">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm cf-mobile-margin">
	                    <select id="search_type" name="search_type" class="form-control input-sm">
	                    	<option value="P">환자명</option>
	                    	<option value="PN">환자번호</option>
	                    	<option value="R">입원실명</option>
	                    	<option value="RN">입원실번호</option>
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
                        <th class="text-center">입원실번호</th>
                        <th class="text-center">입원실명</th>
                        <th class="text-center">환자번호</th>
                        <th class="text-center">환자명</th>
                        <th class="text-center">나이</th>
                        <th class="text-center">성별</th>
                        <th class="text-center">진료과</th>
                        <th class="text-center">주치의</th>
                        <th class="text-center" style="width:20%;">진단명</th>
                        <th class="text-center">입원일</th>
                        <th class="text-center">수술일</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>${data.room_no}</td>
                        <td>${data.room_nm}</td>
                        <td>${data.patient_no}</td>
                        <td>${data.patient_nm}</td>
                        <td> ${data.age} </td>
                        <td> ${data.gender} </td>
                        <td> ${data.dept} </td>
                        <td> ${data.doctor_nm} </td>
                        <td> ${data.ptds} </td>
                        <td> ${data.addt} </td>
                        <td> ${data.opdt} </td>
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