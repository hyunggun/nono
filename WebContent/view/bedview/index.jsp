<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="bedviewPath" value="${contextPath}/view/bedview" />
<%
	if( session.getAttribute("SESSION_BEDVIEW_ID") == null ){
    response.sendRedirect("login.jsp");
  }

  RequestUtils util = new RequestUtils();
  HashMap paramMap = util.makeParamMap(request);
//   List imgList = null;
//   BedviewBiz bedviewBiz = new BedviewBiz();
//   try {
//     imgList = bedviewBiz.selectBedviewFileList(paramMap);
//   } catch (Exception e) {
//       e.printStackTrace();
//   }
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
		<link href="${contextPath}/common/css/bedview.css" rel="stylesheet">
		<script src="${contextPath}/common/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="dist/jR3DCarousel.min.js"></script>

		<script type="text/javascript">

$(document).ready(function(){
	var slideImages = [ {src: 'img/jj-01.png'},
	              		{src: 'img/jj-00.png'},
	              		{src: 'img/jj-02.png'},
	              		{src: 'img/jj-03.png'},
					  ];
	//var jR3DCarousel;
	
	jR3DCarousel = $('.jR3DCarouselGallery').jR3DCarousel({
		width: 639.27, 		/* largest allowed width */
		height: 790, 		/* largest allowed height */
		slides: slideImages /* array of images source */
	});
	
	var carouselCustomeTemplateProps =  {
	 		  width: 639.27, 				/* largest allowed width */
			  height: 790, 				/* largest allowed height */
			  slideLayout : 'fill',     /* "contain" (fit according to aspect ratio), "fill" (stretches object to fill) and "cover" (overflows box but maintains ratio) */
			  animation: 'slide3D', 	/* slide | scroll | fade | zoomInSlide | zoomInScroll */
			  animationCurve: 'ease',
			  animationDuration: 1900,
			  animationInterval: 4000,
			  slideClass: 'jR3DCarouselCustomSlide',
			  autoplay: false,
			  controls: false,			/* control buttons */
			  navigation: ''			/* circles | squares | '' */,
			  perspective: 2200,
			  rotationDirection: 'ltr',
			  onSlideShow: slideShownCallback
				  
		};
	function slideShownCallback($slide){
		console.log("Slide shown: ", $slide.find('img').attr('src'));
	}

	jR3DCarouselCustomeTemplate = $('.jR3DCarouselGalleryCustomeTemplate').jR3DCarousel(carouselCustomeTemplateProps);

  });
