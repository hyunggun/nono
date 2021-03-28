<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.CallBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="bedviewPath" value="${contextPath}/admin/bedview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
CallBiz callBiz = null;
try {
	callBiz = new CallBiz();
  resultMap = callBiz.selectCallPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<head>
    <script type="text/javascript">
    var callList = [];
    
    jQuery(document).ready(function(){
      getCallList();
    });
    
    function SoundPlay(){
      var html = '<audio src="call.wav" type="audio/mpeg" autoplay="autoplay">'+
                   '<embed srd="call.wav">'+ 
                 '</audio>';
        $("#sound").empty();
        $("#sound").append(html);
    }
    function noData(){
      var html = '<p class="text-center no-data">호출된 내용이 없습니다.</p>';
      $(".no-data").remove();
      $(".cfFloor").append(html);
    }
    
    function evClickCompelete( idx ) {
      $.ajax({
          url : "${bedwebPath}/call/json/updateCall.jsp",
          type : "POST",
          cache : false,
          dataType : "json",
          data : {"call_id":idx,"check_yn":"Y"},
          success: function( returnVal ) {
            var resultCode = returnVal.resultCode;
              if(resultCode == "success"){
                $("#"+callId).fadeOut(1000);
                //콜 목록에서 배열 삭제
                callList.splice(callList.indexOf(""+callId),1)
              }
          },
          error: function(request,status,error) {
          },
          complete: function(jqXHR, textStatus) {
            if(callList.length == 0){
              var html = '<p class="text-center no-data">호출된 내용이 없습니다.</p>';
                $(".no-data").remove();
                setTimeout(noData, 1000);
            }
          }
      });
    }
    

    function insertCallCard( data ){
      var resultList = [];
      for ( lp0 = 0 ; lp0 < data.length; lp0 ++){
        resultList.push(''+data[lp0].call_id);
        if(callList.indexOf(""+data[lp0].call_id) < 0){
          $(".no-data").remove();
          callList.push(''+data[lp0].call_id);
          var temp = '<div class="col-md-4 col-lg-2" id="'+data[lp0].call_id+'"style="display:none;">';
          temp  +=   '<div class="thumbnail">';
          temp  +=     '<div class="caption">';
          temp  +=       '<h3><b>'+data[lp0].floor_nm+'</b></h3>';
          temp  +=       '<h4>간호사 호출</h3>';
          temp  +=       '<p><b>환자명:</b> '+data[lp0].patient_nm+'</p>';
          temp  +=       '<p><b>날짜:</b> '+data[lp0].date+'</p>';
          temp  +=       '<p><b>시간:</b> '+data[lp0].time+'</p>';
          temp  +=       '<p><a href="#" class="btn btn-primary form-control" role="button" onclick="evClickCompelete('+data[lp0].call_id+')">확인</a></p>';
          temp  +=     '</div>';
          temp  +=   '</div>';
          temp  += '</div>';
          $(".cfFloor").each(function() {
          	var floor_id = jQuery(this).attr("flrIdx");
          	if(floor_id == data[lp0].floor) jQuery(this).append(temp);
          });
          $("#"+data[lp0].call_id).fadeIn(1000);
          if(lp0 == data.length -1 ) SoundPlay();
        }
      }

      for ( lp1 = 0 ; lp1 < callList.length; lp1 ++){
        if(resultList.indexOf(callList[lp1]) < 0){
          evClickCompelete(''+callList[lp1]);
        }
      }
    }
      function getCallList(){
          $.ajax({
              url : "${bedviewPath}/call/json/selectCallList.jsp",
              type : "post",
              cache : false,
              dataType : "json",
              data : {"check_yn":"N","floor_id":${param.floor_id}},
              success: function( returnVal ) {
                var resultData = returnVal.resultData;
                insertCallCard(resultData);
              },
              error: function(request,status,error) {
                console.log(error);
              },
              complete: function(jqXHR, textStatus) {
                if(callList.length == 0){
                  setTimeout(noData, 1000);
              }
            }
          });
          setTimeout(getCallList, 2000);
      }
      function submitForm() {
          $("#cfMainForm").submit();
          $('#cfCallModal').modal('hide');
      }
    </script>
</head>

<body>
<div id="sound">
</div>
    <form id="cfMainForm" name="mainForm" method="POST" action="prcUpdate.jsp">
    	<input type="hidden" id="call_id" name="call_id">
    	<input type="hidden" id="check_yn" name="check_yn"/>
    </form>
      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">호출 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">침상용 관리 메뉴</a></li>
            <li class="active">호출 관리</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
          <div class="row">
            <div class="col-sm-12">
              <div class="panel panel-default panel-table">
                <div class="panel-body" style="padding-top:20px;" id="div_call_card">
<c:forEach var="data" items="${resultMap.list}">
									<div class="col-md-12" style="min-height:150px;">
										<div class="col-md-12"><h2>${data.floor_nm}</h2></div>
										<div class="col-md-12 cfFloor" flrIdx="${data.floor_id}">
										
										</div>
									</div>
</c:forEach>
									<div class="col-md-12" style="min-height:150px;">
										<div class="col-md-12"><h2>미지정</h2></div>
										<div class="col-md-12 cfFloor" flrIdx="0">
										
										</div>
									</div>
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
      });
    </script>

</body>