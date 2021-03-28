<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="workerPath" value="${contextPath}/view/worker" />
<%
String sSignId = (String) session.getAttribute("SESSION_MOBILE_SIGN_ID");
if( sSignId == null || sSignId.isEmpty()) {
%>
<script type="text/javascript">
location.href = "${workerPath}/index.jsp";
</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="shortcut icon" href="/favicon.ico">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${contextPath}/common/css/alert.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="${contextPath}/common/js/alert.js"></script>
<style>
body {background:#2f3b4c;}
@font-face  { font-family:'NanumGothic'; src: url('${contextPath}/common/fonts/nanum/NanumGothic.woff') format('woff'); }
@font-face { font-family:'NanumGothicBold'; src: url('${contextPath}/common/fonts/nanum/NanumGothicBold.woff') format('woff'); }
@font-face { font-family:'NanumGothicExtraBold'; src: url('${contextPath}/common/fonts/nanum/NanumGothicExtraBold.woff') format('woff'); }
.cf-multi-pd0{ padding:0; }
.cf-multi-pd50{ padding:0 50px; }
.cf-multi-mrgnbt15 { margin-bottom:15px; }
.cf-multi-mrgnbt30 { margin-bottom:30px; }
/* 헤더 사용 css  */
.cf-multi-header { padding:10px 50px; }
.cf-multi-logoutbtn { background-color:#5b7291; border:1px #2778af solid; border-radius:7px; padding:12px 25px; color:#fff; font-size:13px; font-family:YGD530; }
.cf-mobile-footer { background:white; padding:10px 0; }
/* 진료 테이블 사용 css  */
.cf-treat-header { background:#00bbff;  font-size:22px;  color:white; }
.cf-treat-body { padding:10px 0; margin:0; text-align:center; border:3px white solid; }
.cf-treat-patient:hover { background-color:#2778af; color:white; }
.cf-treat-patient.selected { background-color:#5b7291; color:white; }
#cfTreatTable{ padding:0; }
#cfTreatTable > table > tbody > tr{ vertical-align:middle; font-size:20px; }
#cfTreatTable > table > tbody > tr > td{ padding:10px 0; }
.cf-treat-btn { background-color: #2778af; color:white; font-family:NanumGothicExtraBold; font-size:20px; width:100%; border:1px white solid; padding:10px 0; }
.cf-status-text { font-size:18px;  color:#343434;  font-family:NanumGothic;  font-weight:bold; padding-top:10px; }
/* 환자등록 사용 css  */
.cf-ptntinfo-title { background-color:#cbe2ea; font-size:20px; color:#1c3360;  font-family:YGD530; font-weight:bold;
	text-align:center; padding:11px; border-radius:6px; z-index:9; box-shadow: 0px 2px 1px 0px rgba(168,168,168,1); }
.cf-ptntinfo-input { padding:10px; border:1px solid #b0bec5; width:100%; font-size:18px; font-weight:bold; font-family:NanumGothic; color:#343434; z-index:0; }
.cf-ptntinfo-input:focus { outline:none; }
.cf-patient-button {  border:0; width:70%; padding:15px; margin:20px 0; font-size:20px; color:#fff; font-family:NanumGothic; font-weight:bold; border-radius:6px; }
.cf-patient-button.cancel { background-color:#2f3b4c; }
.cf-patient-button.add { background-color:#00bbff; }
.cf-patient-selectbtn { background:#00bbff; color:white; padding:3px 30px; border:0; font-family:NanumGothic; }
select {  -webkit-appearance: none; /* 네이티브 외형 감추기 */ -moz-appearance: none;  appearance: none;
	background: url('${contextPath}/common/img/worker/arrow.png') no-repeat 95% 50%; /* 화살표 모양의 이미지 */ background-color:white;  } 
/* IE 10, 11의 네이티브 화살표 숨기기 */ 
select::-ms-expand { display: none; }
#cfSelectRoom { width:100%; font-size:13px; color:#343434; font-family:NanumGothic; padding:7px 25px 7px 12px; background:fff; }
#cfPatientList { font-size:16px; color:#343434; font-family:NanumGothic; }
#cfPatientList > tr > td { vertical-align:middle; padding:10px; }
.cf-patient-input { font-size:14px; color:#343434; font-family:NanumGothic; height:34px; padding:10px; width:94%; }
</style>
<script type="text/javascript">
function checkSession() {
	var sessionTime = <%=session.getMaxInactiveInterval()%> + "000";
	var createdTime = new Date(<%=session.getCreationTime()%>).getTime();
	sessionTime = parseInt(createdTime) + parseInt(sessionTime);
	var endSession = new Date(sessionTime).getTime();
	var today = new Date().getTime();
	endSession = endSession - 3600000;
	if(endSession <= today) {
	 location.href="${workerPath}/logoutProc.jsp"
	}
}
checkSession();
setInterval(checkSession, 1000*60*60);
</script>
<script>
jQuery(document).ready(function() {
	selectTreatList();
});
function makeList( result ){
//기본 데이터
  var roomList = result.resultData.roomList;
  var treatList = result.resultData.acceptList;
  
  // 테이블 각 셀에 들어갈 데이터 : 세로 : 7 X 가로 : 진료실개수
  var tableData = new Array(7);
  for( var lp0 = 0 ; lp0 < 7 ; lp0 ++ ) {
    tableData[lp0] = new Array(roomList.length);
    for( var lp1 = 0 ; lp1 < roomList.length ; lp1 ++ ) {
      tableData[lp0][lp1] = { };
    }
  }
  
  // 진료실 데이터로 부터 진료실명 설정
  for( var lp1 = 0 ; lp1 < roomList.length ; lp1 ++ ) {
    tableData[0][lp1] = { room_code : roomList[lp1].room_code, text : roomList[lp1].room_nm + " / " + roomList[lp1].doctor_nm + "원장" };
  }

  // 진료 데이터로부터 각 셀 데이터 설정
  for( var lp2 = 0 ; lp2 < treatList.length ; lp2 ++ ) {
    var treatData = treatList[lp2];

    for( var lp1 = 0 ; lp1 < roomList.length ; lp1 ++ ) {
      // 진료 데이터의 room_id 를 통한 비교
      if( treatData && treatData.view_id == roomList[lp1].room_code ) {
        if( treatData.status == "T") { // 진료중 여부 확인
          if(tableData[1][lp1].view_id) {
            for(var lp0 = 2 ; lp0 < 6 ; lp0 ++) {
              if( !tableData[lp0][lp1] || !tableData[lp0][lp1].view_id ) { // 대기열에 정보가 있으면 다음으로
                tableData[lp0][lp1] = { view_id : treatData.view_id, text : treatData.patient_nm, treat_id : treatData.treat_id, status : treatData.status };
                break;
              }
            }
          } else {
            tableData[1][lp1] = { view_id : treatData.view_id, text : treatData.patient_nm, treat_id : treatData.treat_id, status : treatData.status };
          }
        } else {
          for( var lp0 = 2 ; lp0 < 6 ; lp0 ++ ) {
            if( !tableData[lp0][lp1] || !tableData[lp0][lp1].view_id ) { // 대기열에 정보가 있으면 다음으로
              tableData[lp0][lp1] = { view_id : treatData.view_id, text : treatData.patient_nm , treat_id : treatData.treat_id, status : treatData.status };
              break;
            }
          }
        }
        treatData == null;
        break;
      }
    }
  }
  
  // 대기인수 구하기
  for( var lp1 = 0 ; lp1 < roomList.length ; lp1 ++ ) {
    var treatCount = 0;
    for( var lp0 = 0 ; lp0 < treatList.length; lp0 ++ ) {
       if( treatList[lp0].view_id == roomList[lp1].room_code && treatList[lp0].status == "R") treatCount++; // 대기열 에 정보가 있으면 대기인수 증가
    }
    tableData[6][lp1] = { room_code : roomList[lp1].room_code, text : ""+treatCount }; // 정수를 문자열로
  }
  
  // 기본 width
  treatWidth = (100 / (roomList.length + 1) );
  
  // TAG 구성
  var str = '<div class="cf-multi-pd0" style="width:'+treatWidth+'%; float:left;"><table class="table table-condensed text-center" style="border:1px solid #b0bec5; font-family:NanumGothic; font-weight:bold;">';
      str += '<thead style="background:#435062; font-size:22px; color:white;">';
      str += '<tr><th class="text-center" style="padding:20px; border:0;">진료실</th></tr></thead>';
      str += '<tbody style="background:#2f3b4c; font-size:20px; color:white;">';
      str += '<tr><td>진료중</td></tr>';
      str += '<tr><td>대기</td></tr>';
      str += '<tr><td>대기</td></tr>';
      str += '<tr><td>대기</td></tr>';
      str += '<tr><td>대기</td></tr>';
      str += '<tr><td>대기인수</td></tr></tbody></table></div>';

  for( var lp0 = 0 ; lp0 < roomList.length ; lp0 ++ ) {
    str += '<div class="cf-multi-pd0" style="padding-left:10px; width:'+treatWidth+'%; float:left;"><table class="table table-condensed text-center" style="border:1px solid #b0bec5; font-family:NanumGothic; font-weight:bold;"><tr>';
    str += '<thead class="cf-treat-header">';
    for( var lp1 = 0 ; lp1 < 7 ; lp1 ++ ) {
      if( !tableData[lp1][lp0].text ) tableData[lp1][lp0].text = "-";
      if( !tableData[lp1][lp0].treat_id) tableData[lp1][lp0].treat_id = 0;
      if( !tableData[lp1][lp0].status) tableData[lp1][lp0].status = "R";
      if( lp1 == 0 ) str += '<tr><th class="text-center" style="padding:20px 0px; border:0;">'+tableData[lp1][lp0].text+'</th></tr></thead><tbody style="background:#f1f5f8; font-size:20px; color:#343434;">';
      else str += '<tr><td class="cf-treat-patient" style="width:'+treatWidth+'%" idx="'+tableData[lp1][lp0].treat_id+'" status="'+tableData[lp1][lp0].status+'">'+tableData[lp1][lp0].text+'</td></tr>';
    }
    str += '</tbody></table></div>';
  }
  
  const roomWidth = roomList.length * 300 + 200;

  jQuery("#cfTreatTable").css("width",roomWidth+"px");
  jQuery("#cfTreatTable").html(str);

jQuery(".cf-treat-patient").click(function() {
  if(jQuery(this).hasClass("selected")) {
    jQuery(this).removeClass("selected");
  } else {
    jQuery(".selected").removeClass("selected");
    jQuery(this).addClass('selected');
  }
});
}
function selectTreatList() {
	
	jQuery.ajax({
		url : "${contextPath}/json/treat/acceptList4Multi.jsp",
        type : "post",
        cache : false,
        dataType : "json",
        data:{use_fg:"Y"},
        success: function( result ) {
	        	if( result == null ) {
	        		floatAlertArea("진료 정보 검색", "진료 정보를 가져오는데 실패하였습니다.", "확인");
	        		return;
	        	}
	          makeList( result )
        		
        },
        error: function(request,status,error) {
        },
        complete: function(jqXHR, textStatus) {
        }
	});
}
</script>
</head>

<body style="overflow:hidden;">
	<div class="col-xs-12 cf-multi-pd0">
		<div class="col-xs-12 cf-multi-header">
			<div class="col-xs-8"><img src="${sessionScope.SESSION_MOBILE_LOGO_URL}" style="height:45px;"></div>
			<div class="col-xs-4 cf-multi-pd0 text-right"><img src="${contextPath}/common/img/worker/logout.png" onclick="location.href='logoutProc.jsp';" style="cursor:pointer;"></div>
		</div>
		<div class="col-xs-12 cf-multi-pd50">
		  <div class="col-xs-12" style="padding:5px 0 10px 0; overflow-x:scroll;">
         <div class="col-xs-12" id="cfTreatTable">
           
         </div><!-- /.col-sm-12 -->
       </div>
		</div>
		<div class="col-xs-12 cf-mobile-footer">
		  <div class="col-xs-12 cf-multi-pd50">
			<div class="col-xs-4 cf-multi-pd0">
			  <div class="col-xs-6 cf-multi-pd0" style="cursor:pointer;" onclick='floatAlertArea("환자 정보 등록", "EMR을 통해 하실 수 있습니다.", "확인");'>
			  	<img src="${contextPath}/common/img/worker/banner01.png" style="width:100%;">
			  	<div style="position:absolute; top:30px; left:40px; color:white; font-family:NanumGothic; font-weight:bold;">
			  		<div style="font-size:22px;">환자등록</div>
			  		<div style="margin-top:5px;">
			  			<span style="font-size:14px;">환자등록하기</span>
			  			<img src="${contextPath}/common/img/worker/go.png">
			  		</div>
			  	</div>
			  </div>
			  <div class="col-xs-6 cf-multi-pd0" style="cursor:pointer;" onclick='floatAlertArea("진료 정보 등록", "EMR을 통해 하실 수 있습니다.", "확인");'>
			  	<img src="${contextPath}/common/img/worker/banner02.png" style="width:100%;"  >
			  	<div style="position:absolute; top:30px; left:40px; color:white; font-family:NanumGothic; font-weight:bold;">
			  		<div style="font-size:22px;">진료등록</div>
			  		<div style="margin-top:5px;">
			  			<span style="font-size:14px;">진료등록하기</span>
			  			<img src="${contextPath}/common/img/worker/go.png">
			  		</div>
			  	</div>
			  </div>
			</div>
			<div class="col-xs-3" onclick='floatAlertArea("대기 환자 호출", "EMR을 통해 하실 수 있습니다.", "확인");' style="cursor:pointer;">
				<img src="${contextPath}/common/img/worker/banner03.png" style="width:100%; height:129px;">
				<div style="position:absolute; top:30px; left:50px; color:white; font-family:NanumGothic; font-weight:bold;">
			  		<div style="font-size:22px;">환자호출</div>
			  		<div style="margin-top:5px;">
			  			<span style="font-size:14px;">환자호출하기</span>
			  			<img src="${contextPath}/common/img/worker/go.png">
			  		</div>
			  	</div>
			</div>
			<div class="col-xs-offset-1 col-xs-4" style="padding:20px 0;">
			  <div class="col-xs-3 cf-multi-pd0">
			    <div class="col-xs-10 text-center" style="padding-top:10px; cursor:pointer;" onclick='floatAlertArea("진료 상태 변경", "EMR을 통해 하실 수 있습니다.", "확인");'>
				  	<div><img src="${contextPath}/common/img/worker/icon01.png"></div>
				  	<div class="cf-status-text">대기변환</div>
			  	</div>
			  	<div class="col-xs-offset-1 col-xs-1 cf-multi-pd0 text-right"><div style="width:1px; height:87px; background:#eceef2;"></div></div>
			  </div>
			  <div class="col-xs-3 cf-multi-pd0">
			    <div class="col-xs-10 text-center" style="padding-top:10px; cursor:pointer;" onclick='floatAlertArea("진료 상태 변경", "EMR을 통해 하실 수 있습니다.", "확인");'>
				  	<div><img src="${contextPath}/common/img/worker/icon01.png"></div>
				  	<div class="cf-status-text">진료변환</div>
			  	</div>
			  	<div class="col-xs-offset-1 col-xs-1 cf-multi-pd0 text-right"><div style="width:1px; height:87px; background:#eceef2;"></div></div>
			  </div>
			  <div class="col-xs-3 cf-multi-pd0">
			    <div class="col-xs-10 text-center" style="padding-top:10px; cursor:pointer;" onclick='floatAlertArea("진료 상태 변경", "EMR을 통해 하실 수 있습니다.", "확인");'>
				  	<div><img src="${contextPath}/common/img/worker/icon01.png"></div>
				  	<div class="cf-status-text">보류변환</div>
			  	</div>
			  	<div class="col-xs-offset-1 col-xs-1 cf-multi-pd0 text-right"><div style="width:1px; height:87px; background:#eceef2;"></div></div>
			  </div>
			  <div class="col-xs-3 cf-multi-pd0">
			    <div class="col-xs-10 text-center" style="padding-top:10px; cursor:pointer;" onclick='floatAlertArea("진료 상태 변경", "EMR을 통해 하실 수 있습니다.", "확인");'>
				  	<div><img src="${contextPath}/common/img/worker/icon04.png"></div>
				  	<div class="cf-status-text">완료변환</div>
			  	</div>
			  </div>
			</div>
			</div>
		</div>
		
		<div id="cfAlertArea">
			<div id="cfAlertBox">
				<div class="cf-alert-header">
				</div>
				<div class="cf-alert-body">
				</div>
				<div class="cf-alert-btnbox text-center">
					<div class="cf-alert-btn" onclick="jQuery('#cfAlertArea').hide();">
					</div>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>