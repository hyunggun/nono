<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.FloorBiz"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.InpatientBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.PatientBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="bedviewPath" value="${contextPath}/admin/bedview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
List list = null;
FloorBiz floorBiz = null;
InpatientBiz inpatBiz = null;
PatientBiz patientBiz = null;
int index = 0;
try {
	floorBiz = new FloorBiz();
  resultMap = floorBiz.selectFloor(paramMap);
  
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
 <head>
   <title> 병상용TV </title>
   <meta charset="utf-8">
   <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
	 <link rel="stylesheet" type="text/css" href="css/callPop.css">
	 <script src="${contextPath}/common/js/jquery-3.3.1.min.js"></script>
   <script src="${contextPath}/common/js/bootstrap.min.js"></script>
   
   <script type="text/javascript">
    
    jQuery(document).ready(function(){
      getCallList();
      getPatientList();
      getPatientCount();
      today();
    });
    
    function SoundPlay(){
      var html = '<audio src="call.wav" type="audio/mpeg" autoplay="autoplay">'+
                   '<embed srd="call.wav">'+ 
                 '</audio>';
        $("#sound").empty();
        $("#sound").append(html);
    }
    
    function evClickCompelete( idx, obj ) {
      $.ajax({
          url : "${bedviewPath}/call/json/updateCall.jsp",
          type : "POST",
          cache : false,
          dataType : "json",
          data : {"call_id":idx,"check_yn":"Y"},
          success: function( result ) {
             if(result.resultCode){
           	  $(obj).parent().parent().remove();
             } else {
            	 alert("알람 삭제에 실패하였습니다.");
             }
          },
          error: function(request,status,error) {
          },
          complete: function(jqXHR, textStatus) {
          
          }
      });
    }
    
    function getPatientList(){
        $.ajax({
            url : "${bedviewPath}/call/json/selectPatientList.jsp",
            type : "post",
            cache : false,
            dataType : "json",
            data : {"inpatientKey":'${resultMap.floor_code}'},
            success: function( result ) {
              var html = "";
              var data = result.resultData;
              var max = data.length;
              for(var lp0=0; lp0<max; lp0++) {
            	  if(lp0 == max/2 + max%2) {
            		  $("#leftList").html(html);
            		  html = "";
            	  }
            	  
            	  html += "<tr><td>"+data[lp0].room_nm+"</td>";
            	  html += "<td>"+data[lp0].patient_nm+"</td>";
            	  html += "<td>"+data[lp0].gender+"</td>";
            	  html += "<td>"+data[lp0].age+"</td>";
            	  html += "<td>"+data[lp0].doctor_nm+"</td>";
            	  html += "<td>"+data[lp0].dept+"</td>";
            	  html += "<td>"+data[lp0].ptds+"</td>";
            	  html += "<td>"+data[lp0].addt+"</td>";
            	  html += "<td>"+getDay(data[lp0].addt)+"</td>";
            	  html += "<td>"+data[lp0].opdt+"</td>";
            	  html += "<td>"+getDay(data[lp0].opdt)+"</td></tr>";
              }
    	        $("#rightList").html(html);
            },
            error: function(request,status,error) {
              console.log(error);
            },
            complete: function(jqXHR, textStatus) {
              
            }
        });
    }
    
    function getDay(date) {
    	if(date) {
    		var temp = date;
       	var dateObj = new Date(temp.substring(0,4), temp.substring(4,6)-1, temp.substring(6,8));
       	
       	if(today.getTime() > dateObj.getTime()) {
       		temp = Math.floor((today.getTime() - dateObj.getTime())/1000/60/60/24);
       		return temp;
       	} else {
       		return "-";
       	}
    	} else {
    		return "-";
    	}
    }
    
    function getPatientCount(){
        $.ajax({
            url : "${bedviewPath}/call/json/selectPatientCount.jsp",
            type : "post",
            cache : false,
            dataType : "json",
            data : {"inpatientKey":'${resultMap.floor_code}'},
            success: function( result ) {
              var data = result.resultData;
              
    	        $("#allCount").html(data.allCount+"명");
    	        $("#inCount").html(data.inCount+"명");
    	        $("#outCount").html(data.outCount+"명");
            },
            error: function(request,status,error) {
              console.log(error);
            },
            complete: function(jqXHR, textStatus) {
              
            }
        });
    }
    
    function getCallList(){
        $.ajax({
            url : "${bedviewPath}/call/json/selectCallList.jsp",
            type : "post",
            cache : false,
            dataType : "json",
            data : {"check_yn":"N","floor_id":'${paramMap.floor_id}' },
            success: function( result ) {
              insertCallCard(result.resultData);
              $("#callNo").text(result.resultData.length+"개")
            },
            error: function(request,status,error) {
              console.log(error);
            },
            complete: function(jqXHR, textStatus) {
              
            }
        });
         setTimeout(getCallList, 5000);
    }
    
    function insertCallCard( data ) {
    	  var count = 6;
        var temp = "";
        if(data.length < 7) count = data.length;
      	for ( lp0 = 0 ; lp0 < count; lp0 ++){
          temp += '<div class="call-con">';       
          temp += '<div class="room">'+data[lp0].ward+'</div>'
          temp += '<div class="name">'+data[lp0].time+'</div>';
          temp += '<div class="info">'+data[lp0].content+'</div>';
       		temp += '<div class="end" onclick="evClickCompelete('+data[lp0].call_id+', this)">X</div>';
         	temp += '</div>';
        }
      	jQuery("#callList").html(temp);
    }
    
    function submitForm() {
        $("#cfMainForm").submit();
        $('#cfCallModal').modal('hide');
    }
    
    function today() {
    	var today = new Date();
    	var str = today.getFullYear();
    	if(today.getMonth() + 1 < 10) {
    		str += "-0" + (today.getMonth() + 1);
    	} else {
    		str += "-" + (today.getMonth() + 1);
    	}
    	if(today.getDate() < 10) {
    		str += "-0" + today.getDate();
    	} else {
    		str += "-" + today.getDate();
    	}
    	
    	str += "<br/>";
    	if(today.getHours() > 12) {
    		str += "PM ";
    	} else {
    		str += "AM ";
    	}
    	if(today.getHours() > 12) {
    		str += "0"+today.getHours() - 12;
    	} else {
    		str += "0"+today.getHours();
    	}
    	
    	if(today.getMinutes() < 10) {
    		str += ":0" + today.getMinutes() + " ";
    	} else {
    		str += ":" + today.getMinutes() + " ";
    	}
    	
//     	if(today.getDay() == 0) {
//     		str += "일요일";
//     	} else if(today.getDay() == 1) {
//     		str += "월요일";
//     	} else if(today.getDay() == 2) {
//     		str += "화요일";
//     	} else if(today.getDay() == 3) {
//     		str += "수요일";
//     	} else if(today.getDay() == 4) {
//     		str += "목요일";
//     	} else if(today.getDay() == 5) {
//     		str += "금요일";
//     	} else {
//     		str += "토요일";
//     	}
    	str = "<a>" + str + "</ar>";
    	$("#today").html(str);
      setTimeout(today, 60000);
    }
  </script>
</head>
  <body>
   <div class="top-container">
        <div class="top-logo"><img src="${contextPath}/upload/logo/logo.png"></div>
        <div class="top-title"><a> ${resultMap.floor_nm} </a></div>
        <div class="top-time" id="today"><a>2019-2-14<br>am 10:00</a></div>
     
   </div>  
   <div class="mid-container">
     <div class="contants-box">
       <table class="h-dashboard">
         <thead>
           <tr>
             <th>병실</th>
             <th>이름</th>
             <th>성별</th>
             <th>나이</th>
             <th>주치의</th>
             <th>진료과</th>
             <th style="width:20%;">진단명</th>
             <th>입원일</th>
             <th>입원경과일</th>
             <th>수술일</th>
             <th>수술경과일</th>
           </tr>
         </thead>
         <tbody id="leftList">
         </tbody>
       </table>
     </div>
     <div class="contants-box">
       <table class="h-dashboard">
         <thead>
           <tr>
             <th>병실</th>
             <th>이름</th>
             <th>성별</th>
             <th>나이</th>
             <th>주치의</th>
             <th>진료과</th>
             <th style="width:20%;">진단명</th>
             <th>입원일</th>
             <th>입원경과일</th>
             <th>수술일</th>
             <th>수술경과일</th>
           </tr>
         </thead>
         <tbody id="rightList">
         </tbody>
       </table>
     </div>
   </div>
   
   
   <div class="bottom-container">
      <div class="bt-container">
        <div class="info-title">입/퇴원 현황</div>
        <div class="info-box bg5">
        <div class="title"><p> 재원 </p> </div>
        <div class="con"><p id="allCount"> 0명 </p> </div>
       </div>
       <div class="info-box bg6">
        <div class="title"> <p> 입원 </p> </div>
        <div class="con"><p id="inCount"> 0명 </p> </div>
       </div>
       <div class="info-box bg7">
        <div class="title"> <p> 퇴원 </p> </div>
        <div class="con"><p id="outCount"> 0명 </p> </div>
       </div>
      </div>
      <div class="bt-container">
        <div class="call-box bg1">
         <div class="title">
         	병실호출현황
         	<div id="callNo" style="position:absolute; right:10px; top:10px;">0명</div>
         </div>
         
         <div id="callList">
           <div class="call-con">
	           <div class="room">501호</div>
	           <div class="name">엠티비</div>
	           <div class="info">수액제거해주세요요</div>
	           <div class="end">X</div>
	         </div>
         </div>
        </div>
      </div>
   </div>
   
   
  </body>
  
</html>
