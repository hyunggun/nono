<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.RoomBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="treatviewPath" value="${contextPath}/admin/treatview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
RoomBiz roomBiz = null;
try {
		roomBiz = new RoomBiz();
    resultMap = roomBiz.selectRoomDoctorPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
    <script type="text/javascript">
      $(document).ready(function() {
    	  selectDoctorList();
	    });

      function evClickAdd() {
          $("#cfDeleteButton").hide();
          
          $("#emr_doctor_key").val( "" );
          $(".daycheck").each(function() {
        	  $(this).prop("checked",false);
          });
          
          $("#morning").prop("checked", true);

          $('#cfRoomModal').modal('show');
      }

      function evClickSave() {
          if( !validate() ) {
              return;
          }
  	      $('#cfRoomModal').modal('hide');
  	      
  	      var days = [];
  	      $(".daycheck").each(function() {
  	    	  if($(this).is(":checked")) {
  	    			days.push($(this).val());  
  	    	  }
  	      });
  	      $("#days").val(JSON.stringify(days));
  	      
  	      $.ajax({
              url : "${treatviewPath}/room_doctor/json/insertRoomDoctor.jsp",
              type : "POST",
              cache : false,
              dataType : "json",
              data : jQuery("#cfMainForm").serialize(),
              success: function( result ) {
              	if(result.resultCode) {
                	alert("저장하였습니다.");
                } else {
                	alert("저장에 실패하였습니다.");
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
 	      $.ajax({
             url : "${treatviewPath}/room_doctor/json/deleteRoomDoctor.jsp",
             type : "POST",
             cache : false,
             dataType : "json",
             data : {"rel_id":idx},
             success: function( result ) {
             	if(result.resultCode) {
               	alert("삭제하였습니다.");
               } else {
               	alert("삭제에 실패하였습니다.");
               }
             	submitForm();
             },
             error: function(request,status,error) {
             },
             complete: function(jqXHR, textStatus) {
             }
         });
      }
      
      function selectDoctorList() {
          $.ajax({
             url : "${treatviewPath}/room_doctor/json/doctorList.jsp",
             type : "POST",
             cache : false,
             dataType : "json",
             data:{},
             success: function( result ) {
            	  var list = result.resultData.doctorList;
                var htmlStr = "";
                for(var lp0=0; lp0<list.length; lp0++) {
                    htmlStr += "<option value="+list[lp0].emr_doctor_key+">원장명: "+list[lp0].user_nm+" / EMR코드: "+list[lp0].emr_doctor_key+"</option>";
                }
                if(list.length == 0) {
                	htmlStr = "<option value=0>없음</option>";
                }
                jQuery("#emr_doctor_key").html(htmlStr);
             },
             error: function(request,status,error) {
             },
             complete: function(jqXHR, textStatus) {
             }
         });
      }
      
      function validate() {
          if( !$("#emr_doctor_key").val() ) {
        	  alert("의사코드를 다시 선택해 주세요.");
        	  return false;
          }
          if( $(".daycheck:checked").length == 0 ) {
        	  alert("요일을 선택해 주세요");
        	  return false;
          }
          return true;
      }
      
      function submitForm() {
    	  jQuery("input[name=page_no]").val(jQuery("#mainDataTable").DataTable().page.info().page);
 	      $("#searchForm").submit();
      }
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">진료의사 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">현황판 관리 메뉴</a></li>
            <li class="active">진료의사 관리</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="searchForm" name="searchForm" method="POST" action="index.jsp">
              	<input type="hidden" name="room_id" value="${param.room_id}">
              	<input type="hidden" name="page_no">
	              <div class="col-sm-4 col-xs-8">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm">
	                    <input name="s_room_nm" type="text" placeholder="진료실 명을 입력하세요" class="form-control input-sm" value="${param.s_room_nm}">
	                    <span class="input-group-btn">
	                      <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                    </span>
	                  </div>
	                </div>
	              </div>
	              <div class="col-xs-4 col-sm-4">
	                <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">일정 추가</button>
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
                        <th class="text-center">emr의사코드</th>
                        <th class="text-center">요일</th>
                        <th class="text-center">시간</th>
                        <th class="text-center">상태</th>
                        <th class="text-center">생성날짜</th>
                        <th class="text-center">설정</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>
                        	<a href="javascript:evClickRow('${data.rel_id}')">${data.emr_doctor_key}</a>
                        </td>
                        <c:choose>
                        	<c:when test="${data.day eq 'M'}">
                        		<td>월요일</td>
                        	</c:when>
                        	<c:when test="${data.day eq 'T'}">
                        		<td>화요일</td>
                        	</c:when>
                        	<c:when test="${data.day eq 'W'}">
                        		<td>수요일</td>
                        	</c:when>
                        	<c:when test="${data.day eq 'TH'}">
                        		<td>목요일</td>
                        	</c:when>
                        	<c:when test="${data.day eq 'F'}">
                        		<td>금요일</td>
                        	</c:when>
                        	<c:when test="${data.day eq 'S'}">
                        		<td>토요일</td>
                        	</c:when>
                        	<c:otherwise>
                        		<td>일요일</td>
                        	</c:otherwise>
                        </c:choose>
                        <c:choose>
                        	<c:when test="${data.time eq 'A'}">
                        		<td>오전</td>
                        	</c:when>
                        	<c:otherwise>
                        		<td>오후</td>
                        	</c:otherwise>
                        </c:choose>
                        <c:choose>
                        	<c:when test="${data.code eq 'O'}">
                        		<td>진료대기</td>
                        	</c:when>
                          <c:when test="${data.code eq 'R'}">
                            <td>진료중</td>
                          </c:when>
                          <c:when test="${data.code eq 'C'}">
                            <td>진료마감</td>
                          </c:when>
                          <c:when test="${data.code eq 'S'}">
                            <td>수술중</td>
                          </c:when>
                          <c:when test="${data.code eq 'E'}">
                            <td>내시경</td>
                          </c:when>
                          <c:when test="${data.code eq 'H'}">
                            <td>회진</td>
                          </c:when>
                        	<c:otherwise>
                        		<td>휴진</td>
                        	</c:otherwise>
                        </c:choose>
                        <td>${data.createdAt}</td>
                        <td><button type="button" class="btn btn-warning" onclick="evClickDelete(${data.rel_id})">삭제</button></td>
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
					<input type="hidden" id="room_id" name="room_id" value="${param.room_id}">
					<input type="hidden" id="days" name="days">
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">진료실 정보</h3>
	          </div>
	          
	          <div class="modal-body">
	            <div class="form-group">
	              <label>emr의사코드</label>
<!-- 	              <input type="text" id="emr_doctor_key" name="emr_doctor_key" class="form-control input-sm"> -->
	              <select id="emr_doctor_key" name="emr_doctor_key" class="form-control input-sm">
	              </select>
	            </div>
	            <div class="form-group">
	            	<label>요일선택</label>
	            	<div>
	            		<input type="checkbox" id="monday" class="daycheck" value="M"/>
	            		<label for="monday">월요일</label>
	            		<input type="checkbox" id="tuesday" class="daycheck" value="T" style="margin-left:20px;"/>
	            		<label for="tuesday">화요일</label>
	            		<input type="checkbox" id="wednesday" class="daycheck" value="W" style="margin-left:20px;"/>
	            		<label for="wednesday">수요일</label>
	            		<input type="checkbox" id="thursday" class="daycheck" value="TH" style="margin-left:20px;"/>
	            		<label for="thursday">목요일</label>
	            		<input type="checkbox" id="friday" class="daycheck" value="F" style="margin-left:20px;"/>
	            		<label for="friday">금요일</label>
	            		<input type="checkbox" id="saturday" class="daycheck" value="S" style="margin-left:20px;"/>
	            		<label for="saturday">토요일</label>
	            		<input type="checkbox" id="sunday" class="daycheck" value="su" style="margin-left:20px;"/>
	            		<label for="sunday">일요일</label>
	            	</div>
	            </div>
	            <div class="form-group">
	              <label>시간선택</label>
	              <div>
	              	<input type="radio" id="morning" name="time" value="A" checked>
		              <label for="morning">오전</label>
		              <input type="radio" id="afternoon" name="time" value="P">
		              <label for="afternoon">오후</label>
	              </div>
	            </div>
              <div class="form-group">
                <label>상태</label>
                <div>
                  <input type="radio" id="code_R" name="code" value="R" checked>
                  <label for="R">진료중</label>
<!--                   <input type="radio" id="code_C" name="code" value="C" > -->
<!--                   <label for="C">진료마감</label> -->
<!--                   <input type="radio" id="code_O" name="code" value="O" > -->
<!--                   <label for="O">진료마감</label> -->
                  <input type="radio" id="code_S" name="code" value="S" >
                  <label for="S">수술중</label>
                  <input type="radio" id="code_E" name="code" value="E">
                  <label for="E">내시경</label>
                  <input type="radio" id="code_H" name="code" value="H">
                  <label for="H">회진</label>
                </div>
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
        var pageNo = "${paramMap.page_no}";
        if(pageNo != "") {
        	jQuery("#mainDataTable").dataTable().fnPageChange(${paramMap.page_no});
        }
      });
    </script>

</body>