<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.InpatientBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="inpatviewPath" value="${contextPath}/admin/inpatview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
InpatientBiz inpatientBiz = null;
try {
	inpatientBiz = new InpatientBiz();

	paramMap.put("use_fg", "Y");
	resultMap = inpatientBiz.selectInpatientRoomPage(paramMap);
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
<script type="text/javascript">
	var oraInpatientList = new Array();
      $(document).ready(function() {
    	  //selectNurseList();
	    });

      var selectedMainKey = 0;

      function evClickAdd() {
          selectedMainKey = 0;
          $('#cfRoomModal').modal('show');
          $("#cfDeleteButton").hide();

          $("#inprm_id").val( "" );
          $("#inprm_nm").val( "" );
          $("#nurse_nm").val( "" );
//           $("#emr_opRoom_key").val( "" );
          $("#max_cnt").val( 1 );
      }

      function evClickRow( opRoomKey ) {
          selectedMainKey = opRoomKey;
          $('#cfRoomModal').modal('show');
          $("#cfDeleteButton").show();

          $.ajax({
              url : "${inpatviewPath}/room/json/inpatRoomInfo.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {inprm_id:opRoomKey},
              success: function( returnVal ) {
                  setDataOnForm( returnVal.resultData.inpatientObj );
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }
      function getOraclePatientList(roomNo){
    	  
    	  $.ajax({
              url : "${inpatviewPath}/room/json/selectOraPatientList.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              async : false,
              data : {roomNo : roomNo},
              success: function( returnVal ) {
            	  oraInpatientList = returnVal.resultData.oraInpatientList;
            	  for(var i = 0; i < oraInpatientList.length; i++){
            		  var roomNo = oraInpatientList[i].room_no;
            		  var patientNo = oraInpatientList[i].patient_no;
            		  var addt = oraInpatientList[i].addt;
            		  getBedpos( patientNo, addt, roomNo, i );
            	  }
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
            	  //oracle에서 가져온 환자정보로 popup 창에 환자 리스트 생성
            	  if(oraInpatientList.length  < 1 ) {
        			  console.log("EMR에서 해당 roomNo의 입원된 환자 정보를 받아올 수 없습니다.");
        			  return;
        		  }
                  
              }
          });
    	  
    	  console.log(oraInpatientList);
    	  var html = "";
    	  for(var i = 0; i < oraInpatientList.length; i++){
   			  html += '<div>';
   			  html += '<label>'+ oraInpatientList[i].patient_nm +'</label>';
   	          html += '<select id='+ oraInpatientList[i].patient_no +'>';
   	          for(var j = 1; j < 10 ; j ++){
       	          html += '<option value="'+ j +'"';
       	          if( j == oraInpatientList[i].bedpos){
       	        	  html += ' selected ';
       	          };
       	          html += '>'+ j +'</option>';
   	          }
   	          html += '</select>';
   			  html += '</div>';
    	  }
          $("#patient-list").html(html);
      }
      /*
      *	patientNo : 환자번호 , addt: 입원날짜, roomNo: 방번호
      */
      
      
      function getBedpos(patientNo, addt, roomNo, idx){
    	  var bedpos = "";
    	  $.ajax({
              url : "${inpatviewPath}/room/json/selectBedpos.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              async : false,
              data : {patient_no : patientNo, addt: addt, room_no: roomNo},
              success: function( returnVal ) {
            	  oraInpatientList[idx].bedpos = returnVal.bedpos;
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
            	  return bedpos;
              }
          });
      }
      function evClickSaveBedpos() {
		  var failList = "";
		  for(var i = 0 ; i < oraInpatientList.length; i++){
			  var patient_no = oraInpatientList[i].patient_no;
			  oraInpatientList[i].bedpos = $("#"+patient_no).val();
			  
			  console.log();
			  $.ajax({
	              url : "${inpatviewPath}/room/json/upsertBedpos.jsp",
	              type : "POST",
	              cache : false,
	              dataType : "json",
	              data : oraInpatientList[i],
	              success: function( result ) {
	              	if(!result.resultData.resultCode) {
	                	if(failList.length > 0){
	                		failList += ',';		
	                	}
	                	failList += oraInpatientList[i];
	                }
	              },
	              error: function(request,status,error) {
	              },
	              complete: function(jqXHR, textStatus) {
	            	  
	              }
	          });
			  
		  }
		  
		  if(failList.length > 0){
    		  alert("업데이트에 실패하였습니다. ("+ failList+")");
    	  }else{
    		  $('#cfBedPosModal').modal('hide');  
    		  oraInpatientList = [];
    	  }
  	      
		  
		}
	  function evClickBedposSetting( roomNo ){
          $("#patient-list").empty();
          $("#bedpos_inprm_nm").val(roomNo);
          $('#cfBedPosModal').modal('show');
// 		  //oracle 에서 환자 리스트 받아와서 해당 환자의 chart 번호를 다시 select 하여 표시
		  getOraclePatientList(roomNo);
	  }
      function evClickSave() {
          if( !validate() ) {
              return;
          }
          jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
          var url = "${inpatviewPath}/room/json/updateInpatRoom.jsp";
          if( !selectedMainKey ) {
        	  url = "${inpatviewPath}/room/json/insertInpatRoom.jsp";
          }

//           var opRoomkey = jQuery("#emr_opRoom_key").val();
//           jQuery("#emr_opRoom_key").val(opRoomkey.toUpperCase());

  	      $('#cfRoomModal').modal('hide');

  	      var data = jQuery("#cfMainForm").serialize();

  	      $.ajax({
              url : url,
              type : "POST",
              cache : false,
              dataType : "json",
              data : data,
              success: function( result ) {
              	if(result.resultData.resultCode) {
                	alert("저장하였습니다.");
                	jQuery("#cfSearchForm").submit();
                } else {
                	alert("저장에 실패하였습니다.");
                }
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }

      function evClickDelete() {
    	  jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);

 	      $('#cfRoomModal').modal('hide');

 	      var data = jQuery("#cfMainForm").serialize();

 	      $.ajax({
             url : "${inpatviewPath}/room/json/deleteInpatRoom.jsp",
             type : "POST",
             cache : false,
             dataType : "json",
             data : data,
             success: function( result ) {
             	if(result.resultData.resultCode) {
               	alert("삭제하였습니다.");
               	jQuery("#cfSearchForm").submit();
               } else {
               	alert("삭제에 실패하였습니다.");
               }
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
              $('#cfRoomModal').modal('hide');
              return;
          }
          $("#inprm_id").val( data.inprm_id );
          $("#max_cnt").val( data.max_cnt );
          $("#inprm_nm").val( data.inprm_nm );
          $("#emr_room_key").val( data.emr_room_key );
          $("#nurse_nm").val( data.nurse_nm );
      }

      function validate() {
          if( !$("#inprm_nm").val() ) {
        	  alert("입원실 명을 입력하세요.");
        	  return false;
          }
          return true;
      }
    </script>
</head>

<body>

	<div class="be-content">
		<div class="page-head">
			<h2 class="page-head-title">입원실 관리</h2>
			<ol class="breadcrumb page-head-nav">
				<li><a href="#">입원실 관리 메뉴</a></li>
				<li class="active">입원실</li>
			</ol>
		</div>

		<div class="main-content container-fluid">
			<div class="cf-search-area">
				<div class="row">
					<form id="cfSearchForm" name="searchForm" method="POST">
						<input type="hidden" name="page_no">
						<div class="col-sm-4 col-xs-8">
							<div class="email-search">
								<div class="input-group input-search input-group-sm">
									<input name="s_inprm_nm" type="text" placeholder="입원실 명을 입력하세요" class="form-control input-sm" value="${param.s_inprm_nm}">
									<span class="input-group-btn">
										<button type="submit" class="btn btn-default">
											<i class="icon mdi mdi-search"></i>
										</button>
									</span>
								</div>
							</div>
						</div>

						<div class="col-xs-4 col-sm-4">
							<button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">입원실 추가</button>
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
										<th class="text-center">입원실명</th>
										<th class="text-center">입원실 코드</th>
										<th class="text-center">최대 인수</th>
										<th class="text-center">담당 간호사</th>
										<th class="text-center">배드순서지정</th>
										<th class="text-center">생성일짜</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="data" items="${resultMap.list}" varStatus="status">
										<tr class="text-center">
											<td>${status.count}</td>
											<td><a href="javascript:evClickRow('${data.inprm_id}')">${data.inprm_nm}</a></td>
											<td>${data.emr_room_key}</td>
											<td>${data.max_cnt}</td>
											<td>${data.nurse_nm}</td>
											<td><button class="btn btn-success" onclick="evClickBedposSetting(${data.inprm_id})">설정</button></td>
											<td>${data.createdAt}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-sm-12 -->
			</div>
			<!-- /.row -->

		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.be-content -->

	<!--Form Modals-->
	<div id="cfRoomModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
		<div class="modal-dialog custom-width">
			<form id="cfMainForm" name="mainForm" method="POST">
				<input type="hidden" id="page_no" name="page_no">
				<input type="hidden" id="s_inprm_nm" name="s_inprm_nm" value="${param.s_inprm_nm}">
				<input type="hidden" id="inprm_id" name="inprm_id">

				<div class="modal-content">
					<div class="modal-header">
						<button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close">
							<span class="mdi mdi-close"></span>
						</button>
						<h3 class="modal-title">입원실 정보</h3>
					</div>

					<div class="modal-body">
						<div class="form-group">
							<label>입원실 명</label>
							<input type="text" id="inprm_nm" name="inprm_nm" class="form-control input-sm" placeholder="입원실 명을 입력하세요">
						</div>
						<div class="form-group">
							<label>입원실 코드</label>
							<input type="text" id="emr_room_key" name="emr_room_key" class="form-control input-sm">
						</div>
						<div class="form-group">
							<label>최대 인수</label> <select id="max_cnt" name="max_cnt" class="form-control input-sm">
								<option value=1>1인실</option>
								<option value=2>2인실</option>
								<option value=4>4인실</option>
								<option value=6>6인실</option>
								<option value=8>8인실</option>
							</select>
						</div>
						<div class="form-group">
							<label>담당 간호사</label>
							<input type="text" id="nurse_nm" name="nurse_nm" class="form-control input-sm" disabled>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" data-dismiss="modal" class="btn btn-default md-close">취소</button>
						<button type="button" class="btn btn-success" onclick="evClickSave()">저장</button>
						<button id="cfDeleteButton" type="button" class="btn btn-warning" onclick="evClickDelete()">삭제</button>
					</div>

				</div>
			</form>
		</div>
	</div>

	<!--Form Modal bedpos-->
	<div id="cfBedPosModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
		<div class="modal-dialog custom-width">
			<form id="cfBedposForm" name="bedPosForm" method="POST">
				<input type="hidden" id="page_no" name="page_no">
				<input type="hidden" id="s_bedpos" name="s_bedpos" value="${param.s_bedpos}">
				<input type="hidden" id="bedpos_id" name="bedpos_id">

				<div class="modal-content">
					<div class="modal-header">
						<button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close">
							<span class="mdi mdi-close"></span>
						</button>
						<h3 class="modal-title">입원실 정보</h3>
					</div>

					<div class="modal-body">
						<div class="form-group">
							<label>입원실 명</label>
							<input type="text" id="bedpos_inprm_nm" name="inprm_nm" class="form-control input-sm" placeholder="입원실 명을 입력하세요">
						</div>
						<div class="form-group">
							<label>환자 리스트</label>
							<div id="patient-list">
								
							</div>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" data-dismiss="modal" class="btn btn-default md-close">취소</button>
						<button type="button" class="btn btn-success" onclick="evClickSaveBedpos()">저장</button>
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
        App.init();
        setMainDataTable('#mainDataTable');
        var pageNo = "${paramMap.page_no}";
        if(pageNo != "") {
        	jQuery("#mainDataTable").dataTable().fnPageChange(${paramMap.page_no});
        }
      });
    </script>

</body>
