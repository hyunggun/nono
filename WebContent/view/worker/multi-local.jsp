<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="workerPath" value="${contextPath}/view/worker" />
<%
String sSignId = (String) session.getAttribute("SESSION_MOBILE_SIGN_ID");
int sHospitalId = (Integer) session.getAttribute("SESSION_MOBILE_HOSPITAL_ID");
if( sSignId == null || sSignId.isEmpty()) {
%>
<script type="text/javascript">
location.href = "${contextPath}/view/worker/login.jsp";
</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv='Refresh' content='60*60*24*7; URL=${workerPath}/logoutProc.jsp'>
<link rel="stylesheet" href="${contextPath}/common/css/bootstrap.min.css">
<link rel="stylesheet" href="${contextPath}/common/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${contextPath}/common/css/alert.css">
<script src="${contextPath}/common/js/jquery-3.3.1.min.js"></script>
<script src="${contextPath}/common/js/bootstrap.min.js"></script>
<script src="${contextPath}/common/js/alert.js"></script>
<style>
body {background:#2f3b4c;}
@font-face  {
	font-family:'NanumGothic';
	src: url('${contextPath}/common/fonts/nanum/NanumGothic.woff') format('woff');
}
@font-face {
	font-family:'NanumGothicBold';
	src: url('${contextPath}/common/fonts/nanum/NanumGothicBold.woff') format('woff');
}
@font-face {
	font-family:'NanumGothicExtraBold';
	src: url('${contextPath}/common/fonts/nanum/NanumGothicExtraBold.woff') format('woff');
}
.cf-multi-pd0{
	padding:0;
}
.cf-multi-pd50{
	padding:0 50px;
}
.cf-multi-mrgnbt15 {
	margin-bottom:15px;
}
.cf-multi-mrgnbt30 {
	margin-bottom:30px;
}
/* 헤더 사용 css  */
.cf-multi-header {
	padding:10px 50px;
}
.cf-multi-logoutbtn {
	background-color:#5b7291;
	border:1px #2778af solid;
	border-radius:7px;
	padding:12px 25px;
	color:#fff;
	font-size:13px;
	font-family:YGD530;
}
.cf-mobile-footer {
	background:white;
	padding:10px 0;
}
/* 진료 테이블 사용 css  */
.cf-treat-header {
  background:#00bbff; 
  font-size:22px; 
  color:white;
}
.cf-treat-body {
	padding:10px 0;
	margin:0;
	text-align:center;
	border:3px white solid;
}
.cf-treat-patient:hover {
	background-color:#2778af;
	color:white;
}
.cf-treat-patient.selected {
	background-color:#5b7291;
	color:white;
}
#cfTreatTable{
	padding:0;
}
#cfTreatTable > table > tbody > tr{
	vertical-align:middle;
	font-size:20px;
}
#cfTreatTable > table > tbody > tr > td{
	padding:10px 0;
}
.cf-treat-btn {
	background-color: #2778af;
	color:white;
	font-family:NanumGothicExtraBold;
	font-size:20px;
	width:100%;
	border:1px white solid;
	padding:10px 0;
}
.cf-status-text {
font-size:18px; 
color:#343434; 
font-family:NanumGothic; 
font-weight:bold;
padding-top:10px;
}
/* 환자등록 사용 css  */
.cf-ptntinfo-title {
	background-color:#cbe2ea;
	font-size:20px;
	color:#1c3360;
    font-family:YGD530;
    font-weight:bold;
	text-align:center;
	padding:11px;
	border-radius:6px;
	z-index:9;
	box-shadow: 0px 2px 1px 0px rgba(168,168,168,1);
}
.cf-ptntinfo-input {
	padding:10px;
	border:1px solid #b0bec5;
	width:100%;
	font-size:18px;
	font-weight:bold;
	font-family:NanumGothic;
	color:#343434;
	z-index:0;
}
.cf-ptntinfo-input:focus {
	outline:none;
}
.cf-patient-button { 
	border:0;
	width:70%;
	padding:15px;
	margin:20px 0;
	font-size:20px;
	color:#fff;
	font-family:NanumGothic;
	font-weight:bold;
	border-radius:6px;
}
.cf-patient-button.cancel {
	background-color:#2f3b4c;
}
.cf-patient-button.add {
	background-color:#00bbff;
}
.cf-patient-selectbtn {
	background:#00bbff;
	color:white;
	padding:3px 30px;
	border:0;
	font-family:NanumGothic
}
select { 
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none; 
	appearance: none;
	background: url('${contextPath}/common/img/worker/arrow.png') no-repeat 95% 50%; /* 화살표 모양의 이미지 */
	background-color:white; 
} 
/* IE 10, 11의 네이티브 화살표 숨기기 */ 
select::-ms-expand { display: none; }
.cf-select-box {
	width:100%;
	font-size:13px;
	color:#343434;
	font-family:NanumGothic;
	padding:7px 25px 7px 12px;
	background:fff;
}
.cf-patient-list {
	background:white;
	font-size:16px;
	color:#343434;
	font-family:NanumGothic;
}
.cf-patient-list > tr > td {
	vertical-align:middle;
	padding:10px;
}
.cf-patient-input {
	font-size:14px;
	color:#343434;
	font-family:NanumGothic;
	height:34px;
	padding:10px;
	width:94%;
}
</style>
<script type="text/javascript">
function checkSession() {
 var sessionTime = <%=session.getMaxInactiveInterval()%> + "000";
 var createdTime = new Date(<%=session.getCreationTime()%>).getTime();
 sessionTime = parseInt(createdTime) + parseInt(sessionTime);
 var endSession = new Date(sessionTime).getTime();
 var today = new Date().getTime();
 endSession = endSession - 3600000;
 console.log("check");
 if(endSession <= today) {
	 location.href="${workerPath}/logoutProc.jsp"
 }
}
function checkStart() {
 checkSession();
 setInterval(checkSession, 1000*60*60);
}

