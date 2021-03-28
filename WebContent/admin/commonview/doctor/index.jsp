<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="commonviewPath" value="${contextPath}/admin/commonview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
UserBiz userBiz = null;
try {
    userBiz = new UserBiz();
    resultMap = userBiz.selectDoctorPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
    <script type="text/javascript">
      $(document).ready(function() {
	    });
      
      var selectedMainKey = 0;

      function evClickRow( userKey ) {
          selectedMainKey = userKey;

          $.ajax({
              url : "${commonviewPath}/doctor/json/doctorInfo.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : {doctor_id:userKey},
              success: function( returnVal ) {
                  setDataOnForm( returnVal.resultData.userObj );
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }

      function evClickUpdate() {
        if( !validate() ) {
            return;
        }
        jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
	      $('#cfUserModal').modal('hide');
	      var data = jQuery("#cfMainForm").serialize();
	      
	      $.ajax({
            url : "${commonviewPath}/doctor/json/updateDoctor.jsp",
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
      
      function evClickResetPassword() {
    	  $.ajax({
              url : "${commonviewPath}/doctor/json/resetPasswd.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : {sign_id:jQuery("#sign_id").val()},
              success: function( result ) {
                var resultCode = result.resultData.resultCode;
		           	if(resultCode) {
		           		alert("비밀번호를 초기화하였습니다.");
		           	} else {
		           		alert("비밀번호 초기화에 실패하였습니다.");
		           	}
		           	$('#cfUserModal').modal('hide');
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
             $('#cfUserModal').modal('hide');
             return;
         }
          
         $("#user_id").val( data.user_id );
         $("#doctor_id").val( data.doctor_id );
         $("#sign_id").val( data.sign_id );
         $("#user_nm").val( data.user_nm );
         $("#position").val( data.position );
         $("#color").val( data.color );
         
         $("#use_fg").val( data.use_fg );
         
         $("#emr_doctor_key").val( data.emr_doctor_key );
      	  $("#medical_kind").val( data.medical_kind );
         
         $('#cfUserModal').modal('show');
      }
      
      function validate() {
          if( !$("#sign_id").val() ) {
        	  alert("아이디를 입력하세요.");
        	  return false;
          } else if( !$("#user_nm").val() ) {
        	  alert("이름을 입력하세요.");
        	  return false;
          }
          
          return true;
      }
    </script>
</head>

<body>
    <div class="be-content">
      <div class="page-head">
        <h2 class="page-head-title">의사 관리</h2>
        <ol class="breadcrumb page-head-nav">
          <li><a href="#">진료용 관리 메뉴</a></li>
          <li class="active"> 의료인 관리 </li>
        </ol>
      </div>

      <div class="main-content container-fluid">
        <div class="cf-search-area">
          <div class="row">
            <form id="cfSearchForm" name="search_form" method="POST">
             <input type="hidden" name="page_no">
             <div class="col-sm-4 col-xs-8">
               <div class="email-search">
                 <div class="input-group input-search input-group-sm">
                   <input name="s_user_nm" type="text" placeholder="사용자 이름을 검색해 주세요" class="form-control input-sm" value="${param.s_user_nm}">
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
                      <th class="text-center">이름</th>
                      <th class="text-center">직위</th>
                      <th class="text-center">색상</th>
                      <th class="text-center">사용유무</th>
                      <th class="text-center">생성날짜</th>
                    </tr>
                  </thead>
                  <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                    <tr class="text-center">
                      <td>${status.count}</td>
                      <td>
                      	<a href="javascript:evClickRow('${data.user_id}')">${data.sign_id}</a>
                      </td>
                      <td>${data.user_nm}</td>
	               	  <td>${data.position}</td>
                      <td>${data.color}</td>
<c:if test="${data.use_fg eq 'Y'}">
										<td>사용</td>
</c:if>
<c:if test="${data.use_fg eq 'N'}">
										<td>휴면</td>
</c:if>
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
    <div id="cfUserModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="mainForm" method="POST">
				  <input type="hidden" id="user_id" name="user_id">
				  <input type="hidden" id="doctor_id" name="doctor_id">
				  <input type="hidden" id="page_no" name="page_no">
				  <input type="hidden" name="s_user_nm" value="${param.s_user_nm}">
			  
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">사용자 정보</h3>
	          </div>
	
	          <div class="modal-body">
	            <div class="form-group">
	              <label>아이디</label>
	              <input id="sign_id" name="sign_id" type="text" class="form-control input-sm" maxlength="30" readonly="true"/>
	            </div>
	            <div class="form-group">
	              <label>이름</label>
	              <input id="user_nm" name="user_nm" type="text" placeholder="이름을 입력해 주세요" class="form-control input-sm" maxlength="30" />
	            </div>
	            <div class="form-group">
	              <label>직위</label>
	              <input id="position" name="position" type="text" placeholder="ex)병원장" class="form-control input-sm" maxlength="10" />
	            </div>
	            
	            <div class="form-group">
	              <label>의과 종류</label>
	              <input id="medical_kind" name="medical_kind" type="text" placeholder="ex)구강외과" class="form-control input-sm" maxlength="30" />
	              
	            </div>
	            <div class="form-group">
	              <label>emr_doctor_key</label>
	              <input id="emr_doctor_key" name="emr_doctor_key" type="text" class="form-control input-sm" maxlength="30" />
	            </div>
	            <div class="form-group">
	              <label>부서 색상</label>
	              <input type="color" id="color" name="color"  class="form-control input-sm">
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
	            <button id="cfResetButton" type="button" class="btn btn-warning" onclick="evClickResetPassword()">비밀번호 초기화</button>
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