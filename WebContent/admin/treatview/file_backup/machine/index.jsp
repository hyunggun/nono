<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.MachineBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="treatviewPath" value="${contextPath}/admin/treatview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
MachineBiz machineBiz = null;
try {
	machineBiz = new MachineBiz();
    resultMap = machineBiz.selectMachineFilePage(paramMap);
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
    	  $("#s_file_nm").keypress(function(event) { 
      	  if( event.which == 13 ) { 
      		  callFile();
      		  return false;
      		}
        });
    	  $("#s_sign_id").keypress(function(event) { 
      	  if( event.which == 13 ) { 
      		  callMachine();
      		  return false;
      		}
        });
    	  jQuery("#cfAllCheck").click(function() {
    		  if(jQuery(this).is(":checked")) {
    			  jQuery(".cf-machine-chkbox").prop('checked', true);
    			  allCheckMachine();
    		  } else {
    			  jQuery(".cf-machine-chkbox").prop('checked', false);
    			  jQuery("#cfSelectedList").html("");
    		  }
    	  });
	    });
      
      var selectedMainKey = 0;

      function evClickAdd() {
          selectedMainKey = 0;
          $('#cfMachineFileModal').modal('show');
					
          $("#file_id").val( "" );
          $("#cfImageView").attr("src", "");
          jQuery("#cfFileList").html('<tr><td colspan="3">검색하시면 이곳에 파일 정보가 나옵니다.</td><td></td><td></td></tr>');
          jQuery("#cfMachineList").html('<tr><td colspan="3">검색하시면 이곳에 기기 정보가 나옵니다.</td> <td></td> <td></td> </tr>');

          $("#cfSelectedList").html( "" );
      }

      function evClickSave() {
          if( !validate() ) {
              return;
          }
          
          var list = [];
          jQuery(".cf-selected-machine").each(function() {
	    		  var machine_id = {};
	    		  machine_id.machine_id = jQuery(this).attr("idx");
	    		  list.push(machine_id);
	    	  });

          jQuery("#machine_ids").val(JSON.stringify(list));
          jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
          $('#cfMachineFileModal').modal('hide');
          
					var data = jQuery("#cfMainForm").serialize();
  	      
  	      $.ajax({
              url : "${treatviewPath}/file/machine/json/insertMachineFile.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : data,
              success: function( result ) {
              	if(result.resultData.resultCode) {
                	alert("저장하였습니다.");
                	location.href="${treatviewPath}/file/machine?s_sign_id="+result.resultData.s_sign_id+"&page_no="+result.resultData.page_no;
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

      function evClickDelete(file_id, machine_id) {
         $('#cfMachineFileModal').modal('hide');
         
				var data = jQuery("#cfMainForm").serialize();
 	      
 	      $.ajax({
             url : "${treatviewPath}/file/machine/json/deleteMachineFile.jsp",
             type : "POST",
             cache : false,
             dataType : "json",
             data : {file_id:file_id, machine_id:machine_id},
             success: function( result ) {
             	if(result.resultData.resultCode) {
               	alert("삭제하였습니다.");
               	location.href="${treatviewPath}/file/machine?s_sign_id="+result.resultData.s_sign_id+"&page_no="+result.resultData.page_no;
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
      
      function evClickMachine(obj) {
    	  var machnId = jQuery(obj).attr("idx");
			  var machnNm = jQuery(obj).attr("signidx");
			  if(jQuery(obj).is(":checked")) {
				  var temp = "<div class='cf-selected-machine' idx="+machnId+">"+machnNm+"<i class='mdi mdi-close-circle' style='margin-left:10px; cursor:pointer;' onclick='unCheckMachine(this)'/></div>";
		    	jQuery("#cfSelectedList").append(temp);
			  } else {
				  jQuery(".cf-selected-machine").each(function() {
					  console.log(machnId);
					  if(machnId == jQuery(this).attr("idx")) {
						  jQuery(this).remove();
					  }
				  });
			  }
      }
      
      function allCheckMachine() {
    	  var temp = "";
    	  jQuery(".cf-machine-chkbox").each(function() {
    		  temp +="<div class='cf-selected-machine' idx="+jQuery(this).attr("idx")+">"+jQuery(this).attr("signidx")+"<i class='mdi mdi-close-circle' style='margin-left:10px; cursor:pointer;' onclick='unCheckMachine(this)'/></div>";
    	  });
    	  jQuery("#cfSelectedList").html(temp);
      }
      
      function unCheckMachine(obj) {
    	  var machine = jQuery(obj).closest("div");
    	  var idx = jQuery(machine).attr("idx");
    	  jQuery(machine).remove();
    	  jQuery(".cf-machine-chkbox").each(function() {
    		  if(jQuery(this).attr("idx") == idx) {
    			  jQuery(this).prop("checked", false);
    			  return false;
    		  }
    	  });
      }
      
      function validate() {
    	  if( !$("#file_id").val() ) {
      	  alert("파일을 선택하세요.");
      	  return false;
        }
    	  if( $(".cf-selected-machine").length == 0 ) {
      	  alert("진료기기를 선택하세요.");
      	  return false;
        }
          return true;
      }
      
      function callMachine() {
          $.ajax({
              url : "${treatviewPath}/file/machein/json/machineList.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {notice_id:selectedMainKey},
              success: function( result ) {
	            	  var list = result.resultData;
	                var htmlStr = "";
	                for(var lp0=0; lp0<list.length; lp0++) {
	                	htmlStr += "<tr><td><input type='checkbox' class='cf-machine-chkbox' onclick='evClickMachine(this)' idx='"+list[lp0].machine_id+"' signidx='"+list[lp0].sign_id+"'></td>";
	                	htmlStr += "<td>"+list[lp0].sign_id+"</td>";
                    htmlStr += "<td>"+list[lp0].position+"</td></tr>";
	                }
	                jQuery("#cfMachineList").html(htmlStr);
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }
      
      function callFile() {
    	  var s_file_nm = jQuery("#s_file_nm").val();
          $.ajax({
              url : "${treatviewPath}/file/machine/json/fileList.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {s_file_nm:s_file_nm},
              success: function( result ) {
	            	  var list = result.resultData;
	                var htmlStr = "";
	                for(var lp0=0; lp0<list.length; lp0++) {
	                    htmlStr += "<tr><td>"+list[lp0].file_nm+"</td>";
	                    var uploadTime = list[lp0].upload_time;
	                    uploadTime = uploadTime.replace("T", " ");
	                    htmlStr += "<td>"+uploadTime+"</td>";
	                    htmlStr += "<td><button type='button' class='btn btn-dafault' onclick='selectFile("+list[lp0].file_id+", \""+list[lp0].file_url+"\")'>선택</button></td></tr>";
	                }
	                jQuery("#cfFileList").html(htmlStr);
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }
      
      function selectFile(idx, url) {
    	  jQuery("#file_id").val(idx);
    	  jQuery("#cfImageView").attr("src",url);
      }
      
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">진료기기 연동 관리</h2>
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
	                    <input name="s_sign_id" type="text" placeholder="아이디를 검색해 주세요" class="form-control input-sm" value="${param.s_sign_id}">
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
                        <th class="text-center">기기 아이디</th>
                        <th class="text-center">파일명</th>
                        <th class="text-center">파일URL</th>
                        <th class="text-center">생성날짜</th>
                        <th class="text-center">설정</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>${data.sign_id}</td>
                        <td>${data.file_nm}</td>
                        <td>${data.file_url}</td>
                        <td>${data.createdAt}</td>
                        <td><button type="button" class="btn btn-warning" onclick="evClickDelete(${data.file_id, data.machine_id})">삭제</button></td>
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
    <div id="cfMachineFileModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="insertForm" action="prcInsert.jsp" method="POST">
	        <input type="hidden" id="rel_id" name="rel_id">
				  <input type="hidden" id="machine_ids" name="machine_ids">
				  <input type="hidden" id="page_no" name="page_no">
				  <input type="hidden" name="s_sign_id" value="${param.s_sign_id}">
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">파일 정보</h3>
	          </div>
	
	          <div class="modal-body">
	            <div class="form-group">
	              <label>선택된 파일</label>
	              <input type="hidden" id="file_id" name="file_id">
	              <img id="cfImageView" style="max-width:50%; margin-top:30px; max-height:200px;"/>
	            </div>
	            <div class="form-group">
	                <label>파일 명</label>
		              <div class="input-group input-search input-group-sm ">
	                  <input id="s_file_nm" type="text" placeholder="파일 명을 검색하세요" class="form-control input-sm">
	                  <span class="input-group-btn">
	                    <button type="button" class="btn btn-default" onClick="callFile()"><i class="icon mdi mdi-search"></i></button>
	                  </span>
	                </div>
	            </div>
	            <div class="form-group" style="max-height:200px; width:100%; overflow-y:auto;">
	              <table class="table table-striped table-hover table-fw-widget">
									<thead>
										<tr>
											<th>파일명</th>
											<th>생성날짜</th>
											<th>설정</th>
										</tr>
									</thead>
									<tbody id="cfFileList">
										<tr>
											<td colspan="3">검색하시면 이곳에 파일 정보가 나옵니다.</td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
	            </div>
	            <div class="form-group">
	                <label>머신 아이디</label>
		              <div class="input-group input-search input-group-sm ">
	                  <input id="s_sign_id" type="text" placeholder="아이디를 검색하세요" class="form-control input-sm">
	                  <span class="input-group-btn">
	                    <button type="button" class="btn btn-default" onClick="callFile()"><i class="icon mdi mdi-search"></i></button>
	                  </span>
	                </div>
	            </div>
	            <div class="form-group" style="max-height:200px; width:100%; overflow-y:auto;">
	              <table class="table table-striped table-hover table-fw-widget">
									<thead>
										<tr>
										  <th><input id="cfAllCheck" type="checkbox"/></th>
											<th>아이디</th>
											<th>위치정보</th>
										</tr>
									</thead>
									<tbody id="cfMachineList">
										<tr>
											<td colspan="3">검색하시면 이곳에 진료기기 정보가 나옵니다.</td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
	            </div>
	            <div class="form-group">
	              <label>선택된 기기들</label>
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