<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.FloorBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="bedviewPath" value="${contextPath}/admin/bedview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
List floorList = null;
BedviewBiz bedviewBiz = null;
FloorBiz floorBiz = null;
try {
	bedviewBiz = new BedviewBiz();
  resultMap = bedviewBiz.selectBedviewPage(paramMap);
  
  floorBiz = new FloorBiz();
  floorList = floorBiz.selectFloorList(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="floorList" value="<%=floorList%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
    <script type="text/javascript">
      $(document).ready(function() {
    	  
	    });
      
      var selectedMainKey = 0;

      function evClickRow( bedviewKey ) {
          selectedMainKey = bedviewKey;

          $.ajax({
              url : "${bedviewPath}/bedview/json/bedviewInfo.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : {bedview_id:bedviewKey},
              success: function( result ) {
                  setDataOnForm( result.resultData.bedviewObj );
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }

      function evClickUpdate() {

          jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
		      $('#cfBedviewModal').modal('hide');
		      var data = jQuery("#cfMainForm").serialize();
		      
		      $.ajax({
	            url : "${bedviewPath}/bedview/json/updateBedview.jsp",
	            type : "POST",
	            cache : false,
	            dataType : "json",
	            data : data,
	            success: function( result ) {
	            	if(result.resultCode) {
	              	alert("저장하였습니다.");
	              } else {
	              	alert("저장에 실패하였습니다.");
	              }
	            	submitForm();
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
              $('#cfBedviewModal').modal('hide');
              return;
          }
          
          $("#bedview_id").val( data.bedview_id );
          $("#sign_id").val( data.sign_id );
          $("#patient_nm").val( data.patient_nm );
          $("#patient_code").val( data.patient_code );
          $("#floor_id").val( data.floor_id );
          $("#ward").val( data.ward );
          $("#memo").val( data.memo );
          $("#use_fg").val( data.use_fg );
          $('#cfBedviewModal').modal('show');
      }
      
      function submitForm() {
    	    jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
          $("#searchForm").submit();
      }
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">병상용 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">병상용 관리 메뉴</a></li>
            <li class="active">병상용</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="searchForm" name="searchForm" method="POST">
              	<input type="hidden" name="page_no">
	              <div class="col-sm-4 col-xs-8">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm">
	                    <input name="s_sign_id" type="text" placeholder="아이디를 검색해 주세요" class="form-control input-sm" value="${param.s_sign_id}">
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
                        <th class="text-center">아이디</th>
                        <th class="text-center">환자명</th>
                        <th class="text-center">환자차트코드</th>
                        <th class="text-center">위치정보</th>
                        <th class="text-center">층정보</th>
                        <th class="text-center">기타/메모</th>
                        <th class="text-center">생성날짜</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>
                        	<a href="javascript:evClickRow('${data.bedview_id}')">${data.sign_id}</a>
                        </td>
                        <td>${data.patient_nm}</td>
				                <td>${data.patient_code}</td>
                        <td>${data.ward}</td>
                        <td>${data.floor_nm}</td>
                        <td>${data.memo}</td>
                        <td>${data.updatedAt}</td>
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

    <!--Form Modals-->
    <div id="cfBedviewModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="mainForm" method="POST">
					<input type="hidden" id="bedview_id" name="bedview_id">
					<input type="hidden" id="page_no" name="page_no">
					<input type="hidden" id="s_sign_id" name="s_sign_id" value="${param.s_sign_id}">
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">병상용 정보</h3>
	          </div>
	
	          <div class="modal-body">
	            <div class="form-group">
	              <label>아이디</label>
	              <input id="sign_id" name="sign_id" type="text" placeholder="아이디를 입력하세요" class="form-control input-sm" maxlength="30" disabled="disabled"/>
	            </div>
	            <div class="form-group">
	              <label>환자명</label>
	              <input id="patient_nm" name="patient_nm" type="text" class="form-control input-sm" maxlength="10" />
	            </div>
	            <div class="form-group">
	              <label>환자차트코드</label>
	              <input id="patient_code" name="patient_code" type="text" class="form-control input-sm" maxlength="30" />
	            </div>
	            <div class="form-group">
	              <label>위치 정보</label>
	              <input id="ward" name="ward" type="text" placeholder="ex)102호" class="form-control input-sm" maxlength="120" />
	            </div>
	            <div class="form-group">
	              <label>층 선택</label>
	              <select id="floor_id" name="floor_id" class="form-control input-sm">
		              <c:forEach var="data" items="${floorList}">
		              	<option value="${data.floor_id}">${data.floor_nm}</option>
		              </c:forEach>
	              </select>
	            </div>
	            <div class="form-group">
	              <label>기타 / 메모</label>
	              <textarea id="memo" name="memo" placeholder="기타 / 메모" class="form-control input-sm" maxlength="200" rows="5" style="resize:none;"></textarea>
	            </div>
	            <div class="form-group">
	              <label>사용유무</label>
	              <select id="use_fg" name="use_fg" class="form-control input-sm">
	              	<option value='Y'>사용</option>
	              	<option value='N'>휴면</option>
	              </select>
	            </div>
	          </div>
	          
	          <div class="modal-footer">
	            <button type="button" data-dismiss="modal" class="btn btn-default md-close">취소</button>
	            <button type="button" class="btn btn-success" onclick="evClickUpdate()">저장</button>
	          </div>
	          
	        </div>
        </form>
      </div>
    </div>

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