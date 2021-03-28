<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
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
FloorBiz floorBiz = null;
try {
	floorBiz = new FloorBiz();
  resultMap = floorBiz.selectFloorPage(paramMap);
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
    
    function evClickAdd() {
    	$("#floor_id").val("");
    	$("#floor_nm").val("");
    	$("#floor_code").val("");
    	
    	$("#cfFloorModal").modal('show');
    }
    
    function evClickRow(idx) {
    	var floor_id = idx;
    	$.ajax({
          url : "${bedviewPath}/call/json/floorInfo.jsp",
          type : "POST",
          dataType:"json",
          data : {"floor_id":floor_id},
          success: function( result ) {
            var data = result.resultData.floorObj;
            setDataForm(data);
          },
          error: function(request,status,error) {
          },
          complete: function(jqXHR, textStatus) {
            
          }
      });
    }
    
    function evClickSave() {
    	if(!validate()) {
    		return false;
    	}
    	
    	$('#cfFloorModal').modal('hide');
    	
    	var url = "${bedviewPath}/call/json/insertFloor.jsp";
    	
    	if($("#floor_id").val()) {
    		url = "${bedviewPath}/call/json/updateFloor.jsp";
    	}
    	
    	$.ajax({
          url : url,
          type : "POST",
          data : $("#cfMainForm").serialize(),
          success: function( result ) {
            if(result.resultCode){
              alert("층 정보가 저장되었습니다.");
            } else {
          	  alert("층 정보 저장에 실패하였습니다.");
            }
            submitForm();
          },
          error: function(request,status,error) {
          },
          complete: function(jqXHR, textStatus) {
            
          }
      });
    }
    
    function evClickDelete(idx) {
    	var floor_id = idx;
    	$.ajax({
          url : "${bedviewPath}/call/json/deleteFloor.jsp",
          type : "POST",
          dataType:"json",
          data : {"floor_id":floor_id},
          success: function( result ) {
        	  var resultCode = result.resultCode;
            if(resultCode){
              alert("층 정보가 삭제되었습니다.");
            } else {
          	  alert("층 정보 삭제에 실패하였습니다.");
            }
            submitForm();
          },
          error: function(request,status,error) {
          },
          complete: function(jqXHR, textStatus) {
            
          }
      });
    }
    
    function evClickCall(floor) {
    	window.open('${bedviewPath}/call/callPop.jsp?floor_id='+floor,'callView','width='+screen.availWidth+',height='+screen.availHeight+',top=0,location=yes,resizable=yes,directories=yes,status=yes,toolbar=no,scrollbars=yes,menubar=yes');
//     	location.href='${bedviewPath}/call/callList.jsp?floor_id='+floor;
    }
    
    function validate() {
    	var floor_nm = $("#floor_nm").val();
    	if(!floor_nm) {
    		alert("층명을 입력해 주세요");
    		return false;
    	}
    	return true;
    }
    
    function setDataForm(data) {
    	$("#floor_id").val(data.floor_id);
    	$("#floor_nm").val(data.floor_nm);
    	$("#floor_code").val(data.floor_code);
    	
    	$('#cfFloorModal').modal('show');
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
      <h2 class="page-head-title">호출 관리</h2>
      <ol class="breadcrumb page-head-nav">
        <li><a href="#">병상용 관리 메뉴</a></li>
        <li class="active">호출 관리</li>
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
	                <input name="s_floor_nm" type="text" placeholder="층명을 입력하세요" class="form-control input-sm" value="${param.s_floor_nm}">
	                <span class="input-group-btn">
	                  <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                </span>
	              </div>
	            </div>
	          </div>
	
	          <div class="col-xs-4 col-sm-4">
	            <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">층 추가</button>
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
                    <th class="text-center">층명</th>
                    <th class="text-center">층 코드</th>
                    <th class="text-center">호출</th>
                    <th class="text-center">생성시각</th>
                    <th class="text-center">설정</th>
                  </tr>
                </thead>
                <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                  <tr>
                    <td class="text-center">${status.count}</td>
                    <td class="text-center">
                    	<a href="javascript:evClickRow('${data.floor_id}')">${data.floor_nm}</a>
                    </td>
                    <td class="text-center">${data.floor_code}</td>
                    <td class="text-center">
                      <button type="button" class="btn btn-success" onclick="evClickCall(${data.floor_id})">보기</button>
                    </td>
                    <td class="text-center">${data.createdAt}</td>
                    <td class="text-center">
                      <button type="button" class="btn btn-danger" onclick="evClickDelete(${data.floor_id})">삭제</button>
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
  
  <div id="cfFloorModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog">
        <form id="cfMainForm" name="mainForm" method="POST">
          <input type="hidden" id="floor_id" name="floor_id" />
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
              <h3 class="modal-title">층 정보</h3>
            </div>
            
            <div class="modal-body">
              <div class="form-group">
	              <label>층명</label>
	              <input id="floor_nm" name="floor_nm" type="text" class="form-control input-sm" maxlength="20" />
	            </div>
	            <div class="form-group">
	              <label>층 코드</label>
	              <input id="floor_code" name="floor_code" type="text" class="form-control input-sm" maxlength="20" />
	            </div>
            </div>
            
            <div class="modal-footer">
              <button type="button" data-dismiss="modal" class="btn btn-default md-close">취소</button>
              <button type="button" class="btn btn-success" onclick="evClickSave()">저장</button>
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
      });
    </script>

</body>