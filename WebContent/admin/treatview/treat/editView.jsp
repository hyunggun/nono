<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.TreatBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="treatviewPath" value="${contextPath}/admin/treatview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
TreatBiz treatBiz = null;
try {
	treatBiz = new TreatBiz();
	paramMap.put("use_fg", "Y");
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
    	  var searchData = "${paramMap.search_status}";
    	  if(searchData != "") jQuery("#search_status").val("${paramMap.search_status}");
    	  
    	  $("#s_patient_nm").keypress(function(event) {
    	    if( event.which == 13 ) {
     		  callPatient();
     		  return false;
    	    }
        });
    	  
	    });
      
      var selectedMainKey = 0;

      function evClickAdd() {
          selectedMainKey = 0;
          $('#cfTreatModal').modal('show');
          $("#cfDeleteButton").hide();
          jQuery("#rank").parent("div").hide();
          
          $("#patient_nm").val( "" );
          $("#status").val( "S" );
          jQuery("#rank").html("<option value=''>선택안됨</option>");
          
          $("#s_patient_nm").val( "" );
          callPatient();
      }

      function evClickRow( treatKey ) {
          selectedMainKey = treatKey;
          jQuery("#rank").parent("div").show();
          $("#cfDeleteButton").show();

          $.ajax({
              url : "${treatviewPath}/treat/json/ajaxRespTreatInfo.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {treatment_id:treatKey},
              success: function( returnVal ) {
                  setDataOnForm( returnVal.resultData );
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }

      function evClickSave() {
          if( !validate() ) {
              return;
          }
          jQuery("#patient_nm").removeAttr("disabled");
          jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
          
          var url = "${treatviewPath}/treat/json/ajaxRespInsertTreat.jsp";
          if(selectedMainKey) {
        	  url = "${treatviewPath}/treat/json/ajaxRespUpdateTreat.jsp";
          }
          
          $.ajax({
              url : url,
              type : "POST",
              cache : false,
              dataType : "json",
              data : $("#cfMainForm").serialize(),
              success: function( returnVal ) {
            	  if(returnVal.resultData.resultCode) {
               	 alert("진료정보를 저장하였습니다.");
               	 $("#cfSearchForm").submit();
                } else {
               	 alert("진료정보 저장에 실패하였습니다.");
                }
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }

      function evClickDelete() {
    	  
          $('#cfTreatModal').modal('hide');
          
          $.ajax({
             url : "${treatviewPath}/treat/json/ajaxRespDeleteTreat.jsp",
             type : "get",
             cache : false,
             dataType : "json",
             data : {treatment_id:treatKey},
             success: function( returnVal ) {
                 if(returnVal.resultData.resultCode) {
                	 alert("진료정보를 삭제하였습니다.");
                	 $("#cfSearchForm").submit();
                 } else {
                	 alert("진료정보 삭제에 실패하였습니다.");
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
              $('#cfTreatModal').modal('hide');
              return;
          }
          $("#treatment_id").val( data.treatment_id );
          $("#patient_nm").val( data.patient_nm );
          $("#status").val( data.status );
          var status = data.status;
          if(status != "F" && status != "T") {
          	callRanking(status);
          } else {
        	  jQuery("#rank").html("<option value=''>선택안됨</option>");
          }

          $('#cfTreatModal').modal('show');
      }
      
      function validate() {
          if( !$("#patient_nm").val() ) {
        	  alert("환자를 설정하세요.");
        	  return false;
          }
          return true;
      }
      
      function callRanking() {
          $.ajax({
              url : "${treatviewPath}/treat/json/ajaxRespRankingList.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {treatment_id:selectedMainKey},
              success: function( result ) {
	            	  var list = result.resultData;
	                var htmlStr = "<option value=''>선택안함</option>";
	                for(var lp0=0; lp0<list.length; lp0++) {
	                    htmlStr += "<option value="+list[lp0].treatment_id+">"+list[lp0].ranking+"번째</option>";
	                }
	                jQuery("#rank").html(htmlStr);
	                jQuery("#rank").val(selectedMainKey);
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }
      
      function callPatient() {
    	  var s_patient_nm = jQuery("#s_patient_nm").val();
        $.ajax({
            url : "${treatviewPath}/treat/json/ajaxRespPatientList.jsp",
            type : "get",
            cache : false,
            dataType : "json",
            data : {s_patient_nm:s_patient_nm},
            success: function( result ) {
           	  var list = result.resultData;
               var htmlStr = "";
               for(var lp0=0; lp0<list.length; lp0++) {
               	htmlStr += "<tr><td>"+list[lp0].reg_no+"</td>";
                htmlStr += "<td>"+list[lp0].patient_nm+"</td>";
                htmlStr += "<td>"+list[lp0].phone+"</td>";
                htmlStr += "<td>"+list[lp0].birthday+"</td>";
                htmlStr += "<td><button type='button' class='btn btn-dafault' onclick='selectPatient(\""+list[lp0].patient_nm+"\")'>선택</button></td></tr>";
               }
               if(list.length == 0) htmlStr = "<tr><td colspan='4'>검색된 환자가 없습니다.</td><td></td><td></td><td></td></tr>";
               jQuery("#cfPatientList").html(htmlStr);
            },
            error: function(request,status,error) {
            },
            complete: function(jqXHR, textStatus) {
            }
        });
      }
      
      function selectPatient(patient_nm) {
//     	  jQuery("#patient_id").val(patient_id);
    	  jQuery("#patient_nm").val(patient_nm);
      }
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">진료 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">진료용 관리 메뉴</a></li>
            <li class="active">진료 정보</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="cfSearchForm" name="searchForm" method="POST" action="editView.jsp">
              	<input type="hidden" name="room_id" value="${param.room_id}">
			 	 				<input type="hidden" name="room_code" value="${param.room_code}">		
			  				<input type="hidden" id="page_no" name="page_no">
	              <div class="col-sm-2">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm cf-mobile-margin">
	                    <select id="search_status" name="search_status" class="form-control input-sm">
	                      <option value="">전체</option>
	                    	<option value="S">진료대기</option>
	                    	<option value="T">진료중</option>
	                    	<option value="F">진료완료</option>
	                    	<option value="H">보류</option>
	                    </select>
	                  </div>
	                </div>
	              </div>
	              <div class="col-sm-2">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm cf-mobile-margin">
	                    <select id="search_type" name="search_type" class="form-control input-sm">
	                    	<option value="D">의사</option>
	                    	<option value="P">환자</option>
	                    </select>
	                  </div>
	                </div>
	              </div>
	              <div class="col-sm-4 col-xs-8">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm">
	                    <input name="search_text" type="text" placeholder="이름을 검색하세요" class="form-control input-sm" value="${param.search_text}">
	                    <span class="input-group-btn">
	                      <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                    </span>
	                  </div>
	                </div>
	              </div>
	              <div class="col-xs-2 col-sm-2">
	                <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">진료 추가</button>
	                <button type="button" class="btn btn-space btn-warning cf-mobile-btn" onclick="location.href='index.jsp';">목록</button>
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
                        <th class="text-center">진료실</th>
                        <th class="text-center">의사</th>
                        <th class="text-center">환자</th>
                        <th class="text-center">상태</th>
                        <th class="text-center">생성날짜</th>
                        <th class="text-center">변경날짜</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>${data.room_nm}</td>
                        <td>
                        	<a href="javascript:evClickRow('${data.treatment_id}')">${data.doctor_nm}</a>
                        </td>
                        <td>${data.patient_nm}</td>
                        <td>${data.status_text}</td>
                        <td>${data.createdAt}</td>
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
    <div id="cfTreatModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="mainForm" method="POST">
			  <input type="hidden" id="treatment_id" name="treatment_id">
			  <input type="hidden" id="room_id" name="room_id" value="${param.room_id}">
			  <input type="hidden" id="emr_doctor_key" name="emr_doctor_key" value="${param.room_code}">
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">진료 정보</h3>
	          </div>
	
	          <div class="modal-body">
	            <div class="form-group">
	              <label>선택된 환자</label>
	              <input type="text" id="patient_nm" name="patient_nm" class="form-control input-sm" disabled="true">
	            </div>
	            <div class="form-group">
		            <label>환자명</label>
		            <div class="input-group input-search input-group-sm ">
                  <input id="s_patient_nm" name="s_patient_nm" type="text" placeholder="이름을 검색하세요" class="form-control input-sm">
                  <span class="input-group-btn">
                    <button type="button" class="btn btn-default" onClick="callPatient()"><i class="icon mdi mdi-search"></i></button>
                  </span>
                </div>
	            </div>
	            <div class="form-group" style="max-height:200px; width:100%; overflow-y:auto;">
	              <table class="table table-striped table-hover table-fw-widget">
									<thead>
										<tr>
											<th>차트번호</th>
											<th>환자명</th>
											<th>전화번호</th>
											<th>생년월일</th>
										</tr>
									</thead>
									<tbody id="cfPatientList">
										<tr>
											<td colspan="4">검색하시면 이곳에 기기정보가 나옵니다.</td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
	            </div>
	            <div class="form-group">
	              <label>진료상태</label>
	              <select name="status" id="status" class="form-control input-sm">
	              	<option value="S">진료대기</option>
	              	<option value="T">진료중</option>
	              	<option value="F">진료완료</option>
	              	<option value="H">보류</option>
	              </select>
	            </div>
	            <div class="form-group">
	              <label>순위변경</label>
	              <select name="rank" id="rank" class="form-control input-sm">
	              	<option value=''>선택안함</option>
	              </select>
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