checkStart();
</script>
<script>
jQuery(document).ready(function() {
	selectTreatList();
	selectRoomList();
	selectPatientListByAll();
	$("#s_patient_nm").keypress(function(event) { 
 	    if( event.which == 13 ) { 
 		  selectPatientList();
 		  return false;
 	    }
    });
	$("#phone").keyup(function(){$(this).val( $(this).val().replace(/[^0-9]/g,"") );} );
	$("#birthday").keyup(function(){$(this).val( $(this).val().replace(/[^0-9]/g,"") );} );
});

function evClickUpdateRank() {
	
	var rank = jQuery("#cfSelectRank").val();
	var pre_rank = jQuery("#pre_rank").val();
	var treat_id = jQuery("#treat_id").val();
	
	if(rank == "" || !rank ) {
		floatAlertArea("진료 순번 변경", "변경할 순번을 선택하지 않았습니다.", "확인");
		return false;
	}
	
	if(rank == pre_rank ) {
		floatAlertArea("진료 순번 변경", "기존 순번과 변경할 순번이 같습니다.", "확인");
		return false;
	}

	jQuery.ajax({
		url : "${workerPath}/json/update/ajaxRespUpdateRank.jsp",
		type : "post",
		cache : false,
		dataType : "json",
		data : {rank:rank, pre_rank:pre_rank, treatment_id:treat_id},
		success: function( result ) {
		    if(result.resultCode) {
		    	jQuery("#cfPatientModal").modal('hide');
		    	floatAlertArea("진료 순번 변경", "진료 순번을 변경하였습니다.", "확인");
		    	selectTreatList();
		    } else {
		    	floatAlertArea("진료 순번 변경", "진료 순번 변경에 실패하였습니다.", "확인");
		    }
		},
		error: function(request,status,error) {
		},
		complete: function(jqXHR, textStatus) {
		}
	});
}

function evClickInsertTreat() {
	
	if(!validateTreat()) {
		return;
	}
	
	var room_id = jQuery("#cfSelectRoom").val();
	var emr_doctor_key = jQuery("#cfSelectRoom option:selected").attr("idx");
	var patient_nm = $("#patient_text").val();
	
	if(emr_doctor_key == "" || emr_doctor_key == "0" ) {
		floatAlertArea("진료 정보 등록", "담당의사가 배정되지 않았습니다.", "확인");
		return false;
	}

	jQuery.ajax({
		url : "${workerPath}/json/insert/ajaxRespInsertTreat.jsp",
		type : "post",
		cache : false,
		dataType : "json",
		data : {room_id:room_id, patient_nm: patient_nm, emr_doctor_key:emr_doctor_key},
		success: function( result ) {
		    if(result.resultCode == "success") {
		    	jQuery("#cfRoomModal").modal('hide');
		    	selectTreatList();
		    	floatAlertArea("진료 정보 등록", "진료를 등록하였습니다.", "확인");
		    } else {
		    	floatAlertArea("진료 정보 등록", "진료 등록에 실패하였습니다.", "확인");
		    }
		},
		error: function(request,status,error) {
		},
		complete: function(jqXHR, textStatus) {
		}
	});
}

