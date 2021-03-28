<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
%>
<c:set var="paramMap" value="<%=paramMap%>" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
	<head>
		<title> 병상용TV </title>
		<meta charset="utf-8">
		<link rel="shortcut icon" href="/favicon.ico">
		<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.0/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="dist/jR3DCarousel.min.js"></script>
		<link href="${contextPath}/common/css/bedview-info.css" rel="stylesheet">
	
	<script>
			$(function(){
		    $("body").fadeIn(1200);
		    //getUserInfo();
		    getBedviewInfo();
		    selectMenuList();
		    //showClock();;
		  });
			
			function showClock() {
				
				var date = new Date();
				var hour = date.getHours();
				var timeStr = "AM";
				if(hour >= 12) {
					timeStr = "PM";
				}
				if(hour > 12) {
					hour = hour - 12;
				}
				if(hour < 10) hour = "0"+hour;
				
				var minutes = date.getMinutes();
				if(minutes < 10) minutes = "0"+minutes;
				
				timeStr = timeStr +" "+ hour + ":" + minutes;
				
				$("#timer").html(timeStr);
			  setTimeout(showClock, 1000 * 10);
			}
			
			function getBedviewInfo() {
				  $.ajax({
			      url:'${contextPath}/json/bedview/ajaxRespSelectBedviewInfo.jsp',
			      type:'POST',
			      data:{bedview_id:"${sessionScope.SESSION_BEDVIEW_ID}"},
			      datatype:'json',
			      success:function(result){
			    	  if(result.resultCode) {
			    			var data = result.resultData;
			    			$("#ward").text(data.ward);
			    			$("#patient_nm").text(data.patient_nm);
			    	  }
			      },
			      error:function(request,status,error){
			        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			       }
			    });
			}
			
			function getUserInfo() {
			  $.ajax({
		      url:'${contextPath}/json/bedview/ajaxRespSelectInpatientInfo.jsp',
		      type:'POST',
		      data:{patient_code:"${sessionScope.SESSION_PATIENT_CODE}"},
		      datatype:'json',
		      success:function(result){
		    	  if(result.resultCode) {
		    			var data = result.resultData;
		    			$("#doctor_nm").text(data.patient_nm);
		    			$("#room_nm").text(data.patient_nm);
		    			$("#patient_nm").text(data.patient_nm);
		    	  }
		      },
		      error:function(request,status,error){
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		       }
		    });
		  }
			
			function selectMenuList() {
			  $.ajax({
		      url:'${contextPath}/json/bedview/ajaxRespSelectMenuList.jsp',
		      type:'POST',
		      data:{pid:"${param.pid}"},
		      datatype:'json',
		      success:function(result){
		    	  if(result.resultCode) {
		    			var list = result.resultData;
		    			var temp = "";
		    			for(var lp0=0; lp0<list.length; lp0++) {
		    				temp += "<li onclick='evClickMenu("+list[lp0].menu_id+")'><a>"+list[lp0].menu_nm+"</a></li>";
		    			}
		    			$("#menuList").html(temp);
		    			var content_id = "${param.pid}";
		    			if(list.length) content_id = list[0].menu_id;
		    			evClickMenu(content_id);
		    	  }
		      },
		      error:function(request,status,error){
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		       }
		    });
		  }
			
			function evClickMenu( menuId ){
			      
			    $.ajax({
			      url:'${contextPath}/json/bedview/ajaxRespSelectContentInfo.jsp',
			      type:'POST',
			      data:{menu_id:menuId},
			      datatype:'json',
			      success:function(result){
			        var resultCode = result.resultCode;
			        var resultData = result.resultData;
			        if( resultCode){
			        	var content = resultData.content;
// 			        	content = content.replace(/192.168.1.110/gi, '1.254.12.139:9000');
			        	$("#contents").html(content);
			        }
			      }
			    });
			  };
		
		</script>
	</head>		
	
	<body>
		<div class="container">
			<div class="top-container">
				<div class="top-left-box">
					<div class="img-deco"><img src="img/home.png" onclick="location.href='${contextPath}/view/bedview/index.jsp'"></div>
					<div class="name-box1" style="width:15%;">
						<div class="title">주치의</div>
						<div class="contants"> 연세더바로병원 </div>
<!-- 						<div class="title">병원장</div> -->
					</div>
					<div class="name-box-deco"></div>
					
					<div class="name-box2">
						<div class="title">병실명</div>
						<div id="ward" class="contants">1301</div>
<!-- 						<div class="title">호</div> -->
					</div>
					
					<div class="name-box-deco"></div>					
					
					<div class="name-box2">
						<div class="title">환자명</div>
						<div id="patient_nm" class="contants">김한일</div>
						<div class="title">님</div>
					</div>
				</div>
				<div class="top-right-box">	<img src="img/logo.png"></div>	
			</div>
			<div class="mid-container">
				<div class="mid-left-box bg${param.bgcolor}-1">
					<div class="nav-box">
						<div class="sub-title-box"><h1>${param.title}</h1><!--img src="img/icon/1.png"--></div>
						<div class="sub-con-box">
							 <ul id="menuList">
<!-- 								<li><a>한일병원이란</a></li> -->
<!-- 								<li><a>병원장인삿말</a></li> -->
<!-- 								<li><a>이념과비젼</a></li> -->
<!-- 								<li><a>협력병원</a></li> -->
<!-- 								<li><a>한일가족갤러리</a></li> -->
<!-- 								<li><a>5번째는모르겠다</a></li> -->
							 </ul>
						</div>						
					</div>
					<div class="info-box">
						<div class="item-1">
							<div class="text-box">
								<h2>대표전화</h2>
								<h1>02-6353-5000</h1>
							</div>
						</div>
						<div class="item-2">
							<div class="text-box">
								<h2>진료시간안내</h2>
								<h3>평&emsp;일 AM 09:00~ PM 06:00</h3>
								<h3>토요일 AM 09:00~ PM 01:00</h3>
								<h3>점&emsp;심 PM 01:00~ PM 02:00</h3>
								<h3>일요일/법정 공휴일 휴진</h3>
							</div>
						</div>
						<div class="item-3">
							<div class="text-box">
								<h4>자가용이용안내</h4>
								<h5>서울시 강남구 논현로853</h5>
								<h4>지하철 이용안내</h4>
								<h5>3호선 압구정역 4번출구</h5>
								<h4>버스 이용안내</h4>
								<h5>147/148/240/263/4211번 압구정역4번 정류장</h5>
							</div>
						</div>
					</div>
				</div>
				<div class="mid-right-box bg111">
					<div id="contents" class="contants-box">
						<img src="img/content-3.png">
					</div>
				</div>				
			</div>
			
		</div>
		
			
	
	</body>
</html>
