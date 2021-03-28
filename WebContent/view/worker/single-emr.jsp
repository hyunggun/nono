<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="workerPath" value="${contextPath}/view/worker" />
<%
String sSignId = (String) session.getAttribute("SESSION_MOBILE_SIGN_ID");
if( sSignId == null || sSignId.isEmpty() ) {
%>
<script type="text/javascript">
location.href = "${workerPath}/login.jsp";
</script>
<%
}

RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
UserBiz userBiz = null;
try {
		paramMap.put("nurse_id", session.getAttribute("SESSION_MOBILE_USER_ID"));
		userBiz = new UserBiz();
    resultMap = userBiz.selectNurse(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<link rel="shortcut icon" href="/favicon.ico">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${contextPath}/common/css/alert.css">
<script src="${contextPath}/common/js/alert.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
@font-face  { font-family:'NanumGothic'; src: url('${contextPath}/common/fonts/nanum/NanumGothic.woff') format('woff'); }
@font-face { font-family:'NanumGothicBold'; src: url('${contextPath}/common/fonts/nanum/NanumGothicBold.woff') format('woff'); }
@font-face { font-family:'NanumGothicExtraBold'; src: url('${contextPath}/common/fonts/nanum/NanumGothicExtraBold.woff') format('woff');}
.cf-single-header { background:white; padding:15px; }
.cf-single-logoutbtn { background-color:#5b7291; border:1px #2778af solid; order-radius:7px; padding:12px 25px; color:#fff; font-size:13px; font-family:NanumGothicBold; }
.cf-single-pd0{ padding:0; }
.cf-single-mrgnbt15 { margin-bottom:10px; }
.cf-single-tab{ background:white; padding:15px; text-align:center; border:1px #b0bec5 solid; font-family:NanumGothicBold; font-size:18px; cursor:pointer; min-height:102px; }
.cf-tab-active { color:white; background-color:#00bbff; }
.cf-tab-content { display:none; }
.cf-tabcnt-active { display:block; }
.cf-ptnt-title { font-size:30px; color:#343434; font-family:NanumGothic; text-align:center; padding:40px 0 30px 0; }
.cf-ptntinfo-input { padding:10px 20px; border:1px solid #b0bec5; width:100%; font-size:18px; color:#343434; font-family:NanumGothic; }
.cf-ptntinfo-input:focus { outline:none; }
.cf-single-ptntbtn {background-color:#00bbff; border-radius:5px; width:100%; padding:15px; margin-top:20px; color:#fff; font-size:22px; font-family:NanumGothicBold; border:0;}
#cfSelectPatient { background:fff; border:1px solid #b0bec5; width:100%; padding:7px 10px; font-size:18px; font-family:NanumGothic; color:#343434; }
#cfSelectPatient:focus { outline:none; }
.cf-patient-search { background:#fff; color:#343434; border:1px solid #b0bec5; padding:6px 10px; font-size:18px; width:100%; font-family:NanumGothic;}
.cf-patient-search:focus { outline:none; }
.cf-patient-title > div{ border-bottom:3px solid #2f3b4c; color:#343434; font-size:18px; padding:10px; text-align:center; font-family:NanumGothic; font-weight:bold; }
.cf-patient-content { background-color:white; color:#343434; font-family:NanumGothic; }
.cf-patient-content:hover { background-color:#00bbff; color:#fff; cursor:pointer; }
.cf-patient-content > div{ border-bottom:1px solid #b0bec5; font-size:16px; text-align:center; padding:10px; }
.cf-status-doctor{ margin:20px 0; background-color:#fff; border:1px solid #b0bec5; padding:10px; text-align:center; font-family:NanumGothic; font-size:18px; color:#343434; }
#cfSelectDoctor { border:0; width:100%; }
#cfSelectDoctor:focus { outline:none; }
.cf-status-change > div{ padding:0; text-align:center; }
.cf-status-changebtn { color:white; font-family:NanumGothic; font-size:18px; padding:27px 21px; background:#2f3b4c; border:0; margin:10px 0px; border-radius:40px; }
.cf-status-patient-title > div{ border-bottom:3px solid #2f3b4c; color:#343434; font-size:18px; 
font-family:NanumGothic; font-weight:bold; text-align:center; padding:7px; margin-top:20px;}
.cf-status-patient-content { background-color:#fff; font-family:NanumGothic; font-size:16px; text-align:center; 
color:#343434; border:0; padding:10px; border-bottom:1px solid #b0bec5;}
.cf-status-patient-content:hover { background-color:#00bbff; color:#fff; cursor:pointer; }
.cf-treat-active { background-color:#00bbff; color:#fff; cursor:pointer; }
.cf-single-callbtn {background-color:#00bbff; border:0; border-radius:5px; width:100%; padding:10px; color:white; font-size:18px; font-family:NanumGothicBold; margin-top:30px;}
.modal-dialog { margin-top:3%; }
.cf-room-title { color:#24507d; }
.cf-room-content { background-color:#e7eaef; color:white; }
#cfSelectRoom { width:100%; border:1px solid #b0bec5; padding:10px; font-size:18px; font-family:NanumGothic; color:#343434; }
.cf-modal-info { padding:10px; border:1px solid #b0bec5; width:100%; font-size:18px; font-family:NanumGothic; color:#343434; z-index:0; }
.cf-treat-button { border:0; width:70%; padding:15px; margin:20px 0; font-size:20px; color:#fff; font-family:NanumGothic; font-weight:bold; border-radius:6px; }
.cf-treat-button.cancel { background-color:#2f3b4c; }
.cf-treat-button.add { background-color:#00bbff; }
select {  -webkit-appearance: none; /* 네이티브 외형 감추기 */ -moz-appearance: none;  appearance: none; 
background: url('${contextPath}/common/img/worker/arrow.png') no-repeat 95% 50%; /* 화살표 모양의 이미지 */ background-color:white; } 
/* IE 10, 11의 네이티브 화살표 숨기기 */ 
select::-ms-expand { display: none; }
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
var role = "${sessionScope.SESSION_MOBILE_USER_ROLE}";
jQuery(document).ready(function() {
	evClickTreat();
// 	jQuery(".cf-single-tab").click(function(){
// 		var temp = jQuery(".cf-tab-active:eq(0)").find("img").attr("src");
// 		temp = temp.replace("on_", "off_");
// 		jQuery(".cf-tab-active").find("img").attr("src", temp);
// 		jQuery(".cf-tab-active").removeClass("cf-tab-active");
// 		jQuery(this).addClass("cf-tab-active");
		
// 		jQuery(".cf-tabcnt-active").removeClass("cf-tabcnt-active");
// 		var index = jQuery(".cf-single-tab").index(this);
// 		jQuery(".cf-tab-content:eq("+index+")").addClass("cf-tabcnt-active");
// 		jQuery(".cf-single-tab:eq("+index+")").find("img").attr("src", "${contextPath}/common/img/worker/on_0" +(index+1) + ".png");
// 	});
});

function evClickTreat() {
	
	jQuery.ajax({
		url : "${contextPath}/json/treat/acceptList4Single.jsp",
        type : "post",
        cache : false,
        dataType : "json",
        data : {machineKey: '${resultMap.emr_doctor_key}'},
        success: function( result ) {
        	
         	var str = "";
         	var list = result.resultData.acceptList;

         	if(result == null) {
             floatAlertArea("진료 정보 검색", "진료를 검색하는데 실패하였습니다.", "확인");
             return false;
         	}

         	for(var lp0=0; lp0<list.length; lp0++) {
            str += "<div class='col-xs-12 cf-single-pd0 cf-status-patient-content'>";
            if(!list[lp0].patient_nm) list[lp0].patient_nm = "-";
            str += "<div class='col-xs-4'>"+list[lp0].patient_nm+"</div>";
            if(list[lp0].status == "C") {
          	  str += "<div class='col-xs-4'>검사 대기</div>";
        		} else if(list[lp0].status == "R") {
        			str += "<div class='col-xs-4'>진료 대기</div>";
        		}  else {
        			str += "<div class='col-xs-4'>진료중</div>";
        		}
            if(list[lp0].createdTime != null) {
					    str += "<div class='col-xs-4'>"+list[lp0].createdTime.substring(0,2)+":"+list[lp0].createdTime.substring(2,4)+"</div></div>";
					  } else {
		          str += "<div class='col-xs-4'>-</div></div>";
					  }
         	}
         	jQuery("#cfTreatList").html(str);
        },
        error: function(request,status,error) {
        },
        complete: function(jqXHR, textStatus) {
        }
	});
}
</script>
</head>
<body style="background:#f1f5f8;">
	<div>
		<div class="col-xs-12 cf-single-header">
			<div class="col-xs-8 "><img src="${sessionScope.SESSION_MOBILE_LOGO_URL}" style="height:45px;"></div>
			<div class="col-xs-4 cf-single-pd0 text-right"><img src="${contextPath}/common/img/worker/logout.png" onclick="location.href='logoutProc.jsp';" style="cursor:pointer;"></div>
		</div>
		<div class="col-xs-12 cf-single-pd0">
			<div class="col-xs-4 cf-single-tab cf-tab-active">
				<div><img src="${contextPath}/common/img/worker/on_01.png"></div>
				<div style="margin-top:7px;">환자등록</div>
			</div>
			<div class="col-xs-4 cf-single-tab" style="border-left:0; border-right:0;">
				<div><img src="${contextPath}/common/img/worker/off_02.png"></div>
				<div style="margin-top:7px;">진료등록</div>
			</div>
			<div class="col-xs-4 cf-single-tab" onclick="evClickTreat()">
				<div><img src="${contextPath}/common/img/worker/off_03.png"></div>
				<div style="margin-top:7px;">상태변경</div>
			</div>
		</div>
		<div class="col-xs-12 cf-single-pd0">
			<div class="col-xs-12 cf-tabcnt-active cf-single-pd0">
				<div class="col-xs-12">
					<form name="patientAddForm" method="post">
						<div class="col-xs-12 cf-single-pd0 cf-ptnt-title">
							<span>환자 등록 정보</span>
						</div>
						<div class="col-xs-12 cf-single-pd0 cf-single-mrgnbt15">
							<input type="text" id="patient_nm" class="cf-ptntinfo-input" maxlength="8" placeholder="환자이름"/>
						</div>
						<div class="col-xs-12 cf-single-pd0 cf-single-mrgnbt15">
							<input type="text" id="birthday" class="cf-ptntinfo-input" maxlength="8" placeholder="생년월일"/>
						</div>
						<div class="col-xs-12 cf-single-pd0 cf-single-mrgnbt15">
							<input type="text" id="phone" class="cf-ptntinfo-input" maxlength="11" placeholder="전화번호"/>
						</div>
						<div class="col-xs-12 cf-single-pd0 cf-single-mrgnbt15">
							<input type="text" id="reg_no" class="cf-ptntinfo-input" maxlength="8" placeholder="차트번호"/>
						</div>
					</form>
				</div>
				<div class="col-xs-12">
					<button type="button" class="cf-single-ptntbtn" onclick='floatAlertArea("환자 정보 등록", "EMR을 통해 하실 수 있습니다.", "확인");'>환자 등록</button>
				</div>
			</div>
			<div class="cf-tab-content col-xs-12">
				<div class="col-xs-12" style="padding:20px 0;">
					<div class="col-xs-5 cf-single-pd0">
						<select id="cfSelectPatient">
							<option value="N">환자이름</option>
							<option value="B">생년월일</option>
							<option value="R">차트번호</option>
						</select>
					</div>
					<div class="col-xs-7" style="padding-right:0; padding-left:5px;">
						<input type="text" id="cfSearchPatient" class="cf-patient-search" placeholder="검색어를 입력해 주세요"/>
					</div>
				</div>
				<div class="col-xs-12 cf-single-pd0">
					<div class="col-xs-12 cf-single-pd0 cf-patient-title">
						<div class="col-xs-4">이름</div>
						<div class="col-xs-4">생년월일</div>
						<div class="col-xs-4">차트번호</div>
					</div>
					<div id="cfPatientList" class="col-xs-12 cf-single-pd0" style="max-height:400px; overflow-y:scroll;">
						<div class="col-xs-12 cf-single-pd0 cf-patient-content">
							<div class="col-xs-4">이수근</div>
							<div class="col-xs-4">19950530</div>
							<div class="col-xs-4">A0000001</div>
						</div>
					</div>
				</div>
			</div>
			<div class="cf-tab-content col-xs-12"> <!-- cf-tab-content -->
				<div class="col-xs-12 cf-single-pd0 cf-status-doctor">
					<div class="col-xs-4">담당의사</div>
					<div class="col-xs-8">${resultMap.doctor_nm}</div>
				</div>
				<div class="col-xs-12 cf-single-pd0 cf-status-change">
					<div class="col-xs-3"><button class="cf-status-changebtn" type="button" onclick='floatAlertArea("진료 상태 변경", "EMR을 통해 하실 수 있습니다.", "확인");'>대 기</button></div>
					<div class="col-xs-3"><button class="cf-status-changebtn" type="button" onclick='floatAlertArea("진료 상태 변경", "EMR을 통해 하실 수 있습니다.", "확인");'>진 료</button></div>
					<div class="col-xs-3"><button class="cf-status-changebtn" type="button" onclick='floatAlertArea("진료 상태 변경", "EMR을 통해 하실 수 있습니다.", "확인");'>보 류</button></div>
					<div class="col-xs-3"><button class="cf-status-changebtn" type="button" onclick='floatAlertArea("진료 상태 변경", "EMR을 통해 하실 수 있습니다.", "확인");'>완 료</button></div>
				</div>
				<div class="col-xs-12 cf-single-pd0">
					<div class="col-xs-12 cf-single-pd0 cf-status-patient-title">
						<div class="col-xs-4">이름</div>
						<div class="col-xs-4">접수현황</div>
						<div class="col-xs-4">예약시간</div>
					</div>
					<div id="cfTreatList" class="col-xs-12 cf-single-pd0" style="max-height:400px; overflow-y:scroll;">
					</div>
				</div>
			
				<div class="col-xs-12 cf-single-pd0">
					<button type="button" class="cf-single-callbtn" onclick='floatAlertArea("대기 환자 호출", "EMR을 통해 하실 수 있습니다.", "확인");'>대기 환자 호출</button>
				</div>
			</div>
		</div>
		
		<div id="cfAlertArea">
			<div id="cfAlertBox" style="width:300px;">
				<div class="cf-alert-header">
				</div>
				<div class="cf-alert-body">
				</div>
				<div class="cf-alert-btnbox">
					<div class="cf-alert-btn" onclick="jQuery('#cfAlertArea').hide();">
					</div>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>