function evClickCallPatient() {
  var treat_id = jQuery(".cf-treat-patient.selected").attr("idx");
	var preStatus = jQuery(".cf-treat-patient.selected").attr("status");
	floatAlertArea("진료상태 정보 변경", "환자 호출중입니다.", "확인");
	jQuery.ajax({
		url : "${workerPath}/json/update/ajaxRespUpdateStatus.jsp",
		type : "post",
		cache : false,
		dataType : "json",
		data : {treatment_id:treat_id, status:'C'},
		success: function( result ) {
		    if(result.resultCode != "success") {
		    	floatAlertArea("진료상태 정보 변경", "환자 호출에 실패하였습니다.", "확인");
		    	return false;
		    }else{
		      setTimeout(function(){
		        jQuery.ajax({
		      		url : "${workerPath}/json/update/ajaxRespUpdateStatus.jsp",
		      		type : "post",
		      		cache : false,
		      		dataType : "json",
		      		data : {treatment_id:treat_id, status:'T'},
		      		success: function( result ) {
		      		    if(result.resultCode != "success") {
		      		    	floatAlertArea("진료상태 정보 변경", "환자 호출에 실패하였습니다.", "확인");
		      		    	return false;
		      		    }else{
		      		      floatAlertArea("진료상태 정보 변경", "환자를 호출하였습니다.", "확인");
				      		  selectTreatList();
		      		    }
		      		    
		      	    	
		      		},
		      		error: function(request,status,error) {
		      		},
		      		complete: function(jqXHR, textStatus) {
		      		  
		      		}
		      	});
				    
				    
				  },4000);
		    }
		    
	    	
		},
		error: function(request,status,error) {
		},
		complete: function(jqXHR, textStatus) {
		  
		}
	});
  
// 	var treat_id = jQuery(".cf-treat-patient.selected").attr("idx");
// 	var emr_doctor_key = jQuery(".cf-treat-patient.selected").attr("room_code");
// 	if(treat_id == 0 || !treat_id) {
// 		floatAlertArea("환자 호출 경고", "대기 환자를 선택해 주세요.", "확인");
// 		return;
// 	}
// 	jQuery.ajax({
// 		url : "${workerPath}/json/insert/ajaxRespInsertMachineAlertMulti.jsp",
// 		type : "post",
// 		cache : false,
// 		dataType : "json",
// 		data : {treat_id:treat_id, emr_doctor_key:emr_doctor_key},
// 		success: function( result ) {
// 		    if(result.resultCode) {
// 		    	floatAlertArea("환자 호출 정보", "환자를 호출하였습니다.", "확인");
// 		    } else {
// 		    	floatAlertArea("환자 호출 정보", "환자를 호출하는데 실패하였습니다.", "확인");
// 		    }
// 		},
// 		error: function(request,status,error) {
// 		},
// 		complete: function(jqXHR, textStatus) {
// 		}
// 	});
}

function evClickStatus(status) {
	var treat_id = jQuery(".cf-treat-patient.selected").attr("idx");
	var preStatus = jQuery(".cf-treat-patient.selected").attr("status");
	if(treat_id == 0 || !treat_id) {
		floatAlertArea("환자 상태변경 경고", "대기 환자를 선택해 주세요.", "확인");
		return;
	}
	
	if(preStatus == status) {
		floatAlertArea("환자 상태변경 경고", "선택한 환자의 현재 상태와 변경할 상태가 동일합니다. 다시 선택해 주시길 바랍니다.", "확인");
		return;
	}
	
	var isExist = false;
	if(status != 'T') {
		updateStatus(status);
		return;
	}
	
	var rowsCount = 6;
	var colsCount = jQuery(".cf-treat-header").length;
	var locate = jQuery(".cf-treat-patient").index(jQuery(".cf-treat-patient.selected"));
	var temp = parseInt(locate / rowsCount) * 6;
	var confirm_id = jQuery(".cf-treat-patient:eq("+temp+")").attr("idx");

	if(confirm_id != "0") {
		jQuery("#cfConfirmId").val(confirm_id);
		jQuery("#cfConfirmStatus").val(status);
		
		jQuery("#cfConfirmArea").show();
		isExist = true;
	}
	
	if(!isExist) {
		updateStatus(status);
	}
}

function validateTreat() {
	
	if(!jQuery("#patient_id").val()) {
		floatAlertArea("진료 정보 등록", "환자를 선택해 주세요", "확인");
		return false;
	}
	return true;
}

function updateStatus(status) {
	var treat_id = jQuery(".cf-treat-patient.selected").attr("idx");
	
	jQuery.ajax({
		url : "${workerPath}/json/update/ajaxRespUpdateStatus.jsp",
		type : "post",
		cache : false,
		dataType : "json",
		data : {treatment_id:treat_id, status:status},
		success: function( result ) {
		    if(result.resultCode != "success") {
		    	floatAlertArea("진료상태 정보 변경", "환자 접수상태 변경에 실패하였습니다.", "확인");
		    	return false;
		    }
	    	selectTreatList();
	    	floatAlertArea("진료상태 정보 변경", "환자의 접수상태를 변경하였습니다.", "확인");
		},
		error: function(request,status,error) {
		},
		complete: function(jqXHR, textStatus) {
		}
	});
}

