<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.OproomBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="operationviewPath" value="${contextPath}/admin/operationview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
OproomBiz oproomBiz = null;
try {
	oproomBiz = new OproomBiz();
		
		paramMap.put("use_fg", "Y");
    resultMap = oproomBiz.selectOproomPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
    <script type="text/javascript">
      $(document).ready(function() {
    	  //selectNurseList();
	    });
      
      var selectedMainKey = 0;

      function evClickAdd() {
          selectedMainKey = 0;
          $('#cfRoomModal').modal('show');
          $("#cfDeleteButton").hide();
          
          $("#oproom_id").val( "" );
          $("#oproom_nm").val( "" );
          $("#nurse_nm").val( "" );
          $("#apporoom").val( "" );
          $("#max_cnt").val( 1 );
      }

      function evClickRow( roomKey ) {
          selectedMainKey = roomKey;
          $('#cfRoomModal').modal('show');
          $("#cfDeleteButton").show();

          $.ajax({
              url : "${operationviewPath}/room/json/oproomInfo.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {oproom_id:roomKey},
              success: function( returnVal ) {
                  setDataOnForm( returnVal.resultData.oproomObj );
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
          jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
          var url = "${operationviewPath}/room/json/updateOproom.jsp";
          if( !selectedMainKey ) { 
        	  url = "${operationviewPath}/room/json/insertOproom.jsp";
          }
          
          var roomkey = jQuery("#apporoom").val();
          jQuery("#apporoom").val(roomkey.toUpperCase());

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
             url : "${operationviewPath}/room/json/deleteOproom.jsp",
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
          $("#oproom_id").val( data.oproom_id );
          $("#oproom_nm").val( data.oproom_nm );
          $("#apporoom").val( data.apporoom );
      }
      
      function validate() {
          if( !$("#oproom_nm").val() ) {
        	  alert("수술실 명을 입력하세요.");
        	  return false;
          }
          return true;
      }
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">수술실 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">수술실 관리 메뉴</a></li>
            <li class="active">수술실</li>
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
	                    <input name="s_oproom_nm" type="text" placeholder="수술실 명을 입력하세요" class="form-control input-sm" value="${param.s_oproom_nm}">
	                    <span class="input-group-btn">
	                      <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                    </span>
	                  </div>
	                </div>
	              </div>

	              <div class="col-xs-4 col-sm-4">
	                <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">수술실 추가</button>
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
                        <th class="text-center">수술실명</th>
                        <th class="text-center">수술실 코드</th>
                        <th class="text-center">생성일짜</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>
                        	<a href="javascript:evClickRow('${data.oproom_id}')">${data.oproom_nm}</a>
                        </td>
                        <td>${data.apporoom}</td>
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
    <div id="cfRoomModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="mainForm" method="POST">
					<input type="hidden" id="page_no" name="page_no">
					<input type="hidden" id="s_oproom_nm" name="s_oproom_nm" value="${param.s_oproom_nm}">
					
					<input type="hidden" id="oproom_id" name="oproom_id">
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">수술실 정보</h3>
	          </div>
	          
	          <div class="modal-body">
	            <div class="form-group">
	              <label>수술실 명</label>
	              <input type="text" id="oproom_nm" name="oproom_nm"  class="form-control input-sm" placeholder="수술실 명을 입력하세요">
	            </div>
	            <div class="form-group">
	              <label>수술실 코드</label>
	              <input type="text" id="apporoom" name="apporoom"  class="form-control input-sm">
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
        App.init();
        setMainDataTable('#mainDataTable');
        var pageNo = "${paramMap.page_no}";
        if(pageNo != "") {
        	jQuery("#mainDataTable").dataTable().fnPageChange(${paramMap.page_no});
        }
      });
    </script>

</body>