</script>
<script>
  
	$(document).ready(function(){
    getNoticeAndMsg();
    getCallList();
    getDocList();
    getMealList();
    $("body").fadeIn(1200);
    getBedviewInfo();
    showClock();
    
    $("div.tv-btn").click(function() {
    	//alert("tv");
    	showTv();
    });
    
		$("div.doctor-btn").click(function() {
			popupOpen("callPop");
		});
		    
		$("div.main-btn").click(function() {
			var index = $(".main-btn").index(this);
			if(index == 0) {
    		moveSubPage(3,"진료센터",1);
    	} else if(index == 1) {
    		popupOpen("mealPop");
    	} else if(index == 2) {
    		//준비중
    	} else if(index == 3) {
    		popupOpen("docPop");
    	} else if(index == 4) {
    		moveSubPage(7,"비보험",1);
    	} else if(index == 5) {
    		moveSubPage(8,"의료진소개",5);
    	} else if(index == 6) {
    		moveSubPage(9,"입퇴원안내",6);
    	} else {
    		moveSubPage(10,"피난정보",7);
    	}
		});
		
		$(".popup-close-btn").click(function( ){
			popupClose();
		});
	});
	
	function showTv() {
	  window.MtvAndroidApp.executeType("iptv");
	};
	
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
	
	function moveSubPage(pid,title,color) {
		location.href="info.jsp?pid="+pid+"&title="+title+"&bgcolor="+color;
	}
	
	function popupOpen(target) {
		$(".popup-box").hide();
		$("#"+target).fadeIn('slow');
		$(".popup-area").fadeIn('slow');
	}
	
	function popupClose() {
		$(".popup-box").fadeOut('slow');
		$(".popup-area").fadeOut('slow');
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
  
  function getCallList() {
	  
		$.ajax({
	      url: "${contextPath}/json/bedview/ajaxRespSelectMenuList.jsp",
	      method: "POST",
	      data:{"pid":'2', "lang":""},
	      dataType: "json",
	      success:function( result ){
        	var html = '';
          var list = result.resultData;
          for(var lp0 = 0 ; lp0 < list.length; lp0++){
        	  html += '<div class= "call-btn bg7" onclick="evClickBedCall(\''+list[lp0].menu_nm+'\')"><img src="img/icon/AI_1.png"><a>'+list[lp0].menu_nm+'</a></div>';
          }
          $("#callList").html(html);
	      },
	      error:function(request,status,error){
	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	    });
  }
  
  function evClickBedCall(content) {
    $.ajax({
      url: "${contextPath}/json/bedview/ajaxRespInsertBedCall.jsp",
      method: "POST",
      data:  {bedview_id:"${sessionScope.SESSION_BEDVIEW_ID}",content:content},
      dataType: "json",
      success:function( data ){
    	  popupClose();
    	  alert("의료진을 호출하였습니다.")
      },
      error:function(request,status,error){
       console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      }
    });
  }
  
  function getDocList() {
	  
			$.ajax({
		      url: "${contextPath}/json/bedview/ajaxRespSelectMenuList.jsp",
		      method: "POST",
		      data:{"pid":'6', "lang":""},
		      dataType: "json",
		      success:function( result ){
		      	var html = '';
		        var list = result.resultData;
		        for(var lp0 = 0 ; lp0 < list.length; lp0++){
		      	  html += '<div class= "cost-btn bg6"><img src="img/icon/AI_1.png"><a>'+list[lp0].menu_nm+'</a><input type="checkbox" class="doc-checkbox" value="'+list[lp0].menu_nm+'"></div>';
		        }
		        $("#docList").html(html);
		        
		        $('.cost-btn').on('click', function(){
				 		   var checkbox = $(this).children('input[type="checkbox"]');
				 		   checkbox.prop('checked', !checkbox.prop('checked'));
				 		});
		      },
		      error:function(request,status,error){
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		      }
		    });
	}
  
  function getMealList() {
	  
		$.ajax({
	      url: "${contextPath}/json/bedview/ajaxRespSelectMealList.jsp",
	      method: "POST",
	      data:{},
	      dataType: "json",
	      success:function( result ){
	      	var html = '<tr>';
	        var list = result.resultData;
	        
	        if(list.length == 0) {
	        	html += "<td colspan='5'>준비중입니다.</td>";
	        }
	        
	        for(var lp0 = 0 ; lp0 < list.length; lp0++){
	        	if(lp0) {
	        		html += '<td class="title">특별식</td>';
	        	} else {
	        		html += '<td class="title">일반식</td>';
	        	}
	      	  html += '<td>'+list[lp0].breakfast+'</td>';
		      	html += '<td>'+list[lp0].lunch+'</td>';
		      	html += '<td>'+list[lp0].dinner+'</td>';
		      	html += '<td>'+list[lp0].snack+'</td>';
	        }
	        html += "</tr>";
	        $("#mealList").html(html);
	      },
	      error:function(request,status,error){
	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	    });
}

	function evClickInsertDoc() {
		
		var arr = [];
		$(".doc-checkbox").each(function() {
			if($(this).is(":checked")) {
				arr.push($(this).val());
			}
		});
		
		if(arr.length == 0) {
			alert("선택된 진단서가 없습니다.");
			return false;
		}
		
	  $.ajax({
	    url: "${contextPath}/json/bedview/ajaxRespInsertBedDoc.jsp",
	    method: "POST",
	    data:  {bedview_id:"${sessionScope.SESSION_BEDVIEW_ID}",content:arr.toString()},  //contents:JSON.stringify(arr)
	    dataType: "json",
	    success:function( data ){
	  	  popupClose();
	  	  $(".doc-checkbox").prop("checked",false);
	  	  alert("재증명발급 신청하였습니다.");
	    },
	    error:function(request,status,error){
	     console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    }
	  });
	}
	
  function getNoticeAndMsg(){
	  
	  $.ajax({
	      url:'${contextPath}/json/bedview/ajaxRespSelectNoticeList.jsp',
	      type:'POST',
	      datatype:'json',
	      success:function(result){
        	var html = '';
          var noticeArr = result.resultData.noticeList;
          for(var lp0 = 0 ; lp0 < noticeArr.length; lp0++){
        	  html += '<li><a href="#">'+noticeArr[lp0].content+'</a></li>';
          }
          $("#noticeList2").html(html);
          
          var banner = $(".banner").find("ul");
		    
					var bannerWidth = banner.children().outerWidth();//이미지의 폭
					var bannerHeight = banner.children().outerHeight(); // 높이
					var length = banner.children().length;//이미지의 갯수
          
          setInterval(function() { rollingStart(banner,bannerWidth,bannerHeight,length); }, 3000);
	      },
	      error:function(request,status,error){
	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       }
	    });
  };
  
  function rollingStart(banner,bannerWidth,bannerHeight,length) {
		
		banner.css("width", bannerWidth * length + "px");
		banner.css("height", bannerHeight + "px");
		//alert(bannerHeight);
		//배너의 좌측 위치를 옮겨 준다.
		banner.animate({top: - bannerHeight + "px"}, 3000, function() { //숫자는 롤링 진행되는 시간이다.
			//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
			$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
			//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
			$(this).find("li:first").remove();
			//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
			$(this).css("top", 0);
			//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
		});
	}
  
//   function getNoticeAndMsg(){
	  
// 	  $.ajax({
// 	      url:'${contextPath}/json/bedview/ajaxRespSelectNoticeList.jsp',
// 	      type:'POST',
// 	      datatype:'json',
// 	      success:function(result){
//         	var html = '<div class="con-box1">Notice</div>';
//           var noticeArr = result.resultData.noticeList;
//           var strt = noticeArr.length - 1;
//           var end = 0;
//           if(noticeArr.length > 5) end = noticeArr.length - 5;
//           for(var lp0 = strt ; lp0 >= end; lp0--){
//         	  html += '<div class="con-box2">'+noticeArr[lp0].title+'</div>';
//         	  if(noticeArr[lp0].updatedAt) html += '<div class="con-box3">'+noticeArr[lp0].updatedAt.substr(0,10)+'</div>';
//           }
//           $("#noticeList").html(html);
// 	      },
// 	      error:function(request,status,error){
// 	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
// 	       }
// 	    });
//   };
  </script>

	</head>		
	
	<body>
	
		<div class="container">
			<div class="top-container">
				<div class="top-left-box">
					<div class="icon-deco"><img src="img/home.png" onclick="location.href='${contextPath}/view/bedview/index.jsp'"></div>
					<a id="timer">am 10:00</a>
				</div>
				<div class="top-right-box"><img src="img/logo.png"></div>
			</div> 			
			
			<div class="mid-container">
				<div class="con-box">
					<div class="mid-contants-box">
						<div class="con-box-con1 bg1">
							<div class="title-box">
								<p>infomation</p>
							</div>							
							<div class="info-box">
								<div class="name-box-container">
									<div class="name-box1">
										<p class="title">병실명</p>
										<p id="ward" class="contants">000호</p>
									</div>
									<div class="name-box1">
										<p class="title">환자명</p>
										<p id="patient_nm" class="contants">000</p>
									</div>								
								
									<div class="con-box">
										<p class="title">오늘의일정 :</p>
										<p class="contants"> - </p>
									</div>
									<div class="con-box">
										<p class="title">입원경과일 :</p>
										<p class="contants"> - </p>
									</div>
								</div>
							</div>	
						</div>
						<div class="con-box-con2">
							<div class="con-box2">		
								<div class="tv-btn con-box bg2">
									<img src="img/icon/new2/03.png">
									<a>TV시청</a>
								</div>
								<div class="doctor-btn con-box bg3">
									<img src="img/icon/new2/04.png">
									<a>의료진호출</a>
								</div>
							</div>	
						</div>
						<div class="con-box-con4 bg6">
							<div class="con-box1"><p>진료시간안내</p></div>
							<div class="con-box2">
								<div class="con-box2-1"><a class="title">고&nbsp;객&nbsp;센&nbsp;터</a> <a class="tel">02 6353 5000</a></div>
								<div class="con-box2-1"><a class="title">평&ensp;&nbsp;&nbsp;&nbsp;&ensp;&nbsp;&nbsp;&nbsp;일</a> <a class="tel">AM 9:30~PM 6:30</a></div>
								<div class="con-box2-1"><a class="title">토&nbsp;&nbsp;&nbsp;요&ensp;&nbsp;일</a> <a class="tel">AM 9:30~PM 6:30</a></div>
								<div class="con-box2-1"><a class="title">점&nbsp;심&nbsp;시&nbsp;간</a> <a class="tel">PM 1:30~PM 2:30</a></div>
								
							</div>
						</div>						
					</div>
				</div>
				<div class="btn-box">
					<div class="btn-box-container">
						<div class="main-btn btn-type2-3 bg1">
							<div><img src="img/icon/new2/02.png">
								 <a href="#">진료과안내</a>
							</div>
						</div>
						<div class="main-btn btn-type2-1 bg2">
							<div><img src="img/icon/new2/03.png">
								 <a href="#">식단안내</a>
							</div>
						</div>
						<div class="main-btn btn-type2-1 bg3">
							<div class="img-box"><img src="img/icon/new2/01.png">
								 <a href="#">보험청구대행</a>
							</div>
							
						</div>
						<div class="main-btn btn-type2-1 bg4">
							<div><img src="img/icon/new2/08.png">
								 <a href="#">재증명발급신청</a>
							</div>
						</div>
						<div class="main-btn btn-type2-1 bg0">
							<div><img src="img/icon/new2/05.png">
								 <a href="#" style="color: #000;">비보험진료안내</a>
							</div>
						</div>
						<div class="btn-type2-2 bg0">
							<div  style="width: 100%; height: 100%; background-image: url('img/mtv-box.png'); background-size: cover; border-radius: 8px;  "></div>
							
						</div>
						<div class="main-btn btn-type2-1 bg5">
							<div><img src="img/icon/new2/04.png">
								 <a>의료진소개</a>
							</div>
						</div>
						<div class="main-btn btn-type2-1 bg6">
							<div><img src="img/icon/new2/07.png">
								 <a>입퇴원안내</a>
							</div>
						</div>
						<div class="main-btn btn-type2-2 bg7">
							<div><img src="img/icon/new2/06.png">
								 <a>피난정보안내</a>
							</div>
							
						</div>	
					</div>
				</div>
				<div class="slide-box">
					<div class="jR3DCarouselGallery"></div>
					<div class="slide-captions">
						<img src="img/r-b-ban.png">
					</div>					
				</div>
				
				<div class="bottom-box">
					<div class="banner notice">
						<ul id="noticeList2" class="rolling">
							<li>
								<a href="#">공지사항 내용 1입니다.</a>
							</li>
							<li>
								<a href="#">공지사항 내용 2입니다.</a>
							</li>
							<li>
								<a href="#">공지사항 내용 3입니다.</a>
							</li>
							<li>
								<a href="#">공지사항 내용 4입니다.</a>
							</li>
							<li>
								<a href="#">공지사항 내용 5입니다.</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="popup-area">
			
			<div id="callPop" class="popup-box">
				<div class="pop-container">		
						<div class= "pop-title bg7">
							<a>의료진 호출</a>
							<img class="popup-close-btn" src="img/icon/AI_x.png">
						</div>
						<div id="callList" class="call-btn-container">
							<div class= "call-btn bg7"><img src="img/icon/AI_1.png"><a>1시트를교환해주세요</a></div>
							<div class= "call-btn bg7"><img src="img/icon/AI_1.png"><a>2수액을 제거해 주세요</a></div>
							<div class= "call-btn bg7"><img src="img/icon/AI_7.png"><a>3시트를교환해주세요</a></div>
							<div class= "call-btn bg7"><img src="img/icon/AI_2.png"><a>4시트를교환해주세요</a></div>
							<div class= "call-btn bg7"><img src="img/icon/AI_1.png"><a>5시트를교환해주세요</a></div>
							<div class= "call-btn bg7"><img src="img/icon/AI_7.png"><a>6시트를교환해주세요</a></div>
							<div class= "call-btn bg7"><img src="img/icon/AI_1.png"><a>7시트를교환해주세요</a></div>
						</div>
						<div class="warning-noti">
							<div class="title bg6"><a>알림</a></div>
							<div class="con"><a>순서대로 처리하여 드리니 잠시만 기다려주세요. <a></div>
						</div>
				</div>
			</div>
			
			<div id="costPop" class="popup-box">
				<div class="pop-container bg5">			
						<div class= "pop-title">
							<a>진료비내역</a>
							<img class="popup-close-btn" src="img/icon/AI_x.png">
						</div>
						<table calss="pop-table" style="margin: 35px auto;">
							<thead class="bg7">
								<tr>
									<td>보험진료비</td>
									<td>자기부담금</td>
									<td>비보험진료</td>
									<td>총진료비</td>
									<td>결제비용</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>125,000원</td>
									<td>72,000원</td>
									<td>289,200원</td>
									<td>486,200원</td>
									<td>361,200원</td>
								</tr>
							</tbody>
						</table>
						<div class="warning-noti">
							<div class="title bg6"><a>알림</a></div>
							<div class="con"><a>위 진료금액은 참고용도 이며 향후 원무과 정산시 차이가 날수 있음을 알려드립니다.<a></div>
						</div>
				</div>
			</div>
			
			<div id="docPop" class="popup-box">
				<div class="pop-container">
					<div class= "pop-title bg1">
						<a>재증명 신청</a>
						<img class="popup-close-btn" src="img/icon/AI_x.png">
					</div>
					<div id="docList" class="cost-btn-container">
						<div class= "cost-btn bg6"><img src="img/icon/AI_1.png"><a>진단서1</a><input type="checkbox" class="doc-checkbox"></div>
						<div class= "cost-btn bg6"><img src="img/icon/AI_2.png"><a>진단서2</a><input type="checkbox" class="doc-checkbox"></div>
						<div class= "cost-btn bg6"><img src="img/icon/AI_2.png"><a>진단서3</a><input type="checkbox" class="doc-checkbox"></div>
						<div class= "cost-btn bg6"><img src="img/icon/AI_2.png"><a>진단서4</a><input type="checkbox" class="doc-checkbox"></div>
						<div class= "cost-btn bg6"><img src="img/icon/AI_1.png"><a>진단서5</a><input type="checkbox" class="doc-checkbox"></div>
						<div class= "cost-btn bg6"><img src="img/icon/AI_2.png"><a>진단서6</a><input type="checkbox" class="doc-checkbox"></div>
						<div class= "cost-btn bg6"><img src="img/icon/AI_1.png"><a>진단서7</a><input type="checkbox" class="doc-checkbox"></div>				
					</div>
					<div class="btn-final-container bg7">
						<div class="btn-sucess" onclick="evClickInsertDoc()">
							<h1>신청완료</h1>
						</div>					
					</div>
					<div class="warning-noti">
						<div class="title bg6"><a>알림</a></div>
						<div class="con"><a>각종서류 발급시 발급수수료가 발생할수 있습니다.<a></div>
					</div>
				</div>
			</div>
			
			<div id="mealPop" class="popup-box">
				<div class="pop-container">			
					<div class= "pop-title bg6">
						<a>금일 입원식단안내</a>
						<img class="popup-close-btn" src="img/icon/AI_x.png">
					</div>
					<table calss="pop-table" style="margin: 35px auto;">
						<thead class="bg6">
							<tr>
								<td class="title">항목</td>
								<td>아침</td>
								<td>점심</td>
								<td>저녁</td>
								<td>간식</td>
							</tr>
						</thead>
						<tbody id="mealList">
							<tr>
								<td class="title">일반식</td>
								<td>밥,밥밥,밥밥,밥밥,밥</td>
								<td>밥,밥밥,밥밥,밥밥,밥</td>
								<td>밥,밥밥,밥밥,밥밥,밥</td>
								<td>간식간식간식간식</td>
							</tr>
						</tbody>
					</table>
					<div class="warning-noti">
						<div class="title bg6"><a>알림</a></div>
						<div class="con"><a>불가피한 사정으로 식단이 타메뉴로 대체 될수도 있습니다.<a></div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>