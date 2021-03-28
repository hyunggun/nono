<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.FileBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="treatviewPath" value="${contextPath}/admin/treatview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
FileBiz fileBiz = null;
try {
    fileBiz = new FileBiz();
    resultMap = fileBiz.selectFilePage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<!DOCTYPE HTML>
<html>     
<head>
    <style>
     .cf-selected-machine, .cf-related-machine {
			float:left; margin:10px 10px 10px 0; padding:5px 10px; background:#eee;
		}
    </style>
    <script type="text/javascript">
      $(document).ready(function() {

	    });
      
      var selectedMainKey = 0;

      function evClickAdd() {
          selectedMainKey = 0;
          $('#cfFileModal').modal('show');
          $("#file_id").val( "" );
          $("#cfUploadFile").val( "" );
          $("#cfImageView").attr("src", "");
      }

      function evClickSave() {
          if( !validate() ) {
              return;
          }
          
          jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
          $('#cfFileModal').modal('hide');
  	      
  	      var data = jQuery("#cfMainForm").serialize();
  	      
  	      $.ajax({
              url : "${treatweb}/file/json/insertFile.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : data,
              success: function( result ) {
              	if(result.resultData.resultCode) {
                	alert("저장하였습니다.");
                	location.href="${treatviewPath}/file?s_file_nm="+result.resultData.s_file_nm+"&page_no="+result.resultData.page_no;
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
      
      function evClickDelete(idx) {
          jQuery("#file_id").val(idx);
          
          jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
  	      $('#cfFileModal').modal('hide');
  	      
  	      var data = jQuery("#cfMainForm").serialize();
  	      
  	      $.ajax({
              url : "${treatviewPath}/file/json/deleteFile.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : data,
              success: function( result ) {
              	if(result.resultData.resultCode) {
                	alert("삭제하였습니다.");
                	location.href="${treatviewPath}/file?s_file_nm="+result.resultData.s_file_nm+"&page_no="+result.resultData.page_no;
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
      
      function validate() {
    	  if( !$("#cfUploadFile").val() ) {
        	  alert("파일을 선택하세요.");
        	  return false;
          }
          return true;
      }
      
      function readURL(input) {
    	  if(input.files.length == 1) {
    		  var reader = new FileReader();
    		  reader.addEventListener("load", function() {
    			  jQuery("#cfImageView").attr("src", reader.result);
    		  }, false);
    		  
    		  reader.readAsDataURL(input.files[0]);
    		  
    		  reader.onerror = function(err) {
    			  var errcode = err.targer.error.code;
    			  if(errcode == 1) {
    				  alert("File Not Found");
    			  } else if(errcode == 2) {
    				  alert("File Not Safe Or File Changed");
    			  } else if(errcode == 3) {
    				  alert("Stop Reading File");
    			  } else if(errcode == 4) {
    				  alert("Cannot Reading for Access Authority");
    			  } else {
    				  alert("URL Size Limit Problem");
    			  }
     		  };
    	  }
      }
      
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">파일 정보 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">진료용 관리 메뉴</a></li>
            <li class="active">파일 관리</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="cfSearchForm" name="searchForm" method="POST">
	              <div class="col-sm-4 col-xs-8">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm">
	                    <input name="s_file_nm" type="text" placeholder="파일명을 검색하세요" class="form-control input-sm" value="${param.s_file_nm}">
	                    <span class="input-group-btn">
	                      <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                    </span>
	                  </div>
	                </div>
	              </div>

	              <div class="col-xs-4 col-sm-4">
	                <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">파일 추가</button>
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
                        <th class="text-center">파일 이미지</th>
                        <th class="text-center">파일명</th>
                        <th class="text-center">파일크기</th>
                        <th class="text-center">파일URL</th>
                        <th class="text-center">생성날짜</th>
                        <th class="text-center">설정</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td><img src="${data.file_url}" style="max-height:100px;"></td>
                        <td>${data.file_nm}</td>
                        <td>${data.file_size}byte</td>
                        <td>${data.file_url}</td>
                        <td>${data.createdAt}</td>
                        <td><button type="button" class="btn btn-warning" onclick="evClickDelete(${data.file_id})">삭제</button></td>
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
    <div id="cfFileModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="insertForm" action="prcInsert.jsp" method="POST" enctype="multipart/form-data">
				  <input type="hidden" id="file_id" name="file_id"/>
				  <input type="hidden" id="page_no" name="page_no">
				  <input type="hidden" id="s_file_nm" name="s_file_nm" value="${param.s_file_nm}">
				  
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">파일 정보</h3>
	          </div>
	
	          <div class="modal-body">
	            <div class="form-group">
	              <label>파일 찾기</label>
				        <input type="file" id="cfUploadFile" name="uploadFile" class="form-control input-sm" onchange="readURL(this)" style="max-height:200px;"/>
	              <img id="cfImageView" style="max-width:50%; margin-top:30px;"/>
	            </div>
	          </div>
	          
	          <div class="modal-footer">
	            <button type="button" data-dismiss="modal" class="btn btn-default md-close">취소</button>
	            <button id="cfSaveButton" type="button" class="btn btn-success" onclick="evClickSave()">저장</button>
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
</html>