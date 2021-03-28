<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.InpatientBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="inpatviewPath" value="${contextPath}/admin/inpatview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
InpatientBiz inpatBiz = null;
try {
	inpatBiz = new InpatientBiz();
    resultMap = inpatBiz.selectInpatientFilePage(paramMap);
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
     .cf-selected-inpat, .cf-related-inpat {
			float:left; margin:10px 10px 10px 0; padding:5px 10px; background:#eee;
		}
    </style>
    <script type="text/javascript">
      $(document).ready(function() {
    	  $("#s_inprm_nm").keypress(function(event) { 
      	  if( event.which == 13 ) { 
      		  callInpatient();
      		  return false;
      		}
        });
    	  jQuery("#cfAllCheck").click(function() {
    		  if(jQuery(this).is(":checked")) {
    			  jQuery(".cf-inpat-chkbox").prop('checked', true);
    			  allCheckInpatient();
    		  } else {
    			  jQuery(".cf-inpat-chkbox").prop('checked', false);
    			  jQuery("#cfSelectedList").html("");
    		  }
    	  });
	    });
      
      var selectedMainKey = 0;

      function evClickAdd() {
          selectedMainKey = 0;
          $('#cfInpatientFileModal').modal('show');
          jQuery("#cfInpatientList").html('<tr><td colspan="4">검색하시면 이곳에 입원실 정보가 나옵니다.</td> <td></td> <td></td> </tr>');

          $("#cfSelectedList").html( "" );
      }

      function evClickSave() {
          if( !validate() ) {
              return;
          }
          
          var list = [];
          jQuery(".cf-selected-inpat").each(function() {
	    		  var inprm_id = {};
	    		  inprm_id.inprm_id = jQuery(this).attr("idx");
	    		  list.push(inprm_id);
	    	  });

          jQuery("#inprm_ids").val(JSON.stringify(list));
          jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
          $('#cfInpatientFileModal').modal('hide');
          
					var data = jQuery("#cfMainForm").serialize();
  	      
  	      $.ajax({
              url : "${inpatviewPath}/file/room/json/insertInpatRoomFile.jsp",
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

      function evClickDelete(inprm_id,use_type) {
         $('#cfInpatientFileModal').modal('hide');
         jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
				//var data = jQuery("#cfMainForm").serialize();
 	      
 	      $.ajax({
             url : "${inpatviewPath}/file/room/json/deleteInpatRoomFile.jsp",
             type : "POST",
             cache : false,
             dataType : "json",
             data : {file_id:'${param.file_id}', inprm_id:inprm_id, use_type:use_type},
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
      
      function evClickInpatient(obj) {
    	  var inprmId = jQuery(obj).attr("idx");
			  var inprmNm = jQuery(obj).attr("roomNm");
			  if(jQuery(obj).is(":checked")) {
				  var temp = "<div class='cf-selected-inpat' idx="+inprmId+">"+inprmNm+"<i class='mdi mdi-close-circle' style='margin-left:10px; cursor:pointer;' onclick='unCheckInpatient(this)'/></div>";
		    	jQuery("#cfSelectedList").append(temp);
			  } else {
				  jQuery(".cf-selected-inpat").each(function() {
					  if(inprmId == jQuery(this).attr("idx")) {
						  jQuery(this).remove();
					  }
				  });
			  }
      }
      
      function allCheckInpatient() {
    	  var temp = "";
    	  jQuery(".cf-inpat-chkbox").each(function() {
    		  temp +="<div class='cf-selected-inpat' idx="+jQuery(this).attr("idx")+">"+jQuery(this).attr("roomNm")+"<i class='mdi mdi-close-circle' style='margin-left:10px; cursor:pointer;' onclick='unCheckInpatient(this)'/></div>";
    	  });
    	  jQuery("#cfSelectedList").html(temp);
      }
      
      function unCheckInpatient(obj) {
    	  var inpat = jQuery(obj).closest("div");
    	  var idx = jQuery(inpat).attr("idx");
    	  jQuery(inpat).remove();
    	  jQuery(".cf-inpat-chkbox").each(function() {
    		  if(jQuery(this).attr("idx") == idx) {
    			  jQuery(this).prop("checked", false);
    			  return false;
    		  }
    	  });
      }
      
      function validate() {
    	  if( $(".cf-selected-inpat").length == 0 ) {
      	  alert("진료기기를 선택하세요.");
      	  return false;
        }
        return true;
      }
      
      function callInpatient() {
          $.ajax({
              url : "${inpatviewPath}/file/room/json/inpatientList.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {},
              success: function( result ) {
	            	  var list = result.resultData;
	                var htmlStr = "";
	                for(var lp0=0; lp0<list.length; lp0++) {
	                	htmlStr += "<tr><td><input type='checkbox' class='cf-inpat-chkbox' onclick='evClickInpatient(this)' idx='"+list[lp0].inprm_id+"' roomNm='"+list[lp0].inprm_nm+"'></td>";
	                	htmlStr += "<td>"+list[lp0].inprm_nm+"</td>";
                    htmlStr += "<td>"+list[lp0].emr_room_key+"</td>";
                    htmlStr += "<td>"+list[lp0].max_cnt+"</td></tr>";
	                }
	                jQuery("#cfInpatientList").html(htmlStr);
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }
      
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">입원실 파일</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">입원실 관리 메뉴</a></li>
            <li class="active">입원실</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="cfSearchForm" name="searchForm" action="${inpatviewPath}/file/room/" method="POST">
                <input type="hidden" name="page_no">
                <input type="hidden" name="file_id" value="${paramMap.file_id}">
	              <div class="col-sm-4 col-xs-8">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm">
	                    <input name="s_inprm_nm" type="text" placeholder="입원실명을 검색해 주세요" class="form-control input-sm" value="${param.s_inprm_nm}">
	                    <span class="input-group-btn">
	                      <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                    </span>
	                  </div>
	                </div>
	              </div>

	              <div class="col-xs-4 col-sm-4">
	                <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">파일 연동</button>
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
                        <th class="text-center">입원실코드</th>
                        <th class="text-center">이미지</th>
                        <th class="text-center">이미지 위치</th>
                        <th class="text-center">생성날짜</th>
                        <th class="text-center">설정</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>${data.inprm_nm}</td>
                        <td>${data.emr_room_key}</td>
                        <td><img src="${data.file_url}" style="width:200px;"></td>
                        <c:choose>
                        	<c:when test="${data.use_type eq 'T' }">
                        		<td>상단</td>
                        	</c:when>
                        	<c:when test="${data.use_type eq 'B' }">
                        		<td>하단</td>
                        	</c:when>
                        	<c:when test="${data.use_type eq 'N' }">
                        		<td>간호사</td>
                        	</c:when>
                        </c:choose>
                        <td>${data.createdAt}</td>
                        <td><button type="button" class="btn btn-warning" onclick="evClickDelete(${data.inprm_id}, '${data.use_type}')">삭제</button></td>
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
    <div id="cfInpatientFileModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="insertForm" action="prcInsert.jsp" method="POST">
	        <input type="hidden" name="file_id" value="${param.file_id}">
				  <input type="hidden" id="inprm_ids" name="inprm_ids">
				  <input type="hidden" id="page_no" name="page_no">
				  <input type="hidden" name="s_inprm_nm" value="${param.s_inprm_nm}">
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">입원실 이미지 연동</h3>
	          </div>
	
	          <div class="modal-body">
	          	<div class="form-group">
	              <label>이미지 위치</label>
				 				<select name="use_type" class="form-control">
                  <option value="T">상단</option>
                  <option value="B">하단</option>
                  <option value="N">간호사</option>
                </select>
	            </div>
	            <div class="form-group">
	                <label>입원실명</label>
		              <div class="input-group input-search input-group-sm ">
	                  <input id="s_inprm_nm" type="text" placeholder="입원실을 검색하세요" class="form-control input-sm">
	                  <span class="input-group-btn">
	                    <button type="button" class="btn btn-default" onClick="callInpatient()"><i class="icon mdi mdi-search"></i></button>
	                  </span>
	                </div>
	            </div>
	            <div class="form-group" style="max-height:300px; width:100%; overflow-y:auto;">
	              <table class="table table-striped table-hover table-fw-widget">
									<thead>
										<tr>
										  <th><input id="cfAllCheck" type="checkbox"/></th>
											<th>입원실명</th>
											<th>입원실코드</th>
											<th>최대인원</th>
										</tr>
									</thead>
									<tbody id="cfInpatientList">
										<tr>
											<td colspan="4">검색하시면 이곳에 입원실 정보가 나옵니다.</td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
	            </div>
	            <div class="form-group">
	              <label>선택된 입원실들</label>
				 				<div id="cfSelectedList" style="display:inline-block; width:100%;">
				 				
				 				</div>
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