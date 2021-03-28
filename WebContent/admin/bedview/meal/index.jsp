<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.MealBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="bedviewPath" value="${contextPath}/admin/bedview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
List viewmodeList = null;
MealBiz mealBiz = null;
try {
	mealBiz = new MealBiz();
  
  resultMap = mealBiz.selectMealPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
    <style>
      .cf-menu-box {resize:none;}
    </style>
    <script type="text/javascript">
      $(document).ready(function() {
	    });
      
      var selectedMainKey = 0;
      
      function evClickAdd() {
        selectedMainKey = 0;
        $('#cfMealModal').modal('show');
        jQuery("#cfMenuList").html("");
        evClickMenuAdd();
      }
      
      function evClickMenuAdd() {
    	  if(jQuery(".cf-menu").length > 7) {
    		  alert("식단이 너무 많습니다. 저장 후 다시 추가해 주세요");
    		  return false;
    	  }
    	  var temp = '<tr class="cf-menu"><td><input type="date" class="form-control cf-menu-date" name="date" onchange="setDate('+jQuery(".cf-menu-date").length+')"></td>';
    	  temp +='<td><textarea rows="5" class="form-control cf-menu-box cf-menu-breakfast" name="breakfast"></textarea></td>';
    		temp +='<td><textarea rows="5" class="form-control cf-menu-box cf-menu-lunch" name="lunch"></textarea></td>';
    	  temp +='<td><textarea rows="5" class="form-control cf-menu-box cf-menu-dinner" name="dinner"></textarea></td>';                
    		temp +='<td><textarea rows="5" class="form-control cf-menu-box cf-menu-snack" name="snack"></textarea></td></tr>';
    	  jQuery("#cfMenuList").append(temp);
    	  setDate();
      }

      function evClickSave() {
          if( !validate() ) {
              return;
          }
          mealAry = [];
          jQuery(".cf-menu").each(function () {
        	  var mealInfo = {};
        	  mealInfo.date = jQuery(this).find("input.cf-menu-date").val();
        	  mealInfo.breakfast = jQuery(this).find("textarea.cf-menu-breakfast").val();
        	  mealInfo.lunch = jQuery(this).find("textarea.cf-menu-lunch").val();
        	  mealInfo.dinner = jQuery(this).find("textarea.cf-menu-dinner").val();
        	  mealInfo.snack = jQuery(this).find("textarea.cf-menu-snack").val();
        	  mealAry.push(mealInfo);
          });
          $("#mealList").val(JSON.stringify(mealAry));

          jQuery.ajax({
              url : "${bedviewPath}/meal/json/insertMeal.jsp",
              type : "POST",
              data : jQuery("#cfMainForm").serialize(),
              success: function( result ) {
                var resultCode = result.resultCode;
                if(resultCode){
              	  alert("식단을 저장하였습니다.");
                } else {
              		alert("식단 저장에 실패하였습니다.");
                }
                pageReload();
              },
              error: function(jqXHR, textStatus) {
              	
              }
          });
      }
      
      function evClickUpdate(obj, idx) {
    	  var taObj = jQuery(obj).closest("tr").find("textarea");
    	  jQuery(taObj).each(function() {
    		  var type = jQuery(this).attr("type");
    		  jQuery("#"+type).val(jQuery(this).val());
    	  });
    	  jQuery("#meal_id").val(idx);
    	  
    	  jQuery.ajax({
            url : "${bedviewPath}/meal/json/updateMeal.jsp",
            type : "POST",
            dataType : "json",
            data : jQuery("#cfMainForm").serialize(),
            success: function( result ) {
              var resultCode = result.resultCode;
              if(resultCode){
            	  alert("식단을 수정하였습니다.");
              } else {
            		alert("식단 수정에 실패하였습니다.");
              }
              pageReload();
            },
            error: function(jqXHR, textStatus) {
            	
            }
        });
      }
      
      function evClickDelete(idx) {
    	  jQuery("#meal_id").val(idx);

    	  jQuery.ajax({
            url : "${bedviewPath}/meal/json/deleteMeal.jsp",
            type : "POST",
            dataType : "json",
            data : jQuery("#cfMainForm").serialize(),
            success: function( result ) {
              var resultCode = result.resultCode;
              if(resultCode){
            	  alert("식단을 삭제하였습니다.");
              } else {
            		alert("식단 삭제에 실패하였습니다.");
              }
              pageReload();
            },
            error: function(jqXHR, textStatus) {
            	
            }
        });
    	  
      }
      
      function validate() {
          jQuery(".cf-menu-data").each(function() {
        	  if(!jQuery(this).val()) {
        		  alert("날짜를 선택해 주세요");
        		  jQuery(this).focus();
        		  return false;
        	  }
        	  jQuery(this).closest("tr").find("textarea.cf-menu-box")
          });
          return true;
      }
      
      function getDate(date) {
				

    	  var today = new Date();
    	  if(date) {
    		  today = new Date(date);
    		  today.setDate(today.getDate()+1);
    	  }
    	  var dd = today.getDate();
        var mm = today.getMonth()+1;
        var yyyy = today.getFullYear();
        
        if(dd<10) {
            dd='0'+dd
        } 

        if(mm<10) {
            mm='0'+mm
        }
        today = yyyy + '-' + mm + '-' + dd;
        
        return today;
      }
      
      function setDate(i) {
        jQuery(".cf-menu-date").each(function(index){
        	if(index > i || !i) {
	        	if(index == 0) {
	        		if(!jQuery(this).val()) {
	        			jQuery(this).val(getDate());
	        		}
	        	} else {
	          	  jQuery(this).val(getDate(jQuery(".cf-menu-date").eq(index-1).val()));
	        	}
        	}
        });
      }
      
      function pageReload() {
    	  jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
    	  jQuery("#searchForm").submit();
      }
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">식단 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">침상용 관리 메뉴</a></li>
            <li class="active">식단 관리</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
          	<form id="searchForm" name="searchForm" action="index.jsp" method="post">
          		<input type="hidden" id="page_no" name="page_no"/>
          	</form>
            <div class="row">
                <div class="col-xs-12 col-sm-12 text-right">
                  <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">식단 추가</button>
                </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-12">
              <div class="panel panel-default panel-table">
                <div class="panel-heading">Default
                  <div class="tools"><span class="icon mdi mdi-download"></span><span class="icon mdi mdi-more-vert"></span></div>
                </div>
                <div class="panel-body">
                  <table id="mainDataTable" class="table table-striped table-hover table-fw-widget">
                    <thead>
                      <tr>
                        <th class="text-center">날짜</th>
                        <th class="text-center">아침</th>
                        <th class="text-center">점심</th>
                        <th class="text-center">저녁</th>
                        <th class="text-center">간식</th>
                        <th class="text-center">등록정보</th>
                        <th class="text-center">설정</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}">
                      <tr>
                        <td class="text-center">${data.date}</td>
                        <td class="text-center" style="width:200px;"><textarea rows="6" class="form-control cf-menu-box" type="breakfast">${data.breakfast}</textarea></td>
                        <td class="text-center" style="width:200px;"><textarea rows="6" class="form-control cf-menu-box" type="lunch">${data.lunch}</textarea></td>
                        <td class="text-center" style="width:200px;"><textarea rows="6" class="form-control cf-menu-box" type="dinner">${data.dinner}</textarea></td>
                        <td class="text-center" style="width:200px;"><textarea rows="6" class="form-control cf-menu-box" type="snack">${data.snack}</textarea></td>                  
                        <td class="text-center">${data.writer_nm}<br/>${data.updatedAt}</td>
                        <td class="text-center">
                          <button type="button" class="btn btn-success" onclick="evClickUpdate(this, ${data.meal_id})">저장</button>
                          <button type="button" class="btn btn-danger" onclick="evClickDelete(${data.meal_id})">삭제</button>
                        </td>
                      </tr>
