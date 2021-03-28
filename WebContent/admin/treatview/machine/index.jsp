<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
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
List roomList = null;
MachineBiz machineBiz = null;
try {
	machineBiz = new MachineBiz();
  resultMap = machineBiz.selectMachinePage(paramMap);
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

      function evClickRow( machineKey ) {
          selectedMainKey = machineKey;

          $.ajax({
              url : "${treatviewPath}/machine/json/machineInfo.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : {machine_id:machineKey},
              success: function( returnVal ) {
                  setDataOnForm( returnVal.resultData.machineObj );
              },
              error: function(request,status,error) {
              },
              complete: function(jqXHR, textStatus) {
              }
          });
      }

      function evClickUpdate() {

          jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
		      $('#cfMachineModal').modal('hide');
		      var data = jQuery("#cfMainForm").serialize();
		      
		      $.ajax({
	            url : "${treatviewPath}/machine/json/updateMachine.jsp",
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
      
      function evChangeViewMode() {
          var view_mode = $("#view_mode").val();
          changeCustomImage(view_mode);
      }

      function setDataOnForm( data ) {
    	  if( !data ) {
              alert("정보를 가져오지 못했습니다.");
              $('#cfMachineModal').modal('hide');
              return;
          }
          
          $("#machine_id").val( data.machine_id );
          $("#sign_id").val( data.sign_id );
          $("#position").val( data.position );
          $("#view_mode").val( data.view_mode );
          $("#room_code").val( data.room_code );
          $("#use_fg").val( data.use_fg );
          if(data.view_mode) changeCustomImage(data.view_mode);
          if(data.custom_code) $("input:radio[name=custom_code]:input[value="+data.custom_code+"]").prop("checked", true);
          $('#cfMachineModal').modal('show');
          
          $("#customMode").show();
      }
      
      function submitForm() {
    	    jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
          $("#cfMainForm").submit();
          $('#cfMachineModal').modal('hide');
      }
      
      function changeCustomImage(type) {
    	  var imgName = "vertical";
    	  if(type == 2) {
    		  imgName = "horizontal";
    	  } else if(type == 3) {
    		  imgName = "multi";
    	  } else if(type == 4) {
    		  imgName = "vertical2";
    	  } else if(type == 5) {
    		  imgName = "vertical3";
    	  } else if(type == 6) {
    		  imgName = "multi2";
    	  } else if(type == 7) {
    		  $(".custom-box").hide();
    		  $("#customBlue").prop("checked", true);
    		  $("#customBlue").parent().show().find("img").attr("src","${contextPath}/common/img/treatview/custom/custom_pre_multi_blue.png");
    	  } else if(type == 8) {
    		  $(".custom-box").hide();
    		  $("#customBlue").prop("checked", true);
    		  $("#customBlue").parent().show().find("img").attr("src","${contextPath}/common/img/treatview/custom/custom_vertical4_skyblue.png");
    	  } else if(type == 9) {
    		  $(".custom-box").hide();
    		  $("#customBlue").prop("checked", true);
    		  $("#customBlue").parent().show().find("img").attr("src","${contextPath}/common/img/treatview/custom/custom_vertical5_skyblue.png");
    	  } else if(type == 10) {
    		  $(".custom-box").hide();
    		  $("#customBlue").prop("checked", true);
    		  $("#customBlue").parent().show().find("img").attr("src","${contextPath}/common/img/treatview/custom/custom_multi3_skyblue.png");
    	  }
    	  
    	  if(type < 7) {
    		  $(".custom-box").show();
    		  $("#customBlue").parent().find("img").attr("src","${contextPath}/common/img/treatview/custom/custom_"+imgName+"_blue.png");
					$("#customGreen").parent().find("img").attr("src","${contextPath}/common/img/treatview/custom/custom_"+imgName+"_green.png");
					$("#customPink").parent().find("img").attr("src","${contextPath}/common/img/treatview/custom/custom_"+imgName+"_pink.png");
					$("#customPurple").parent().find("img").attr("src","${contextPath}/common/img/treatview/custom/custom_"+imgName+"_purple.png");
					$("#customSkyblue").parent().find("img").attr("src","${contextPath}/common/img/treatview/custom/custom_"+imgName+"_skyblue.png");
    	  }
    	  
      }
      
      function evClickSetting(idx) {
    	  location.href = "${treatviewPath}/machine/room?machine_id="+idx;
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
              <form id="cfSearchForm" name="search_form" method="POST">
              	<input type="hidden" name="page_no">
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
                        <th class="text-center">Room Code</th>
                        <th class="text-center">위치정보</th>
                        <th class="text-center">생성날짜</th>
                        <th class="text-center">진료실 설정</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>
                        	<a href="javascript:evClickRow('${data.machine_id}')">${data.sign_id}</a>
                        </td>
				        <td>${data.room_code}</td>
                        <td>${data.position}</td>
                        <td>${data.createdAt}</td>
                        <td><button type="button" class="btn btn-primary" onclick="evClickSetting(${data.machine_id})">연동</button></td>
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
    <div id="cfMachineModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMainForm" name="mainForm" method="POST">
					<input type="hidden" id="machine_id" name="machine_id">
					<input type="hidden" id="page_no" name="page_no">
					<input type="hidden" id="s_sign_id" name="s_sign_id" value="${param.s_sign_id}">
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">머신 정보</h3>
	          </div>
	
	          <div class="modal-body">
	            <div class="form-group">
	              <label>아이디</label>
	              <input id="sign_id" name="sign_id" type="text" placeholder="아이디를 입력하세요" class="form-control input-sm" maxlength="30" disabled="disabled"/>
	            </div>
	            <div class="form-group">
	              <label>위치 정보</label>
	              <input id="position" name="position" type="text" placeholder="ex)1층 진료 대기실" class="form-control input-sm" maxlength="120" />
	            </div>
	            <div class="form-group">
	              <label>타입 선택</label>
	              <select id="view_mode" name="view_mode" class="form-control input-sm" onchange="evChangeViewMode()">
            			<option value=1>세로 개인</option>
            			<option value=2>가로 개인</option>
            			<option value=3>가로 멀티(동영상&사진 뷰)</option>
            			<option value=4>세로 개인(대기&예약)</option>
            			<option value=5>세로 개인(대기&검사)</option>
            			<option value=6>가로 멀티(3인)</option>
            			<option value=7>가로 멀티(6인)</option>
            			<option value=8>세로 개인(대기/지원)</option>
            			<option value=9>세로 개인(검사)</option>
	              </select>
	            </div>
	            <div class="form-group">
	              <label>emr의사코드</label>
	              <input id="room_code" name="room_code" type="text" class="form-control input-sm" maxlength="30" />
	            </div>
	            <div id="customMode" class="form-group">
	              <label>커스텀 선택</label>
	              <div class="col-md-12" style="margin-bottom:20px;">
	              	<div class="col-md-4 custom-box">
		              	<input type="radio" id="customBlue" name="custom_code" value="1" checked/>
		              	<label for="customBlue"><img src="${contextPath}/common/img/treatview/custom/custom_horizontal_blue.png" style="max-width:120px; max-height:150px;"/></label>
		              </div>
		              <div class="col-md-4 custom-box">
		              	<input type="radio" id="customGreen" name="custom_code" value="2" />
		              	<label for="customGreen"><img src="${contextPath}/common/img/treatview/custom/custom_horizontal_green.png" style="max-width:120px; max-height:150px;"/></label>
		              </div>
		              <div class="col-md-4 custom-box">
		              	<input type="radio" id="customPink" name="custom_code" value="3" />
		              	<label for="customPink"><img src="${contextPath}/common/img/treatview/custom/custom_horizontal_pink.png" style="max-width:120px; max-height:150px;"/></label>
		              </div>
		              <div class="col-md-4 custom-box">
		              	<input type="radio" id="customPurple" name="custom_code" value="4" />
		              	<label for="customPurple"><img src="${contextPath}/common/img/treatview/custom/custom_horizontal_purple.png" style="max-width:120px; max-height:150px;"/></label>
		              </div>
		              <div class="col-md-4 custom-box">
		              	<input type="radio" id="customSkyblue" name="custom_code" value="5" />
		              	<label for="customSkyblue"><img src="${contextPath}/common/img/treatview/custom/custom_horizontal_skyblue.png" style="max-width:120px; max-height:150px;"/></label>
		              </div>
	              </div>
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