function selectTreatListByDoctor() {
  var doctor_idx = jQuery("#cfSelectDoctor option:selected").attr("idx");
  
  $.ajax({
      url : "${workerPath}/json/select/ajaxRespRankingList.jsp",
      type : "POST",
      cache : false,
      dataType : "json",
      data : {emr_doctor_key:doctor_idx},
      success: function( result ) {
        	var list = result.resultData;
            var htmlStr = "";
            var selectStr = "<option value=''>선택</option>";
            for(var lp0=0; lp0<list.length; lp0++) {
                htmlStr += "<tr class='text-center'><td>"+(lp0+1)+"</td>";
                htmlStr += "<td>"+list[lp0].patient_nm+"</td>";
                htmlStr += "<td>"+list[lp0].ranking+"</td>";
                htmlStr += "<td><button type='button' class='cf-patient-selectbtn' onclick='evClickTreat("+list[lp0].ranking+","+list[lp0].rank+","+list[lp0].treatment_id+",\""+list[lp0].patient_nm+"\")'>선택</button></td></tr>";
                selectStr += "<option value='"+list[lp0].rank+"'>"+list[lp0].ranking+"번째</option>";
            }
            jQuery("#cfSelectRank").html(selectStr);
            jQuery("#cfTreatList").html(htmlStr);
      },
      error: function(request,status,error) {
      },
      complete: function(jqXHR, textStatus) {
      }
  });
}
	
function selectPatientList() {
	var doctor_idx = jQuery("#cfSelectRoom option:selected").attr("idx");
	var s_patient_nm = jQuery("#s_patient_nm").val();
  
  $.ajax({
      url : "${workerPath}/json/select/ajaxRespPatientList.jsp",
      type : "POST",
      data : {"emr_doctor_key":doctor_idx, "s_patient_nm":s_patient_nm},
      success: function( result ) {
        	var list = result.resultData;
            var htmlStr = "";
            for(var lp0=0; lp0<list.length; lp0++) {
                htmlStr += "<tr class='text-center'><td>"+list[lp0].patient_id+"</td>";
                htmlStr += "<td>"+list[lp0].patient_nm+"</td>";
                htmlStr += "<td>"+list[lp0].department_nm+"</td>";
                htmlStr += "<td>"+list[lp0].age_sex+"</td>";
                htmlStr += "<td><button type='button' class='cf-patient-selectbtn' onclick='evClickPatient("+list[lp0].patient_id+",\""+list[lp0].patient_nm+"\")'>선택</button></td></tr>";
            }
            jQuery("#cfPatientList").html(htmlStr);
      },
      error: function(request,status,error) {
      },
      complete: function(jqXHR, textStatus) {
      }
  });
}

function selectPatientListByAll() {
	  
	  $.ajax({
	      url : "${workerPath}/json/select/ajaxRespPatientList.jsp",
	      type : "get",
	      cache : false,
	      dataType : "json",
	      data : {},
	      success: function( result ) {
	        	var list = result.resultData;
	            var htmlStr = "";
	            for(var lp0=0; lp0<list.length; lp0++) {
	                htmlStr += "<tr class='text-center'><td>"+list[lp0].patient_id+"</td>";
	                htmlStr += "<td>"+list[lp0].patient_nm+"</td>";
	                htmlStr += "<td>"+list[lp0].department_nm+"</td>";
	                htmlStr += "<td>"+list[lp0].age_sex+"</td>";
	                htmlStr += "<td>"+list[lp0].reserv_time+"</td>";
	                htmlStr += "<td>"+list[lp0].accept_time+"</td>";
	                htmlStr += "<td><div style='max-width:700px;'>"+list[lp0].notice+"</div></td></tr>";
	            }
	            jQuery("#cfPatientListByAll").html(htmlStr);
	      },
	      error: function(request,status,error) {
	      },
	      complete: function(jqXHR, textStatus) {
	      }
	  });
	}

function evClickPatient(patientKey, patientName) {
	jQuery("#patient_id").val(patientKey);
	jQuery("#patient_text").val(patientName);
}

function evClickTreat(ranking, rank, treatKey, patientName) {
	jQuery("#cfSelectRank option:eq("+ranking+")").prop("selected",true);
	jQuery("#pre_rank").val(rank);
	jQuery("#treat_id").val(treatKey);
	jQuery("#treat_text").val(patientName);
}

