<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.NoticeBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="commonviewPath" value="${contextPath}/admin/commonview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
NoticeBiz noticeBiz = null;
try {
	noticeBiz = new NoticeBiz();
  resultMap = noticeBiz.selectNoticePage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />

<head>
    <script type="text/javascript">
	  
      $(document).ready(function() {
      	  $("#due_de").keyup(function(){$(this).val( $(this).val().replace(/[^0-9]/g,"") );} );
      	  
      	  var searchData = "${paramMap.search_type}";
      	  if(searchData != "") jQuery("#search_type").val("${paramMap.search_type}");
      	  
      		searchData = "${paramMap.posi_type}";
    	  	if(searchData != "") jQuery("#s_posi_type").val("${paramMap.posi_type}");
	    });
      
      var selectedMainKey = 0;

      function evClickAdd() {
          selectedMainKey = 0;
          $('#cfNoticeModal').modal('show');
          $("#cfDeleteButton").hide();
          
          $("#notice_id").val( "" );
          $("#writer_id").val( "" );
          $("#writer_nm").val( "" );
          $("#posi_type").val( "T" );
          $("#single_multi").val( "M" );
          evChangeType();
          $("#content").val( "" );
          //$("#due_de").val( "" );
      }

      function evClickRow( noticeKey ) {
          selectedMainKey = noticeKey;
          $('#cfNoticeModal').modal('show');
          $("#cfDeleteButton").show();

          $.ajax({
              url : "${commonviewPath}/notice/json/noticeInfo.jsp",
              type : "get",
              cache : false,
              dataType : "json",
              data : {notice_id:noticeKey},
              success: function( returnVal ) {
                  setDataOnForm( returnVal.resultData.noticeObj );
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
          jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
          
          var url = "${commonviewPath}/notice/json/updateNotice.jsp";
          if( !selectedMainKey ) { 
        	  url = "${commonviewPath}/notice/json/insertNotice.jsp";
          }

  	      $('#cfNoticeModal').modal('hide');
  	      
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
					jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
  	      $('#cfNoticeModal').modal('hide');
  	      
  	      var data = jQuery("#cfMainForm").serialize();
  	      
  	      $.ajax({
              url : "${commonviewPath}/notice/json/deleteNotice.jsp",
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
      
      function evChangeType() {
    	  var type = $("#posi_type").val();
    	  if(type == "T") {
    		  $("#title").closest("div").hide();
    		  $("#single_multi").closest("div").show();
    	  } else {
    		  $("#title").closest("div").show();
    		  $("#single_multi").closest("div").hide();
    	  }
      }

      function setDataOnForm( data ) {
          if( !data ) {
              alert("정보를 가져오지 못했습니다.");
              $('#cfNoticeModal').modal('hide');
              return;
          }
          $("#notice_id").val( data.notice_id );
          $("#writer_id").val( data.writer_id );
          $("#writer_nm").val( data.writer_nm );
          $("#title").val( data.title );
          $("#posi_type").val( data.posi_type );
          $("#single_multi").val( data.single_multi );
          //$("#due_de").val( data.due_de );
          var content = data.content;
          content = content.replace(/<br>/g, "\n");
          $("#content").val( content );
          
          evChangeType();
      }
      
      function validate() {
          if( !$("#content").val() ) {
        	  alert("내용을 입력하세요.");
        	  return false;
          }
          return true;
      }
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">공지글 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">현황판 관리 메뉴</a></li>
            <li class="active">공지사항</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="cf-search-area">
            <div class="row">
              <form id="cfSearchForm" name="searchForm" method="POST">
              	<input type="hidden" name="page_no">
              	<div class="col-sm-2">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm cf-mobile-margin">
	                    <select id="s_posi_type" name="posi_type" class="form-control input-sm">
	                    	<option value="">전체</option>
	                    	<option value="T">현황판</option>
	                    	<option value="B">병상용</option>
	                    </select>
	                  </div>
	                </div>
	              </div>
	              
	              <div class="col-sm-2">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm cf-mobile-margin">
	                    <select id="search_type" name="search_type" class="form-control input-sm">
	                    	<option value="C">내용</option>
	                    	<option value="W">작성자</option>
	                    </select>
	                  </div>
	                </div>
	              </div>
	
	              <div class="col-sm-4 col-xs-8">
	                <div class="email-search">
	                  <div class="input-group input-search input-group-sm">
	                    <input name="search_text" type="text" placeholder="검색 내용을 입력하세요" class="form-control input-sm" value="${param.search_text}">
	                    <span class="input-group-btn">
	                      <button type="submit" class="btn btn-default"><i class="icon mdi mdi-search"></i></button>
	                    </span>
	                  </div>
	                </div>
	              </div>

	              <div class="col-xs-4 col-sm-4">
	                <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">글 추가</button>
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
                        <th class="text-center">설정</th>
                        <th class="text-center">내용</th>
                        <th class="text-center">타입</th>
                        <th class="text-center">작성자</th>
                        <th class="text-center">작성날짜</th>
                      </tr>
                    </thead>
                    <tbody>
<c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
<c:if test="${data.posi_type eq 'T' }">
												<td>현황판</td>
</c:if>
<c:if test="${data.posi_type eq 'B' }">
												<td>병상용</td>
</c:if>
                        <td><a href="javascript:evClickRow('${data.notice_id}')">${data.content}</a></td>

<c:if test="${data.single_multi eq 'M' }">
												<td>전체공지</td>
</c:if>
<c:if test="${data.single_multi eq 'S' }">
												<td>개인공지</td>
</c:if>
                        <td>${data.writer_nm}</td>
                        <td>${data.writed_dttm}</td>
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
    <div id="cfNoticeModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog">
        <form id="cfMainForm" name="mainForm" method="POST">
					<input type="hidden" id="notice_id" name="notice_id">
					<input type="hidden" id="page_no" name="page_no">
					<input type="hidden" name="search_type" value="${param.search_type}">
					<input type="hidden" name="search_text" value="${param.search_text}">
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">공지사항 정보</h3>
	          </div>
	          
	          <div class="modal-body">
	            <div class="form-group">
	              <label>작성자</label>
	              <input type="hidden" id="writer_id" name="writer_id"/>
	              <input type="text" id="writer_nm" class="form-control input-sm" disabled="true">
	            </div>
	            <div class="form-group">
	              <label>설정 위치</label>
	              <select id="posi_type" name="posi_type" class="form-control input-sm" onchange="evChangeType()">
	              	<option value="T">현황판</option>
	              	<option value="B">병상용</option>
	              </select>
	            </div>
	            <div class="form-group" style="display:none;">
	              <label>제목</label>
	              <input type="text" id="title" name="title" class="form-control input-sm" placeholder="공지사항 제목을 입력해 주세요" maxlength="50"/>
	            </div>
	            <div class="form-group">
	              <label>내용</label>
	              <textarea id="content" name="content" class="form-control input-sm" rows="6" style="resize:none;"> </textarea>
	            </div>
<!-- 	            <div class="form-group"> -->
<!-- 	              <label>등록기간</label> -->
<!-- 	              <input type="text" id="due_de" name="due_de" class="form-control input-sm" placeholder="년도월일을 입력해 주세요  ex)20201231" maxlength="8"/> -->
<!-- 	            </div> -->
	            
	            <div class="form-group">
	              <label>공지 타입</label>
	              <select id="single_multi" name="single_multi" class="form-control input-sm">
	              	<option value="M">전체</option>
	              	<option value="S">개인</option>
	              </select>
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