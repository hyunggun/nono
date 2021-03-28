<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="workerPath" value="${contextPath}/view/worker" />
<%
String sSignId = (String) session.getAttribute("SESSION_MOBILE_SIGN_ID");
if( sSignId == null || sSignId.isEmpty() ) {
%>
<script type="text/javascript">
location.href = "${contextPath}/view/worker/login.jsp";
</script>
<%
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
.cf-single-header {
  background:white;
  padding:15px;
}
.cf-single-logoutbtn {
  background-color:#5b7291;
  border:1px #2778af solid;
  border-radius:7px;
  padding:12px 25px;
  color:#fff;
  font-size:13px;
  font-family:NanumGothicBold;
}
.cf-single-pd0{
  padding:0;
}
.cf-single-mrgnbt15 {
  margin-bottom:10px;
}
.cf-single-tab{
  background:white;
  padding:15px;
  text-align:center;
  border:1px #b0bec5 solid;
  font-family:NanumGothicBold;
  font-size:18px;
  cursor:pointer;
  min-height:102px;
}
.cf-tab-active {
  color:white;
  background-color:#00bbff;
}
.cf-tab-content {
  display:none;
}
.cf-tabcnt-active {
  display:block;
}
.cf-ptnt-title {
  font-size:30px;
  color:#343434;
  font-family:NanumGothic;
  text-align:center;
  padding:40px 0 30px 0;
}
.cf-ptntinfo-input {
  padding:10px 20px;
  border:1px solid #b0bec5;
  width:100%;
  font-size:18px;
  color:#343434;
  font-family:NanumGothic;
}
.cf-ptntinfo-input:focus {
  outline:none;
}
.cf-single-ptntbtn {
  background-color:#00bbff; 
  border-radius:5px;
  width:100%;
  padding:15px;
  margin-top:20px;
  color:#fff;
  font-size:22px;
  font-family:NanumGothicBold;
  border:0;
}
#cfSelectPatient {
  background:fff;
  border:1px solid #b0bec5;
  width:100%;
  padding:7px 10px;
  font-size:18px;
  font-family:NanumGothic;
  color:#343434;
}
#cfSelectPatient:focus {
  outline:none;
}
.cf-patient-search {
  background:#fff;
  color:#343434;
  border:1px solid #b0bec5;
  padding:6px 10px;
  font-size:18px;
  width:100%;
  font-family:NanumGothic;
}
.cf-patient-search:focus {
  outline:none;
}
.cf-patient-title > div{
  border-bottom:3px solid #2f3b4c;
  color:#343434;
  font-size:18px;
  padding:10px;
  text-align:center;
  font-family:NanumGothic;
  font-weight:bold;
}
.cf-patient-content {
  background-color:white;
  color:#343434;
  font-family:NanumGothic;
}
.cf-patient-content:hover {
  background-color:#00bbff;
  color:#fff;
  cursor:pointer;
}
.cf-patient-content > div{
  border-bottom:1px solid #b0bec5;
  font-size:16px;
  text-align:center;
  padding:10px;
}
.cf-status-doctor{
  margin:20px 0;
  background-color:#fff;
  border:1px solid #b0bec5;
  padding:10px;
  text-align:center;
  font-family:NanumGothic;
  font-size:18px;
  color:#343434;
}
#cfSelectDoctor {
  border:0;
  width:100%;
}
#cfSelectDoctor:focus {
  outline:none;
}
.cf-status-change > div{
  padding:0;
  text-align:center;
}
.cf-status-changebtn {
  color:white;
  font-family:NanumGothic;
  font-size:18px;
  padding:27px 21px;
  background:#2f3b4c;
  border:0;
  margin:10px 0px;
  border-radius:40px;
}
.cf-status-patient-title > div{
  border-bottom:3px solid #2f3b4c;
  color:#343434;
  font-size:18px;
  font-family:NanumGothic;
  font-weight:bold;
  text-align:center;
  padding:7px;
  margin-top:20px;
}
.cf-status-patient-content {
  background-color:#fff;
  font-family:NanumGothic;
  font-size:16px;
  text-align:center;
  color:#343434;
  border:0;
  padding:10px;
  border-bottom:1px solid #b0bec5;
}
.cf-status-patient-content:hover {
  background-color:#00bbff;
  color:#fff;
  cursor:pointer;
}
.cf-treat-active {
  background-color:#00bbff;
  color:#fff;
  cursor:pointer;
}
.cf-single-callbtn {
  background-color:#00bbff; 
  border:0;
  border-radius:5px;
  width:100%;
  padding:10px;
  color:white;
  font-size:18px;
  font-family:NanumGothicBold;
  margin-top:30px;
}
.modal-dialog {
margin-top:3%;
}
.cf-room-title {
  color:#24507d;
}
.cf-room-content {
  background-color:#e7eaef;
  color:white;
}
#cfSelectRoom {
  width:100%;
  border:1px solid #b0bec5;
  padding:10px;
  font-size:18px;
  font-family:NanumGothic;
  color:#343434;
}
.cf-modal-info {
  padding:10px;
  border:1px solid #b0bec5;
  width:100%;
  font-size:18px;
  font-family:NanumGothic;
  color:#343434;
  z-index:0;
}
.cf-treat-button { 
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
.cf-treat-button.cancel {
  background-color:#2f3b4c;
}
.cf-treat-button.add {
  background-color:#00bbff;
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
function checkStart() {
 checkSession();
 setInterval(checkSession, 1000*60*60);
}

checkStart();

var role = "${sessionScope.SESSION_MOBILE_USER_ROLE}";
jQuery(document).ready(function() {
  jQuery(".cf-single-tab").click(function(){
    var temp = jQuery(".cf-tab-active:eq(0)").find("img").attr("src");
    temp = temp.replace("on_", "off_");
    jQuery(".cf-tab-active").find("img").attr("src", temp);
    jQuery(".cf-tab-active").removeClass("cf-tab-active");
    jQuery(this).addClass("cf-tab-active");
    
    jQuery(".cf-tabcnt-active").removeClass("cf-tabcnt-active");
    var index = jQuery(".cf-single-tab").index(this);
    jQuery(".cf-tab-content:eq("+index+")").addClass("cf-tabcnt-active");
    jQuery(".cf-single-tab:eq("+index+")").find("img").attr("src", "${contextPath}/common/img/worker/on_0" +(index+1) + ".png");
  });
  
  jQuery("#cfSearchPatient").keypress(function(event) {
    if(event.keyCode == "13") {
      selectPatientList();
    }
  });
  
  selectPatientList();
  selectRoomList();
  selectDoctorList();
  
  $("#phone").keyup(function(){$(this).val( $(this).val().replace(/[^0-9]/g,"") );} );
  $("#birthday").keyup(function(){$(this).val( $(this).val().replace(/[^0-9]/g,"") );} );
  
  
  $("#cfSelectDoctor").on("change",function(){
    selectTreatList();
  });
});
function evClickInsertPaitent() {
  
  var room_id = jQuery("#cfSelectRoom").val();
  var emr_doctor_key = jQuery("#cfSelectRoom option:selected").attr("idx");
  var patient_nm = jQuery("#cfModalName").val();
  
  if(emr_doctor_key == "0" || emr_doctor_key == "") {
    floatAlertArea("진료 정보 등록", "담당의사가 배정되지 않았습니다.", "확인");
    return false;
  }
  var phone = jQuery("#phone").val();
  var phoneRmdr = phone.length % 10;
  phoneRmdr += 6;
  var phone1 = phone.substring(0, 3);
  var phone2 = phone.substring(3, phoneRmdr);
  var phone3 = phone.substring(phoneRmdr, phoneRmdr+4);
  phone = phone1 + "-" + phone2 + "-" +phone3;
  jQuery.ajax({
    url : "${workerPath}/json/insert/ajaxRespInsertPatient.jsp",
    type : "post",
    cache : false,
    dataType : "json",
    data : {patient_nm:jQuery("#patient_nm").val(), 
          birthday:jQuery("#birthday").val(), 
          phone:phone, 
          reg_no:jQuery("#reg_no").val()
        },
    success: function( result ) {
        if(result.resultCode != "success") {
            floatAlertArea("환자 정보 등록", "환자 등록에 실패하였습니다.", "확인");
            return;
          }
          floatAlertArea("환자 정보 등록", "환자를 등록하였습니다.", "확인");
          selectPatientList();
    },
    error: function(request,status,error) {
    },
    complete: function(jqXHR, textStatus) {
    }
  });
}

function evClickInsertTreat() {
  
  var room_id = jQuery("#cfSelectRoom").val();
  var emr_doctor_key = jQuery("#cfSelectRoom option:selected").attr("idx");
  var patient_nm = jQuery("#cfModalName").val();
  
  if(emr_doctor_key == "0" || emr_doctor_key == "") {
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
          selectPatientList();
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

function evClickTreat(obj) {
  if(jQuery(obj).hasClass("cf-treat-active")) {
    jQuery(obj).removeClass("cf-treat-active");
  } else {
    jQuery(".cf-treat-active").removeClass("cf-treat-active");
    jQuery(obj).addClass("cf-treat-active");
  }
}

function evClickCallPatient() {
  var treat_id = jQuery(".cf-treat-active").attr("idx");
  jQuery.ajax({
    url : "${workerPath}/json/update/ajaxRespUpdateStatus.jsp",
    type : "post",
    cache : false,
    dataType : "json",
    data : {treatment_id:treat_id, status:'S'},
    success: function( result ) {
    },
    error: function(request,status,error) {
    },
    complete: function(jqXHR, textStatus) {
      setTimeout(function(){
        jQuery.ajax({
          url : "${workerPath}/json/update/ajaxRespUpdateStatus.jsp",
          type : "post",
          cache : false,
          dataType : "json",
          data : {treatment_id:treat_id, status:'T'},
          success: function( result ) {
              if(result.resultCode != "success") {
                floatAlertArea("진료상태 정보 변경", "환자를 호출하지 못했습니.", "확인");
                return false;
              }
              selectTreatList();
              floatAlertArea("진료상태 정보 변경", "환자를 호출했습니다.", "확인");
          },
          error: function(request,status,error) {
          },
          complete: function(jqXHR, textStatus) {
          }
        });
      },5000);
    }
  });
}
function evClickStatus(status) {
  var treat_id = jQuery(".cf-treat-active").attr("idx");
  var preStatus = jQuery(".cf-treat-active").attr("status");
  
  if(!treat_id) {
    floatAlertArea("환자 상태변경 경고", "대기 환자를 선택해 주세요.", "확인");
    return;
  }
  if(preStatus == status) {
    floatAlertArea("환자 상태변경 경고", "선택한 환자의 현재 상태와 변경할 상태가 동일합니다. 다시 선택해 주시길 바랍니다.", "확인");
    return;
  }

  var isExist = false;
  if(status != "T") {
    updateStatus(status);
    return;
  }
  jQuery(".cf-status-patient-content").each(function() {
    if(jQuery(this).attr("status") == "T") {
      jQuery("#cfConfirmId").val(jQuery(this).attr("idx"));
      jQuery("#cfConfirmStatus").val(status);
      
      jQuery("#cfConfirmArea").show();
      isExist = true;
    }
  });
  
  if(!isExist) {
    updateStatus(status);
  }
}

function updateStatus(status) {
  var treat_id = jQuery(".cf-treat-active").attr("idx");
  
  jQuery.ajax({
    url : "${workerPath}/json/update/ajaxRespUpdateStatus.jsp",
    type : "post",
    cache : false,
    dataType : "json",
    data : {treatment_id:treat_id, status:status },
    success: function( result ) {
        if(result.resultCode == "success") {
          selectTreatList();
          floatAlertArea("진료상태 정보 변경", "환자의 접수상태를 변경하였습니다.", "확인");
        } else {
          floatAlertArea("진료상태 정보 변경", "환자 접수상태 변경에 실패하였습니다.", "확인");
        }
    },
    error: function(request,status,error) {
    },
    complete: function(jqXHR, textStatus) {
    }
  });
}

function selectPatientList() {
  var search_type = jQuery("#cfSelectPatient").val();
  var search_text = jQuery("#cfSearchPatient").val();
  
  jQuery.ajax({
        url : "${workerPath}/json/select/ajaxRespPatientList.jsp",
        type : "post",
        cache : false,
        dataType : "json",
        data : {search_text:search_text, search_type:search_type},
        success: function( result ) {
          var str = "";
          var list = result.resultData;
          if(result == null) {
            alert("환자를 검색하는데 실패하였습니다.");
            floatAlertArea("환자 정보 검색", "환자를 검색하는데 실패하였습니다.", "확인");
          }
          for(var lp0=0; lp0<list.length; lp0++) {
            str += "<div class='col-xs-12 cf-single-pd0 cf-patient-content' onclick='selectPatient("+list[lp0].patient_id+")'>";
            str += "<div class='col-xs-4'>"+list[lp0].patient_id+"</div>";
            str += "<div class='col-xs-4'>"+list[lp0].patient_nm+"</div>";
            str += "<div class='col-xs-4'>"+list[lp0].accept_time+"</div></div>";
          }
          jQuery("#cfPatientList").html(str);
        },
        error: function(request,status,error) {
        },
        complete: function(jqXHR, textStatus) {
        }
  });
}

function selectPatient(idx) {
  jQuery.ajax({
        url : "${workerPath}/json/select/ajaxRespPatientInfo.jsp",
        type : "post",
        cache : false,
        dataType : "json",
        data : {patient_id:idx},
        success: function( result ) {
          var data = result.resultData;
          if(data == null) {
            floatAlertArea("환자 상세정보 검색", "환자를 검색하는데 실패하였습니다.", "확인");
            return false;
          }
          jQuery("#patient_id").val(patient_id);
          jQuery("#cfModalNumber").val(data.patient_id);
          jQuery("#cfModalName").val(data.patient_nm);
          jQuery("#cfModalDepartment").val(data.department_nm);
          jQuery("#cfModalAgeSex").val(data.age_sex);
          jQuery("#cfRoomModal").modal();
        },
        error: function(request,status,error) {
        },
        complete: function(jqXHR, textStatus) {
        }
  });
}

function selectDoctorList() {
  
  jQuery.ajax({
        url : "${workerPath}/json/select/ajaxRespDoctorList.jsp",
        type : "post",
        cache : false,
        dataType : "json",
//         data : {nurse_id: '${sessionScope.SESSION_MOBILE_USER_ID}'},
        success: function( result ) {
          var str = "";
          var list = result.resultData;
          if(list.length == 0) {
            floatAlertArea("의사 정보 검색", "의사를 검색하는데 실패하였습니다.", "확인");
            return false;
          }
          for(var lp0=0; lp0<list.length; lp0++) {
            str += "<option value='"+list[lp0].emr_doctor_key+"' ";
            if(lp0==0) str += "selected";
            str += ">"+list[lp0].user_nm+"</option>";
          }
          jQuery("#cfSelectDoctor").append(str);
          selectTreatList();
        },
        error: function(request,status,error) {
        },
        complete: function(jqXHR, textStatus) {
        }
  });

}

function selectTreatList() {
  var emr_doctor_key = "";
  emr_doctor_key = $("#cfSelectDoctor option:selected").val();
  jQuery.ajax({
    url : "${workerPath}/json/select/ajaxRespTreatList.jsp",
        type : "post",
        cache : false,
        dataType : "json",
        data : {emr_doctor_key: emr_doctor_key},
        success: function( result ) {
          var str = "";
          var str_T = "";
          var list = result.resultData;

          if(result == null) {
             floatAlertArea("진료 정보 검색", "진료를 검색하는데 실패하였습니다.", "확인");
             return false;
          }

          for(var lp0=0; lp0<list.length; lp0++) {
            if(list[lp0].status == "T") {
              str_T += "<div class='col-xs-12 cf-single-pd0 cf-status-patient-content' onclick='evClickTreat(this)' idx="+list[lp0].treatment_id+" status="+list[lp0].status+">";
              if(!list[lp0].patient_nm) list[lp0].patient_nm = "-";
              str_T += "<div class='col-xs-4'>"+list[lp0].patient_nm+"</div>";
              str_T += "<div class='col-xs-4'>진료중</div>";
              
              var date = list[lp0].createdAt;
              str_T += "<div class='col-xs-4'>"+date.substr(11,5)+"</div></div>";
            } else {
              str += "<div class='col-xs-12 cf-single-pd0 cf-status-patient-content' onclick='evClickTreat(this)' idx="+list[lp0].treatment_id+" status="+list[lp0].status+">";
              if(!list[lp0].patient_nm) list[lp0].patient_nm = "-";
              str += "<div class='col-xs-4'>"+list[lp0].patient_nm+"</div>";
              if(list[lp0].status == "S") {
                str += "<div class='col-xs-4'>대기</div>";
              } else if(list[lp0].status == "H") {
                str += "<div class='col-xs-4'>보류</div>";
              } else {
                str += "<div class='col-xs-4'>진료완료</div>";
              }
              
              var date = list[lp0].createdAt;
              str += "<div class='col-xs-4'>"+date.substr(11,5)+"</div></div>";
            }
          }
          jQuery("#cfTreatList").html(str_T + str);
        },
        error: function(request,status,error) {
        },
        complete: function(jqXHR, textStatus) {
        }
  });

}
function selectRoomList() {
  
  jQuery.ajax({
    url : "${workerPath}/json/select/ajaxRespRoomList.jsp",
        type : "post",
        cache : false,
        dataType : "json",
        data : {},
        success: function( result ) {
          var str = "";
          var list = result.resultData;
          
          if(result == null ){
            floatAlertArea("진료실 정보 검색", "진료실을 검색하는데 실패하였습니다.", "확인");
            return false;
          }
          
          for(var lp0=0; lp0<list.length; lp0++) {
            var doctor_nm = list[lp0].doctor_nm;
            var emr_doctor_key = list[lp0].room_code;
            if(doctor_nm == "") {
              doctor_nm = "배정안됨";
            }
            str += "<option value="+list[lp0].room_id+" idx='"+emr_doctor_key+"'>"+list[lp0].room_nm+" - "+doctor_nm+" 원장</option>";
          }
          jQuery("#cfSelectRoom").html(str);
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
      <div class="col-xs-4 cf-single-tab" onclick="selectTreatList()">
        <div><img src="${contextPath}/common/img/worker/off_03.png"></div>
        <div style="margin-top:7px;">상태변경</div>
      </div>
    </div>
    <div class="col-xs-12 cf-single-pd0">
      <div class="col-xs-12 cf-tab-content cf-tabcnt-active cf-single-pd0">
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
          <button type="button" class="cf-single-ptntbtn" onclick="evClickInsertPaitent();">환자 등록</button>
        </div>
      </div>
      <div class="cf-tab-content col-xs-12">
        <div class="col-xs-12" style="padding:20px 0;">
          <div class="col-xs-5 cf-single-pd0">
            <select id="cfSelectPatient">
              <option value="Number">차트번호</option>
              <option value="Name">환자이름</option>
            </select>
          </div>
          <div class="col-xs-7" style="padding-right:0; padding-left:5px;">
            <input type="text" id="cfSearchPatient" class="cf-patient-search" placeholder="검색어를 입력해 주세요"/>
          </div>
        </div>
        <div class="col-xs-12 cf-single-pd0">
          <div class="col-xs-12 cf-single-pd0 cf-patient-title">
            <div class="col-xs-4">차트번호</div>
            <div class="col-xs-4">이름</div>
            <div class="col-xs-4">예약시간</div>
          </div>
          <div id="cfPatientList" class="col-xs-12 cf-single-pd0" style="max-height:400px; overflow-y:scroll;">
            <div class="col-xs-12 cf-single-pd0 cf-patient-content">
              <div class="col-xs-4">A0000001</div>
              <div class="col-xs-4">이수근</div>
              <div class="col-xs-4">08:30</div>
            </div>
          </div>
        </div>
      </div>
      <div class="cf-tab-content col-xs-12">
        <div class="col-xs-12 cf-single-pd0 cf-status-doctor">
          <div class="col-xs-4">담당의사</div>
          <div class="col-xs-8">
            <select id="cfSelectDoctor" >
            </select>
          </div>
        </div>
        <div class="col-xs-12 cf-single-pd0 cf-status-change">
          <div class="col-xs-3"><button class="cf-status-changebtn" type="button" onclick="evClickStatus('S')">대 기</button></div>
          <div class="col-xs-3"><button class="cf-status-changebtn" type="button" onclick="evClickStatus('T')">진 료</button></div>
          <div class="col-xs-3"><button class="cf-status-changebtn" type="button" onclick="evClickStatus('H')">보 류</button></div>
          <div class="col-xs-3"><button class="cf-status-changebtn" type="button" onclick="evClickStatus('F')">완 료</button></div>
        </div>
        <div class="col-xs-12 cf-single-pd0">
          <div class="col-xs-12 cf-single-pd0 cf-status-patient-title">
            <div class="col-xs-4">이름</div>
            <div class="col-xs-4">접수현황</div>
            <div class="col-xs-4">접수시간</div>
          </div>
          <div id="cfTreatList" class="col-xs-12 cf-single-pd0" style="max-height:230px; overflow-y:scroll;">
          </div>
        </div>
      
        <div class="col-xs-12 cf-single-pd0">
          <button type="button" class="cf-single-callbtn" onclick="evClickCallPatient()">대기 환자 호출</button>
        </div>
      </div>
    </div>
    
    <div id="cfRoomModal" class="modal fade">
      <div class="modal-dialog">
        <div class="modal-content">
          <input type="hidden" id="patient_id" name="patient_id">
          <div class="modal-header cf-single-pd0" style="background-color:#00bbff;">
            <img src="${contextPath}/common/img/worker/close.png" data-dismiss="modal" aria-label="Close" style="position:absolute; right:0; cursor:pointer;">
            <div class="text-center" style="padding:12px;"><span style="color:white; font-size:30px; font-weight:bold; font-family:NanumGothic;">진료 등록</span></div>
          </div>
          <div class="modal-body" style="display:inline-block; margin-top:30px;">
            <div class="col-xs-12 cf-single-mrgnbt15">
              <input type="text" id="cfModalNumber" class="cf-modal-info" maxlength="8" placeholder="차트번호" readonly="readonly"/>
            </div>
            <div class="col-xs-12 cf-single-mrgnbt15">
              <input type="text" id="cfModalName" class="cf-modal-info" maxlength="8" placeholder="환자이름" readonly="readonly"/>
            </div>
            <div class="col-xs-12 cf-single-mrgnbt15">
              <input type="text" id="cfModalDepartment" class="cf-modal-info" maxlength="8" placeholder="진료과명" readonly="readonly"/>
            </div>
            <div class="col-xs-12 cf-single-mrgnbt15">
              <input type="text" id="cfModalAgeSex" class="cf-modal-info" maxlength="11" placeholder="나이(성별)" readonly="readonly"/>
            </div>
            
            <div class="col-xs-12 cf-single-mrgnbt15">
              <select id="cfSelectRoom">
                  
              </select>
            </div>
          </div>
          <div class="modal-footer" style="border:0;">
            <div class="text-center">
              <button type="button" class="cf-treat-button cancel" data-dismiss="modal" style="width:35%; margin:10px;">닫기</button>
              <button type="button" class="cf-treat-button add" onclick="evClickInsertTreat()" style="width:35%; margin:10px;">진료 등록</button>
            </div>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    <div id="cfConfirmArea" style="display:none;">
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
        <div>
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