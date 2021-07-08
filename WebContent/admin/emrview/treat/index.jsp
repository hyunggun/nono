<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.TreatBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.TestemrBiz"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
// TreatBiz treatBiz = null;
OratreatBiz treatBiz = null;
try {
// 	treatBiz = new TreatBiz();
	treatBiz = new OratreatBiz();
  resultMap = treatBiz.selectTreatPage(paramMap);
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
      
      var selectedMainKey = 0;

      function evClickRow( acceptKey ) {
          selectedMainKey = acceptKey;

          $.ajax({
              url : "${emrviewPath}/treat/json/treatInfo.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : {acceptKey:acceptKey},
              success: function( returnVal ) {
                  setDataOnForm( returnVal.resultData.machineObj );
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }

      function setDataOnForm( data ) {
    	  if( !data ) {
              alert("정보를 가져오지 못했습니다.");
              $('#cfMachineModal').modal('hide');
              return;
          }
          
          $("#machine_id").val( data.ROOM_NM );
          $("#sign_id").val( data.sign_id );
          $("#position").val( data.position );
          $("#view_mode").val( data.view_mode );
          $("#use_fg").val( data.use_fg );
          $('#cfMachineModal').modal('show');
      }
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">EMR 조회</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">현황판 관리 메뉴</a></li>
            <li class="active">진료 조회</li>
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
	                    	<option value="D">의사번호</option>
	                    	<option value="DN">의사명</option>
	                    	<option value="P">환자번호</option>
	                    	<option value="PN">환자명</option>
	                    	<option value="R">진료실번호</option>
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
                        <th class="text-center">진료과목</th>
                        <th class="text-center">의사번호</th>
                        <th class="text-center">의사</th>
                        <th class="text-center">환자</th>
                        <th class="text-center">진료상태</th>
                        <th class="text-center">성별&나이</th>
                        <th class="text-center">전화번호</th>
                        <th class="text-center">등록일자</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>${data.room_nm}</td>
                        <td>${data.doctor_key}</td>
                        <td>${data.doctor_nm}</td>
                        <td>${data.patient_nm}</td>
                        <c:choose>
                        	<c:when test="${data.status eq 'S'}">
														<td>대기</td>
													</c:when>
													<c:when test="${data.status eq 'R'}">
														<td>예약</td>
													</c:when>
													<c:when test="${data.status eq 'T'}">
														<td>진료중</td>
													</c:when>
                        </c:choose>
                        <td> ${data.age}</td>
												<td>${data.phone}</td>
												<td>${data.createdAt}</td>
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