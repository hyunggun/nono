<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.PatientBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="commonviewPath" value="${contextPath}/admin/commonview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
PatientBiz patientBiz = null;
try {
		patientBiz = new PatientBiz();
		paramMap.put("use_fg", "Y");
    resultMap = patientBiz.selectPatientPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
    <script type="text/javascript">
      $(document).ready(function() {
    	  $("#birthday").keyup(function(){$(this).val( $(this).val().replace(/[^0-9]/g,"") );} );
    	  
    	  $("#phone").keyup(function(e) {
					autoHypenPhone(this, e);
				});
	  });
      
      var selectedMainKey = 0;

      function evClickAdd() {
          selectedMainKey = 0;
          $('#cfPatientModal').modal('show');
          $("#cfDeleteButton").hide();
          
          $("#patient_nm").val( "" );
          $("#phone").val( "" );
          $("#birthday").val( "" );
          $("#reg_no").val( "" );
          $("#pre_reg").val( "" );
          $("#patient_id").val( "" );
      }

      function evClickRow( patientKey ) {
          selectedMainKey = patientKey;
          $('#cfPatientModal').modal('show');
          $("#cfDeleteButton").show();

          $.ajax({
              url : "${commonviewPath}/patient/json/ajaxRespPatientInfo.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {patient_id:patientKey},
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
          if(jQuery("#reg_no").val() != "" && jQuery("#reg_no").val() != jQuery("#pre_reg").val() ) {
	          $.ajax({
	              url : "${commonviewPath}/patient/json/ajaxRespDupl.jsp",
	              type : "get",
	              cache : false,
	              dataType : "json",
	              data : {reg_no:jQuery("#reg_no").val()},
	              success: function( patientData ) {
	                var isSuccess = patientData.resultCode;
	            	  if(isSuccess == "none") {
	            		  submitForm();
	            	  } else {
	            		  alert("존재하는 차트번호입니다.");
	            		  jQuery("#reg_no").val("");
	            		  jQuery("#reg_no").focus();
	            	  }
	              },
	              error: function(request,status,error) {
	              },
	              complete: function(jqXHR, textStatus) {
	              }
	          });
          } else {
        	  submitForm();
          }
      }

      function evClickDelete() {
          $('#cfPatientModal').modal('hide');
          jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
          
          $.ajax({
              url : "${commonviewPath}/patient/json/ajaxRespDeletePatient.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {reg_no:jQuery("#reg_no").val()},
              success: function( patientData ) {
            	  if(returnVal.resultData.resultCode) {
                 	 alert("환자정보를 삭제하였습니다.");
                 	 $("#cfSearchForm").submit();
                  } else {
                 	 alert("환자정보 삭제에 실패하였습니다.");
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
            $('#cfPatientModal').modal('hide');
            return;
          }
          $("#patient_id").val( data.patient_id );
          $("#patient_nm").val( data.patient_nm );
          $("#birthday").val( data.birthday );
          $("#phone").val( data.phone );
          $("#reg_no").val( data.reg_no );
          $("#pre_reg").val( data.reg_no );
      }
      
      function validate() {
          if( !$("#patient_nm").val() ) {
        	  alert("환자명을 입력하세요.");
        	  return false;
          } 
//           else if( !$("#phone").val()) {
//         	  alert("전화번호를 입력하세요.");
//         	  return false;
//           } else if( $("#phone").val()) {
//         	  var phoneLng = $("#phone").val();
//         	  phoneLng = phoneLng.replace(/-/g, "");
//         	  phoneLng = phoneLng.length;
//         	  if(phoneLng < 10 || phoneLng > 11) {
//             	  alert("전화번호의 길이가 맞지 않습니다.");
//             	  return false;
//         	  }
//           } else if( !$("#birthday").val() ) {
//         	  alert("생년월일을 입력하세요.");
//         	  return false;
//           }
          
          return true;
      }
      
      function submitForm() {
    	    jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
    	    var url = "${commonviewPath}/patient/json/ajaxRespInsertPatient.jsp";
          if( selectedMainKey ) url ="${commonviewPath}/patient/json/ajaxRespUpdatePatient.jsp";
          
          $.ajax({
              url : url,
              type : "POST",
              cache : false,
              dataType : "json",
              data : $("#cfMainForm").serialize(),
              success: function( returnVal ) {
            	  if(returnVal.resultData.resultCode) {
                	 alert("환자정보를 저장하였습니다.");
                	 $("#cfSearchForm").submit();
                 } else {
                	 alert("환자정보 저장에 실패하였습니다.");
                 }
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }
      
      function autoHypenPhone(obj, event){
      	var str = $(obj).val();
  			if(str == null) return "";
  			str = str.replace(/[^0-9]/g, '');
  			var tmp = '';
  			if( str.length < 4){
  				$(obj).val(str);
  			}else if(str.length < 7){
  			    tmp += str.substr(0, 3);
  			    tmp += '-';
  			    tmp += str.substr(3);
  			    $(obj).val(tmp);
  			}else if(str.length < 11){
  			    tmp += str.substr(0, 3);
  			    tmp += '-';
  			    tmp += str.substr(3, 3);
  			    tmp += '-';
  			    tmp += str.substr(6);
  			    $(obj).val(tmp);
  			}else {              
  			    tmp += str.substr(0, 3);
  			    tmp += '-';
  			    tmp += str.substr(3, 4);
  			    tmp += '-';
  			    tmp += str.substr(7, 4);
  			    $(obj).val(tmp);
  			}
      }
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">환자 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">Home</a></li>
            <li class="active">환자 관리</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="cfSearchForm" name="searchForm" method="POST">
	        			<input type="hidden" id="page_no" name="page_no">
	              <div class="col-sm-4 col-xs-8">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm">
	                    <input name="s_patient_nm" type="text" placeholder="환자명" class="form-control input-sm" value="${param.s_patient_nm}">
	                    <span class="input-group-btn">
	                      <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                    </span>
	                  </div>
	                </div>
	              </div>

	              <div class="col-xs-4 col-sm-4">
	                <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">환자 추가</button>
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
                        <th class="text-center">이름</th>
                        <th class="text-center">생년월일</th>
                        <th class="text-center">전화번호</th>
                        <th class="text-center">차트코드</th>
                        <th class="text-center">생성날짜</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>
                        	<a href="javascript:evClickRow('${data.patient_id}')">${data.patient_nm}</a>
                        </td>
                        <td>${data.birthday}</td>
                        <td>${data.phone}</td>
                        <td>${data.reg_no}</td>
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

    <!--Form Modals-->
    <div id="cfPatientModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="mainForm" method="POST">
				  <input type="hidden" id="patient_id" name="patient_id">
				  <input type="hidden" id="pre_reg" name="pre_reg">
			  
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">환자 정보</h3>
	          </div>
	
	          <div class="modal-body">
	            <div class="form-group">
	              <label>환자명</label>
	              <input id="patient_nm" name="patient_nm" type="text" placeholder="환자명을 입력하세요" class="form-control input-sm" maxlength="10" />
	            </div>
	            <div class="form-group">
	              <label>생년월일</label>
	              <input id="birthday" name="birthday" type="text" placeholder="ex)19920114" class="form-control input-sm" maxlength="8" />
	            </div>
	            <div class="form-group">
	              <label>전화번호</label>
	              <input id="phone" name="phone" type="text" placeholder="-없이 입력해주세요" class="form-control input-sm" maxlength="13" />
	            </div>
	            <div class="form-group">
	              <label>차트코드</label>
	              <input id="reg_no" name="reg_no" type="text" placeholder="차트번호를 입력해 주세요" class="form-control input-sm" maxlength="8" />
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