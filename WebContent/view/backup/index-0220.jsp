<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="bedviewPath" value="${contextPath}/view/bedview/new_design" />
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
    $("body").fadeIn(1200);
    //getUserInfo();
    
    $("div.tv-btn").click(function() {
    	alert("tv");
    });
    
		$("div.doctor-btn").click(function() {
			popupOpen("callPop");
		});
		    
		$("div.main-btn").click(function() {
			var index = $(".main-btn").index(this);
			if(index == 0) {
    		moveSubPage(3,"병실생활",1);
    	} else if(index == 1) {
    		popupOpen("costPop");
    	} else if(index == 2) {
    		//준비중
    	} else if(index == 3) {
    		popupOpen("docPop");
    	} else if(index == 4) {
    		moveSubPage(7,"비보험",1);
    	} else if(index == 5) {
    		moveSubPage(8,"병원소개",5);
    	} else if(index == 6) {
    		moveSubPage(9,"편의시설",6);
    	} else {
    		moveSubPage(10,"피난정보",7);
    	}
		});
		
		$(".popup-close-btn").click(function( ){
			popupClose();
		});
		
	});
	
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
    			$("#schedule").text(data.patient_nm);
    			$("#history").text(data.patient_nm);
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
        	  html += '<div class= "call-btn" onclick="evClickBedCall(\''+list[lp0].menu_nm+'\')"><img class="call-img" src="img/icon/AI_1.png">'+list[lp0].menu_nm+'</div>';
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
		      	  html += '<div class= "cost-btn"><img class="call-img" src="img/icon/AI_2.png">'+list[lp0].menu_nm+'<input type="checkbox" class="doc-checkbox" value="'+list[lp0].menu_nm+'"></div>';
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
	    data:  {bedview_id:"${sessionScope.SESSION_BEDVIEW_ID}",contents:JSON.stringify(arr)},
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
					<div class="icon-deco"><img src="img/test6.jpg"></div>
					<a>주치의 : 김영태 병원장</a>
				</div>
				<div class="top-right-box"><img src="img/logo.png"></div>
			</div> 			
			
			<div class="mid-container">
				<div class="con-box">
					<div class="mid-contants-box">
						<div class="con-box-con1">
							<div class="title-box">
								<p>infomation</p>
							</div>
							<div class="info-box">
								<div class="name-box-container">
									<div class="name-box1">
										<p class="title">병실명</p>
										<p class="contants">301호</p>
									</div>
									<div class="name-box1">
										<p class="title">환자명</p>
										<p class="contants">윤필선</p>
									</div>								
								
									<div class="con-box">
										<p  class=title>오늘의일정 :</p>
										<p  class=contants> am 10:00 CT검사 예약 있습니다.</p>
									</div>
									<div class="con-box">
										<p  class=title>입원경과일 :</p>
										<p  class=contants> 14일</p>
									</div>
								</div>
							</div>	
						</div>
						<div class="con-box-con2">
							<div class="tv-btn con-box bg2">
								<img src="img/icon/new2/03.png">
								<a>TV시청</a>
							</div>
							<div class="doctor-btn con-box bg3">
								<img src="img/icon/new2/04.png">
								<a>의료진호출</a>
							</div>
						</div>
						<div id="noticeList" class="con-box-con4">
							<div class="con-box1">Notice</div>
							<div class="con-box2">처음 오신분 이용안내</div>
							<div class="con-box3">2019.01.28</div>
							<div class="con-box2">암센터 정보 이용안내</div>
							<div class="con-box3">2019.01.28</div>
							<div class="con-box2">2019년 새롭게 태어납니다.</div>
							<div class="con-box3">2019.01.28</div>
							<div class="con-box2">보건복지부 인증 안내</div>
							<div class="con-box3">2019.01.28</div>
							<div class="con-box2">최신검진 및 진료 시스템</div>
							<div class="con-box3">2019.01.28</div>
						</div>
					</div>
				</div>
				<div class="btn-box">
					<div class="btn-box-container">
						<div class="main-btn btn-type2-3 bg1">
							<div><img src="img/icon/new2/02.png">
								 <a>병실생활안내</a>
							</div>
						</div>
						<div class="main-btn btn-type2-1 bg2">
							<div><img src="img/icon/new2/03.png">
								 <a>진료비내역</a>
							</div>
						</div>
						<div class="main-btn btn-type2-1 bg3">
							<div class="img-box"><img src="img/icon/new2/01.png">
								 <a>보험청구대행</a>
							</div>
							
						</div>
						<div class="main-btn btn-type2-1 bg4">
							<div><img src="img/icon/new2/08.png">
								 <a>재증명발급신청</a>
							</div>
						</div>
						<div class="main-btn btn-type2-1 bg0">
							<div><img src="img/icon/new2/05.png">
								 <a style="color: #000;">비보험진료안내</a>
							</div>
						</div>
						<div class="btn-type2-2 bg0">
							<div style="width: 100%; height: 100%; background-image: url('img/mtv-box.png'); background-size: cover; border-radius: 8px;  "></div>
						</div>
						<div class="main-btn btn-type2-1 bg5">
							<div><img src="img/icon/new2/04.png">
								 <a>병원소개</a>
							</div>
						</div>
						<div class="main-btn btn-type2-1 bg6">
							<div><img src="img/icon/new2/07.png">
								 <a>편의시설</a>
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
						<img src="img/logo.png">
						<a>진주한일병원이 새롭게 오픈 하였습니다.</a>
						<a>텍스트 & 박스이미지 배너가능</a>
						<a>fixed-img</a>
						<a>진주한일병원이 새롭게 오픈 하였습니다.</a>
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
				<div class="pop-container bg6">		
						<div class= "pop-title">의료진 호출<img class="popup-close-btn" src="img/icon/AI_x.png"></div>
						<div id="callList">
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_1.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_1.png">수액을 제거해 주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_7.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_2.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_1.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_7.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_1.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_1.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_1.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_1.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_1.png">시트를교환해주세요</div>
							<div class= "call-btn"><img class="call-img" src="img/icon/AI_1.png">시트를교환해주세요</div>	
						</div>
						<div class="warning-noti">* 알림 * 순서대로 처리하여드리니 잠시만 기다려주세요. 감사합니다.</div>
				</div>
			</div>
			
			<div id="costPop" class="popup-box">
				<div class="pop-container bg6">			
						<div class= "pop-title">진료비내역<img class="popup-close-btn" src="img/icon/AI_x.png"></div>
						<table calss="pop-table" style="margin-top: 35px;">
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
							* 알림 * 위 진료 금액은 참고용이며 향후 정산시 차이가 날수 있음을 알려드립니다.
						</div>
				</div>
			</div>
			
			<div id="docPop" class="popup-box">
				<div class="pop-container bg6">
						<div class= "pop-title">재증명신청<img class="popup-close-btn" src="img/icon/AI_x.png"></div>	
						<div id="docList">
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_1.png">진단서1<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_2.png">진단서2<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_2.png">진단서3<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_2.png">진단서4<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_1.png">진단서5<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_2.png">진단서6<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_1.png">진단서7<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_1.png">진단서7<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_1.png">진단서7<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_1.png">진단서7<input type="checkbox" class="doc-checkbox"></div>
							<div class= "cost-btn"><img class="call-img" src="img/icon/AI_1.png">진단서7<input type="checkbox" class="doc-checkbox"></div>
						</div>
						<div onclick="evClickInsertDoc()" style="display:inline-block; width:300px; height:auto; min-height:40px; float:left; margin:14px 29px 0 29px; line-height:60px; font-weight:bold; color:#fff; font-size: 1.8rem; border-radius: 20px; background: #ccc; border: none; text-align: center; letter-spacing: 0.75rem;">신청전송</div>
				</div>
			</div>
			
		</div>
	</body>
</html>