function selectRoomList() {
	
	jQuery.ajax({
		url : "${workerPath}/json/select/ajaxRespRoomList.jsp",
        type : "post",
        cache : false,
        dataType : "json",
        data : {use_fg:"Y"},
        success: function( result ) {
        	if( result == null) {
        		floatAlertArea("진료실 정보 검색", "진료실 및 의사를 불러오는데 실패하였습니다.", "확인");
        		return;
        	}
         	var str = "";
         	var list = result.resultData;
         	for(var lp0=0; lp0<list.length; lp0++) {
         		var doctor_nm = list[lp0].doctor_nm;
         		var emr_doctor_key = list[lp0].room_code;
         		if(doctor_nm == "") {
         			doctor_nm = "배정안됨";
         		}
          	str += "<option value="+list[lp0].room_id+" idx=\""+emr_doctor_key+"\">"+list[lp0].room_nm+" - "+doctor_nm+" 원장</option>";
         	}
         	jQuery("#cfSelectRoom").html(str);
         	jQuery("#cfSelectDoctor").html(str);
        },
        error: function(request,status,error) {
        },
        complete: function(jqXHR, textStatus) {
        }
	});

}

function selectTreatList() {
	
	jQuery.ajax({
		url : "${workerPath}/json/select/ajaxRespTreatRoomList.jsp",
        type : "post",
        cache : false,
        dataType : "json",
        data:{use_fg:"Y"},
        success: function( result ) {
        	if( result == null ) {
        		floatAlertArea("진료 정보 검색", "진료 정보를 가져오는데 실패하였습니다.", "확인");
        		return;
        	}
        	
        	// 기본 데이터
           	var roomList = result.resultRoom;
           	var treatList = result.resultTreat;
           	
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
           		tableData[0][lp1] = { room_id : roomList[lp1].room_id, room_code : roomList[lp1].room_code, text : roomList[lp1].room_nm + " / " + roomList[lp1].doctor_nm + "원장" };
           	}

           	// 진료 데이터로부터 각 셀 데이터 설정
           	for( var lp2 = 0 ; lp2 < treatList.length ; lp2 ++ ) {
            	var treatData = treatList[lp2];
 
          		for( var lp1 = 0 ; lp1 < roomList.length ; lp1 ++ ) {
          			// 진료 데이터의 room_id 를 통한 비교
          			if( treatData && treatData.room_id == roomList[lp1].room_id ) {
          				if( treatData.status == "T" ) { // 진료중 여부 확인
          					if(tableData[1][lp1].room_id) {
          						for(var lp0 = 2 ; lp0 < 6 ; lp0 ++) {
          							if( !tableData[lp0][lp1] || !tableData[lp0][lp1].room_id ) { // 대기열에 정보가 있으면 다음으로
     	               			tableData[lp0][lp1] = { room_id : treatData.room_id, text : treatData.patient_nm , treat_id : treatData.treatment_id, status : treatData.status };
     	               			break;
     	               		}
          						}
          					} else {
             					tableData[1][lp1] = { room_id : treatData.room_id, text : treatData.patient_nm, treat_id : treatData.treatment_id, status : treatData.status };
          					}
          				} else {
   	               	for( var lp0 = 2 ; lp0 < 6 ; lp0 ++ ) {
   	               		if( !tableData[lp0][lp1] || !tableData[lp0][lp1].room_id ) { // 대기열에 정보가 있으면 다음으로
   	               			tableData[lp0][lp1] = { room_id : treatData.room_id, text : treatData.patient_nm , treat_id : treatData.treatment_id, status : treatData.status };
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
                    if( treatList[lp0].room_id == roomList[lp1].room_id && treatList[lp0].status == "S") treatCount++; // 대기열 에 정보가 있으면 대기인수 증가
                 }
           		tableData[6][lp1] = { room_id : roomList[lp1].room_id, text : ""+treatCount }; // 정수를 문자열로
           	}
           	
           	// 기본 width
           	treatWidth = (100 / (roomList.length + 1) );
           	
           	// TAG 구성
           	var str = '<div class="cf-multi-pd0" style="width:300px; display:inline-block;"><table class="table table-condensed text-center" style="border:1px solid #b0bec5; font-family:NanumGothic; font-weight:bold;">';
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
           		str += '<div class="cf-multi-pd0" style="padding-left:10px; width:300px; display:inline-block;"><table class="table table-condensed text-center" style="border:1px solid #b0bec5; font-family:NanumGothic; font-weight:bold;"><tr>';
           		str += '<thead class="cf-treat-header">';
           		for( var lp1 = 0 ; lp1 < 7 ; lp1 ++ ) {
           			if( !tableData[lp1][lp0].text ) tableData[lp1][lp0].text = "-";
           			if( !tableData[lp1][lp0].treat_id) tableData[lp1][lp0].treat_id = 0;
           			if( !tableData[lp1][lp0].status) tableData[lp1][lp0].status = "R";
           			if( lp1 == 0 ) str += '<tr><th class="text-center" style="padding:20px 0px; border:0;">'+tableData[lp1][lp0].text+'</th></tr></thead><tbody style="background:#f1f5f8; font-size:20px; color:#343434; overflow-y:auto;">';
           			else {
           				if(tableData[lp1][lp0].status != "H") str += '<tr><td class="cf-treat-patient" style="width:300px;" idx="'+tableData[lp1][lp0].treat_id+'" status="'+tableData[lp1][lp0].status+'" room_code="'+tableData[0][lp0].room_code+'">'+tableData[lp1][lp0].text+'</td></tr>';
           				else str += '<tr><td class="cf-treat-patient" style="width:300px;" idx="'+tableData[lp1][lp0].treat_id+'" status="'+tableData[lp1][lp0].status+'" room_code="'+tableData[0][lp0].room_code+'">'+tableData[lp1][lp0].text+'(보류)</td></tr>';
           			}
              }
              str += '</tbody></table></div>';
           	}

           	jQuery("#cfTreatTable").html(str);

        	jQuery(".cf-treat-patient").click(function() {
        		if(jQuery(this).hasClass("selected")) {
            	jQuery(this).removeClass("selected");
        		} else {
        			jQuery(".selected").removeClass("selected");
            	jQuery(this).addClass('selected');
        		}
        	});
        },
        error: function(request,status,error) {
        },
        complete: function(jqXHR, textStatus) {
        }
	});

}
</script>
</head>

<body style="overflow:auto;">
	<div class="col-xs-12 cf-multi-pd0">
		<div class="col-xs-12 cf-multi-header">
			<div class="col-xs-8"><img src="${sessionScope.SESSION_MOBILE_LOGO_URL}" style="height:45px;"></div>
			<div class="col-xs-4 cf-multi-pd0 text-right"><img src="${contextPath}/common/img/worker/logout.png" onclick="location.href='logoutProc.jsp';" style="cursor:pointer;"></div>
		</div>
		<div class="col-xs-12 cf-multi-pd50">
		  <div class="col-xs-12" style="padding:5px 0 10px 0;">
         <div class="col-xs-12" id="cfTreatTable" style="overflow-x:auto; white-space:nowrap;">
           
         </div><!-- /.col-sm-12 -->
       </div>
		</div>
		
		<div class="col-xs-12 cf-multi-pd50">
		  <div class="col-xs-12" style="padding:5px 0 10px 0;">
         <div class="col-xs-12" style="padding:0;">
           <div class="form-group" style="max-height:300px; overflow-y:auto;">
						<table class="table table-hover">
						  <thead>
						   <tr style="font-size:18px; font-family:NanumGothic; color:#00bbff; border-bottom:3px solid #2f3b4c;">
						   	<th class="text-center">차트번호</th>
						   	<th class="text-center">환자이름</th>
						   	<th class="text-center">진료과명</th>
						   	<th class="text-center">나이(성별)</th>
						   	<th class="text-center">예약시간</th>
						   	<th class="text-center">접수시간</th>
						   	<th class="text-center">특이사항</th>
						   </tr>
						  </thead>
							<tbody id="cfPatientListByAll" style="background:white;">
								<tr>
									<td colspan="5">환자정보를 불러오지 못했습니다.</td>
								</tr>
							</tbody>
						</table>
	         </div>
         </div><!-- /.col-sm-12 -->
       </div>
		</div>
		
		<div class="col-xs-12 cf-mobile-footer">
		  <div class="col-xs-12 cf-multi-pd50">
			<div class="col-xs-4 cf-multi-pd0">
			  <div class="col-xs-6 cf-multi-pd0" data-toggle="modal" data-target="#cfPatientModal" onclick="selectTreatListByDoctor()" style="cursor:pointer;">
			  	<img src="${contextPath}/common/img/worker/banner01.png" style="width:100%;">
			  	<div style="position:absolute; top:30px; left:40px; color:white; font-family:NanumGothic; font-weight:bold;">
			  		<div style="font-size:22px;">진료순번</div>
			  		<div style="margin-top:5px;">
			  			<span style="font-size:14px;">순번변경하기</span>
			  			<img src="${contextPath}/common/img/worker/go.png">
			  		</div>
			  	</div>
			  </div>
			  <div class="col-xs-6 cf-multi-pd0" data-toggle="modal" data-target="#cfRoomModal" onclick="selectPatientList()" style="cursor:pointer;">
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
			<div class="col-xs-3" onclick="evClickCallPatient()" style="cursor:pointer;">
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
			    <div class="col-xs-10 text-center" style="padding-top:10px; cursor:pointer;" onclick="evClickStatus('S')">
				  	<div><img src="${contextPath}/common/img/worker/icon01.png"></div>
				  	<div class="cf-status-text">대기변환</div>
			  	</div>
			  	<div class="col-xs-offset-1 col-xs-1 cf-multi-pd0 text-right"><div style="width:1px; height:87px; background:#eceef2;"></div></div>
			  </div>
			  <div class="col-xs-3 cf-multi-pd0">
			    <div class="col-xs-10 text-center" style="padding-top:10px; cursor:pointer;" onclick="evClickStatus('T')">
				  	<div><img src="${contextPath}/common/img/worker/icon01.png"></div>
				  	<div class="cf-status-text">진료변환</div>
			  	</div>
			  	<div class="col-xs-offset-1 col-xs-1 cf-multi-pd0 text-right"><div style="width:1px; height:87px; background:#eceef2;"></div></div>
			  </div>
			  <div class="col-xs-3 cf-multi-pd0">
			    <div class="col-xs-10 text-center" style="padding-top:10px; cursor:pointer;" onclick="evClickStatus('H')">
				  	<div><img src="${contextPath}/common/img/worker/icon01.png"></div>
				  	<div class="cf-status-text">보류변환</div>
			  	</div>
			  	<div class="col-xs-offset-1 col-xs-1 cf-multi-pd0 text-right"><div style="width:1px; height:87px; background:#eceef2;"></div></div>
			  </div>
			  <div class="col-xs-3 cf-multi-pd0">
			    <div class="col-xs-10 text-center" style="padding-top:10px; cursor:pointer;" onclick="evClickStatus('F')">
				  	<div><img src="${contextPath}/common/img/worker/icon04.png"></div>
				  	<div class="cf-status-text">완료변환</div>
			  	</div>
			  </div>
			</div>
			</div>
		</div>
		
<!-- 		<div id="cfPatientModal" class="modal fade"> -->
<!-- 		  <div class="modal-dialog" style="width:500px;"> -->
<!-- 		    <div class="modal-content"> -->
<!-- 		      <div class="modal-header cf-multi-pd0" style="background-color:#00bbff;"> -->
<%-- 						<img src="${contextPath}/common/img/worker/close.png" data-dismiss="modal" aria-label="Close" style="position:absolute; right:0; cursor:pointer;"> --%>
<!-- 		        <div class="text-center" style="padding:12px;"><span style="color:white; font-size:30px; font-weight:bold; font-family:NanumGothic;">환자 등록</span></div> -->
<!-- 		      </div> -->
<!-- 		      <div class="modal-body" style="display:inline-block;"> -->
<!-- 	        	<div class="col-xs-12 cf-multi-mrgnbt15"> -->
<!-- 						  <input type="text" id="patient_nm" class="cf-ptntinfo-input" maxlength="8" placeholder="환자이름"/> -->
<!-- 						</div> -->
<!-- 						<div class="col-xs-12 cf-multi-mrgnbt15"> -->
<!-- 						  <input type="text" id="birthday" class="cf-ptntinfo-input" maxlength="8" placeholder="생년월일"/> -->
<!-- 						</div> -->
<!-- 						<div class="col-xs-12 cf-multi-mrgnbt15"> -->
<!-- 						  <input type="text" id="phone" class="cf-ptntinfo-input" maxlength="11" placeholder="전화번호"/> -->
<!-- 						</div> -->
<!-- 						<div class="col-xs-12"> -->
<!-- 						  <input type="text" id="reg_no" class="cf-ptntinfo-input" maxlength="8" placeholder="차트번호"/> -->
<!-- 						</div> -->
<!-- 		      </div> -->
<!-- 		      <div class="modal-footer" style="border:0;"> -->
<!-- 		        <div class="text-center"><button type="button" class="cf-patient-button add" onclick="floatAlertArea('환자 등록', 'EMR을 통해 등록하실 수 있습니다.', '확인');">환자 등록</button></div> -->
<!-- 		      </div> -->
<!-- 		    </div>/.modal-content -->
<!-- 		  </div>/.modal-dialog -->
<!-- 		</div>/.modal -->
		
		<div id="cfPatientModal" class="modal fade">
		  <div class="modal-dialog" style="width:700px;">
		    <div class="modal-content">
		      <div class="modal-header cf-multi-pd0" style="background-color:#00bbff;">
		        <img src="${contextPath}/common/img/worker/close.png" data-dismiss="modal" aria-label="Close" style="position:absolute; right:0; cursor:pointer;">
		        <div class="text-center" style="padding:12px;"><span style="color:white; font-size:30px; font-weight:bold; font-family:NanumGothic;">환자 등록</span></div>
		      </div>
		      <div class="modal-body cf-multi-pd0">
		      	<div class="col-xs-12" style="background:#f1f5f8; padding:15px 40px; font-family:NanumGothic; font-size:18px;">
		        	<div class="col-xs-4">
			       	  <label>진료실 - 담당의사</label>
			       	  <select id="cfSelectDoctor" class="cf-select-box" onchange="selectTreatListByDoctor()">
						  	</select>
							</div>
							<div class="col-xs-4 cf-multi-pd0">
			          <label>선택된 환자</label>
			          <input id="treat_id" name="treat_id" type="hidden"/>
			          <input id="pre_rank" name="pre_rank" type="hidden"/>
			        	<input id="treat_text" type="text" class="cf-patient-input" placeholder="검색한 환자를 선택하세요" readonly="readonly"/>
			        </div>
			        <div class="col-xs-4 cf-multi-pd0">
			           <label>순번 선택</label>
								 <select id="cfSelectRank" class="cf-select-box">
								 	<option>선택</option>
								 </select>
			        </div>
			      </div>
		        <div class="form-group" style="max-height:220px; overflow-y:auto; width:100%; margin:0; padding:10px 30px;">
							<table class="table table-hover">
							  <thead>
							   <tr style="font-size:18px; font-family:NanumGothic; color:#343434; border-bottom:3px solid #2f3b4c;">
							   	<th class="text-center">번호</th>
							   	<th class="text-center">환자이름</th>
							   	<th class="text-center">순번</th>
							   	<th class="text-center">선택</th>
							   </tr>
							  </thead>
								<tbody id="cfTreatList" class="cf-patient-list">
								
								</tbody>
							</table>
		         </div>
	        	</div>
			      <div class="modal-footer" style="border:0;">
			        <div class="text-center">
			        	<button type="button" class="cf-patient-button cancel" data-dismiss="modal" style="width:30%; margin:10px;">닫기</button>
			        	<button type="button" class="cf-patient-button add" onclick="evClickUpdateRank()" style="width:30%; margin:10px;">진료 순번 번경</button>
			        </div>
			      </div>
		    	</div><!-- /.modal-content -->
		  	</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div id="cfRoomModal" class="modal fade">
		  <div class="modal-dialog" style="width:700px;">
		    <div class="modal-content">
		      <div class="modal-header cf-multi-pd0" style="background-color:#00bbff;">
		        <img src="${contextPath}/common/img/worker/close.png" data-dismiss="modal" aria-label="Close" style="position:absolute; right:0; cursor:pointer;">
		        <div class="text-center" style="padding:12px;"><span style="color:white; font-size:30px; font-weight:bold; font-family:NanumGothic;">환자 등록</span></div>
		      </div>
		      <div class="modal-body cf-multi-pd0">
		      	<div class="col-xs-12" style="background:#f1f5f8; padding:15px 40px; font-family:NanumGothic; font-size:18px;">
		        	<div class="col-xs-4">
			       	  <label>진료실 - 담당의사</label>
			       	  <select id="cfSelectRoom" class="cf-select-box" onchange="selectPatientList()">
						  	</select>
							</div>
							<div class="col-xs-4 cf-multi-pd0">
			          <label>선택된 환자</label>
			          <input id="patient_id" name="patient_id" type="hidden"/>
			        	<input id="patient_text" type="text" class="cf-patient-input" placeholder="검색한 환자를 선택하세요" readonly="readonly"/>
			        </div>
			        <div class="col-xs-4 cf-multi-pd0">
			           <label>환자 검색</label>
			           <input id="s_patient_nm" type="text" class="cf-patient-input" placeholder="이름을 검색하세요">
			        </div>
			      </div>
		        <div class="form-group" style="max-height:220px; overflow-y:auto; width:100%; margin:0; padding:10px 30px;">
							<table class="table table-hover">
							  <thead>
							   <tr style="font-size:18px; font-family:NanumGothic; color:#343434; border-bottom:3px solid #2f3b4c;">
							   	<th class="text-center">차트번호</th>
							   	<th class="text-center">환자이름</th>
							   	<th class="text-center">진료과명</th>
							   	<th class="text-center">나이(성별)</th>
							   	<th class="text-center">선택</th>
							   </tr>
							  </thead>
								<tbody id="cfPatientList" class="cf-patient-list">
									<tr>
										<td colspan="4">검색하시면 이곳에 환자정보가 나옵니다.</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
		         </div>
	        	</div>
			      <div class="modal-footer" style="border:0;">
			        <div class="text-center">
			        	<button type="button" class="cf-patient-button cancel" data-dismiss="modal" style="width:30%; margin:10px;">닫기</button>
			        	<button type="button" class="cf-patient-button add" onclick="evClickInsertTreat()" style="width:30%; margin:10px;">진료 등록</button>
			        </div>
			      </div>
		    	</div><!-- /.modal-content -->
		  	</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div id="cfConfirmArea">
			<div id="cfConfirmBox">
			  <input type="hidden" id="cfConfirmId">
				<input type="hidden" id="cfConfirmStatus">
				<div class="cf-confirm-header">
					다른 환자가 진료중입니다.
				</div>
				<div class="cf-confirm-body">
					이미 진료중인 환자가 있습니다.<br/><br/>
					진료중인 환자를 진료완료로 변경하시겠습니까?
				</div>
				<div class="cf-confirm-btnbox">
					<div class="col-xs-6 cf-confirm-btn" onclick="evClickDialog('yes')">
						예
					</div>
					<div class="col-xs-6 cf-confirm-btn" onclick="evClickDialog('no')">
						아니요
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