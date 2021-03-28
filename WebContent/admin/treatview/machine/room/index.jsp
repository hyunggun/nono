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
    resultMap = machineBiz.selectMachineRoomPage(paramMap);
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
     .cf-selected-room, .cf-related-machine {
			float:left; margin:10px 10px 10px 0; padding:5px 10px; background:#eee;
		}
    </style>
    <script type="text/javascript">
      $(document).ready(function() {
    	  $("#s_room_nm").keypress(function(event) { 
      	  if( event.which == 13 ) { 
      		  callRoom();
      		  return false;
      		}
        });
    	  jQuery("#cfAllCheck").click(function() {
    		  if(jQuery(this).is(":checked")) {
    			  jQuery(".cf-room-chkbox").prop('checked', true);
    			  allCheckMachine();
    		  } else {
    			  jQuery(".cf-room-chkbox").prop('checked', false);
    			  jQuery("#cfSelectedList").html("");
    		  }
    	  });
	    });
      
      var selectedMainKey = 0;

      function evClickAdd() {
          selectedMainKey = 0;
          $('#cfMachineRoomModal').modal('show');
          jQuery("#cfRoomList").html('<tr><td colspan="3">검색하시면 이곳에 진료실 정보가 나옵니다.</td> <td></td> <td></td> </tr>');

          $("#cfSelectedList").html( "" );
      }

      function evClickSave() {
          if( !validate() ) {
              return;
          }
          
          var list = [];
          jQuery(".cf-selected-room").each(function() {
	    		  var room_id = {};
	    		  room_id.room_id = jQuery(this).attr("idx");
	    		  list.push(room_id);
	    	  });

          jQuery("#room_ids").val(JSON.stringify(list));
          jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
          $('#cfMachineRoomModal').modal('hide');
          
					var data = jQuery("#cfMainForm").serialize();
  	      
  	      $.ajax({
              url : "${treatviewPath}/machine/room/json/insertMachineRoom.jsp",
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

      function evClickDelete(room_id) {
         $('#cfMachineRoomModal').modal('hide');
         jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
				var data = jQuery("#cfMainForm").serialize();
 	      
 	      $.ajax({
             url : "${treatviewPath}/machine/room/json/deleteMachineRoom.jsp",
             type : "POST",
             cache : false,
             dataType : "json",
             data : {machine_id:'${param.machine_id}', room_id:room_id},
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
      
      function evClickRoom(obj) {
    	  var roomId = jQuery(obj).attr("idx");
			  var roomNm = jQuery(obj).attr("roomNm");
			  if(jQuery(obj).is(":checked")) {
				  var temp = "<div class='cf-selected-room' idx="+roomId+">"+roomNm+"<i class='mdi mdi-close-circle' style='margin-left:10px; cursor:pointer;' onclick='unCheckRoom(this)'/></div>";
		    	jQuery("#cfSelectedList").append(temp);
			  } else {
				  jQuery(".cf-selected-room").each(function() {
					  if(roomId == jQuery(this).attr("idx")) {
						  jQuery(this).remove();
					  }
				  });
			  }
      }
      
      function allCheckRoom() {
    	  var temp = "";
    	  jQuery(".cf-room-chkbox").each(function() {
    		  temp +="<div class='cf-selected-room' idx="+jQuery(this).attr("idx")+">"+jQuery(this).attr("roomNm")+"<i class='mdi mdi-close-circle' style='margin-left:10px; cursor:pointer;' onclick='unCheckRoom(this)'/></div>";
    	  });
    	  jQuery("#cfSelectedList").html(temp);
      }
      
      function unCheckMachine(obj) {
    	  var room = jQuery(obj).closest("div");
    	  var idx = jQuery(machine).attr("idx");
    	  jQuery(room).remove();
    	  jQuery(".cf-room-chkbox").each(function() {
    		  if(jQuery(this).attr("idx") == idx) {
    			  jQuery(this).prop("checked", false);
    			  return false;
    		  }
    	  });
      }
      
      function validate() {
    	  if( $(".cf-selected-room").length == 0 ) {
      	  alert("진료기기를 선택하세요.");
      	  return false;
        }
        return true;
      }
      
      function callRoom() {
          $.ajax({
              url : "${treatviewPath}/machine/room/json/roomList.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : {},
              success: function( result ) {
	            	  var list = result.resultData.roomList;
	                var htmlStr = "";
	                for(var lp0=0; lp0<list.length; lp0++) {
	                	htmlStr += "<tr><td><input type='checkbox' class='cf-room-chkbox' onclick='evClickRoom(this)' idx='"+list[lp0].room_id+"' roomNm='"+list[lp0].room_nm+"'></td>";
	                	htmlStr += "<td>"+list[lp0].room_nm+"</td>";
                    htmlStr += "<td>"+list[lp0].room_code+"</td></tr>";
	                }
	                jQuery("#cfRoomList").html(htmlStr);
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
          <h2 class="page-head-title">현황판 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">현황판 관리 메뉴</a></li>
            <li class="active">현황판</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="cfSearchForm" name="searchForm" action="${treatviewPath}/machine/room/" method="POST">
                <input type="hidden" name="page_no">
                <input type="hidden" name="machine_id" value="${paramMap.machine_id}">
	              <div class="col-sm-4 col-xs-8">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm">
	                    <input name="s_room_nm" type="text" placeholder="현황판 아이디를 검색해 주세요" class="form-control input-sm" value="${param.s_room_nm}">
	                    <span class="input-group-btn">
	                      <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                    </span>
	                  </div>
	                </div>
	              </div>

	              <div class="col-xs-4 col-sm-4">
	                <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">진료실 연동</button>
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
                        <th class="text-center">진료실명</th>
                        <th class="text-center">의사코드</th>
                        <th class="text-center">현황판 아이디</th>
                        <th class="text-center">생성날짜</th>
                        <th class="text-center">설정</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>${data.room_nm}</td>
                        <td>${data.room_code}</td>
                        <td>${data.sign_id}</td>
                        <td>${data.createdAt}</td>
                        <td><button type="button" class="btn btn-warning" onclick="evClickDelete(${data.room_id})">삭제</button></td>
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
    <div id="cfMachineRoomModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="insertForm" action="prcInsert.jsp" method="POST">
	        <input type="hidden" name="machine_id" value="${param.machine_id}">
				  <input type="hidden" id="room_ids" name="room_ids">
				  <input type="hidden" id="page_no" name="page_no">
				  <input type="hidden" name="s_room_nm" value="${param.s_room_nm}">
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">진료실 연동 정보</h3>
	          </div>
	
	          <div class="modal-body">
	            <div class="form-group">
	                <label>진료실 명</label>
		              <div class="input-group input-search input-group-sm ">
	                  <input id="s_room_nm" type="text" placeholder="진료실 명을 검색하세요" class="form-control input-sm">
	                  <span class="input-group-btn">
	                    <button type="button" class="btn btn-default" onClick="callRoom()"><i class="icon mdi mdi-search"></i></button>
	                  </span>
	                </div>
	            </div>
	            <div class="form-group" style="max-height:200px; width:100%; overflow-y:auto;">
	              <table class="table table-striped table-hover table-fw-widget">
									<thead>
										<tr>
										  <th><input id="cfAllCheck" type="checkbox"/></th>
											<th>진료실명</th>
											<th>의사코드</th>
										</tr>
									</thead>
									<tbody id="cfRoomList">
										<tr>
											<td colspan="3">검색하시면 이곳에 진료실 정보가 나옵니다.</td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
	            </div>
	            <div class="form-group">
	              <label>선택된 진료실</label>
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