</c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>

        </div><!-- /.main-content -->
      </div><!-- /.be-content -->

    <!--Form Modals-->
    <div id="cfMealModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog" style="width: 80% !important;">
        <form id="cfMainForm" name="mainForm" method="POST" action="prcInsert.jsp">
          <input type="hidden" id="mealList" name="mealList" />
          <input type="hidden" id="meal_id" name="meal_id" />
          <input type="hidden" id="breakfast" name="breakfast" />
          <input type="hidden" id="lunch" name="lunch" />
          <input type="hidden" id="dinner" name="dinner" />
          <input type="hidden" id="snack" name="snack" />
          
        </form>
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
              <h3 class="modal-title">식단 정보</h3>
            </div>
            
            <div class="modal-body">
              <div class="form-group" style=" width:100%; overflow-y:auto;">
                <table class="table table-striped table-hover table-fw-widget">
                  <thead>
                    <tr>
                      <th class="text-center">날짜</th>
                      <th class="text-center">아침</th>
                      <th class="text-center">점심</th>
                      <th class="text-center">저녁</th>
                      <th class="text-center">간식</th>
                    </tr>
                  </thead>
                  <tbody id="cfMenuList">
                    <tr class="cf-menu">
                      <td><input type="date" class="form-control cf-menu-date" name="date"></td>
    	  							<td><textarea rows="5" class="form-control cf-menu-box cf-menu-breakfast" name="breakfast"></textarea></td>
    									<td><textarea rows="5" class="form-control cf-menu-box cf-menu-lunch" name="lunch"></textarea></td>
    	  							<td><textarea rows="5" class="form-control cf-menu-box cf-menu-dinner" name="dinner"></textarea></td>               
    									<td><textarea rows="5" class="form-control cf-menu-box cf-menu-snack" name="snack"></textarea></td>
    							  </tr>
                  </tbody>
                </table>
              </div>
            </div>
            
            <div class="modal-footer">
              <button type="button" data-dismiss="modal" class="btn btn-default md-close">취소</button>
              <button type="button" class="btn btn-success" onclick="evClickSave()">저장</button>
              <button type="button" class="btn btn-warning" onclick="evClickMenuAdd()">메뉴 추가</button>
            </div>
            
          </div>
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