<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.NoticeBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="commonviewPath" value="${contextPath}/admin/commonview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

List list = null;
List bedviewList = null;
NoticeBiz noticeBiz = null;
BedviewBiz bedviewBiz = null;
try {
	noticeBiz = new NoticeBiz();
	list = noticeBiz.selectNoticeBedviewTargetList(paramMap);
	
	bedviewBiz = new BedviewBiz();
	bedviewList = bedviewBiz.selectBedviewList(paramMap);
	
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="list" value="<%=list%>" />
<c:set var="bedviewList" value="<%=bedviewList%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
		<style>
		.bedview-box{ border:1px #eee solid; float:left; padding:5px;}
		</style>
    <script type="text/javascript">
			var targetArr = [];
      function evClickDelete( bedviewKey ) {
    	  $.ajax({
           url : "${commonviewPath}/notice_target/json/deleteNoticeTarget.jsp",
           type : "POST",
           cache : false,
           dataType : "json",
           data : {"notice_id":${param.notice_id},"target_id":bedviewKey},
           success: function( result ) {
           	if(result.resultData.resultCode) {
             	alert("삭제하였습니다.");
             	jQuery("#cfMainForm").submit();
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
      
      function evClickSave() {
    	  if(targetArr.length > 0) {
    		  $("#target_arr").val(JSON.stringify(targetArr));
    		  
    		  var data = $("#cfMainForm").serialize();
    		  $.ajax({
 	            url : "${commonviewPath}/notice_target/json/insertNoticeTarget.jsp",
 	            type : "POST",
 	            cache : false,
 	            dataType : "json",
 	            data : data,
 	            success: function( result ) {
 	            	if(result.resultData.resultCode) {
 	              	alert("저장하였습니다.");
 	              	jQuery("#cfMainForm").submit();
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
    	  
      }
      
      function evClickAdd(bedviewKey, bedviewName) {
    	  var isDupl = false;
    	  for(var lp0=0; lp0<targetArr.length; lp0++) {
    		  if(bedviewKey == targetArr[lp0].target_id) {
    			  isDupl = true;
    		  }
    	  }
    	  if(!isDupl) {
    		  var obj = {};
       	  obj.target_id = bedviewKey;
       	  obj.sign_id = bedviewName;
       		targetArr.push(obj);
    	  }
    	  showBedviewList()
      }
      
      function evClickRemove(bedviewKey) {
    	  for(var lp0=0; lp0<targetArr.length; lp0++) {
    		  if(bedviewKey == targetArr[lp0].target_id) {
    			  targetArr.splice(lp0, 1);
    		  }
    	  }
    	  showBedviewList();
      }
      
      function showBedviewList() {
    	  var html = "";
    	  
    	  for(var lp0=0; lp0<targetArr.length; lp0++) {
    		  	html += '<div class="bedview-box">';
        	  html += '<span>'+targetArr[lp0].sign_id+'</span>&nbsp;';
        	  html += '<button type="button" onclick="evClickRemove('+targetArr[lp0].target_id+')" style="padding:0 5px;">X</button></div>';
    	  }
    	  
    	  $("#targetList").html(html);
      }
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">연동 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">공통 관리 메뉴</a></li>
            <li class="active">공지사항</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
        
        	<div class="cf-search-area">
	          <div class="row">
	            <div class="col-sm-12">
                <form id="cfMainForm" name="mainForm" action="editBedView.jsp">
                	<input name="notice_id" type="hidden" value="${param.notice_id}" />
                	<input id="target_arr" name="target_arr" type="hidden"/>
                  <table class="table" style="margin:0;">
                    <tbody>
                      <tr class="text-center">
                        <td class="text-center" style="border:0; font-weight:bold; width:100px;">연동할 기기</td>
                        <td class="text-center" style="border:0; font-weight:bold;">
                        	<div id="targetList" style="min-height:35px;">
                        	</div>
                        </td>
                        <td style="border:0; width:120px;">
                          <button type="button" class="btn btn-success" onclick="evClickSave()">저장</button>
                          <button type="button" class="btn btn-warning" onclick="location.href='index.jsp'">목록</button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </form>
	            </div><!-- /.col-sm-12 -->
	          </div><!-- /.row -->
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
                        <th class="text-center">위치정보</th>
                        <th class="text-center">삭제</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${bedviewList}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>${data.sign_id}</td>
                        <td>${data.ward}</td>
                        <td>
                          <button class="btn btn-primary" onclick="evClickAdd(${data.bedview_id}, '${data.sign_id}')">추가</button>
                        </td>
                      </tr>
</c:forEach>
                    </tbody>
                  </table>

                </div><!-- /.panel-body -->
              </div><!-- /.panel -->
            </div><!-- /.col-sm-12 -->
          </div><!-- /.row -->
          
          <div class="row">
            <div class="col-sm-12">
              <div class="panel panel-default panel-table">
                <div class="panel-body">
	                <form id="cfDeleteForm" name="deleteForm">
		                <input name="notice_id" type="hidden" value="${param.notice_id}" />
		                <input name="target_id" type="hidden" />
	                </form>
                  <table id="mainDataTable2" class="table table-striped table-hover table-fw-widget">
                    <thead>
                      <tr class="text-center">
                        <th class="text-center">No.</th>
                        <th class="text-center">아이디</th>
                        <th class="text-center">위치정보</th>
                        <th class="text-center">삭제</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
                        <td>${data.sign_id}</td>
                        <td>${data.ward}</td>
                        <td>
                          <button class="btn btn-danger" onclick="evClickDelete(${data.bedview_id})">삭제</button>
                        </td>
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
        setMainDataTable('#mainDataTable2');
        var pageNo = "${paramMap.page_no}";
        if(pageNo != "") {
        	jQuery("#mainDataTable").dataTable().fnPageChange(${paramMap.page_no});
        }
      });
    </script>

</body>