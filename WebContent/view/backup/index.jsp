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
  List imgList = null;
  BedviewBiz bedviewBiz = new BedviewBiz();
  try {
    imgList = bedviewBiz.selectBedviewFileList(paramMap);
  } catch (Exception e) {
      e.printStackTrace();
  }
%>
<c:set var="imgList" value="<%=imgList%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>mTV</title>
    <!-- this styles only adds some repairs on idevices  -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
    
    <!-- Google awesome -->
    <link rel="stylesheet" href="${contextPath}/common/css/font-awesome.min.css">
    <link rel="stylesheet" href="${contextPath}/common/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/common/css/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="${bedviewPath}/css/main.css">
  	<link rel="stylesheet" type="text/css" href="${bedviewPath}/css/color.css">
  	<link rel="stylesheet" type="text/css" href="${bedviewPath}/css/design.css">
  	<link rel="stylesheet" type="text/css" href="${bedviewPath}/scss/btn.css">
    
    <script src="${contextPath}/common/js/jquery-3.3.1.min.js"></script>
    <script src="${contextPath}/common/js/bootstrap.min.js"></script>
    
    <!-- plugin -->
    <!-- marquee -->
    <script src="${contextPath}/common/js/marquee/gistfile1.js"></script>
    <!-- slide -->
    <script type="text/javascript" src="${contextPath}/common/js/jssor.slider.min.js"></script>
    <script src="${contextPath}/common/js/bedview.js"></script>
    
  <style>
    #modal-content img {width:100%;}
    p.title{ color: ${sessionScope.SESSION_FONT_COLOR} !important;}
    span.notice-content {margin-right:10%; color:${sessionScope.SESSION_FONT_COLOR};}
    .theme_font {color:${sessionScope.SESSION_FONT_COLOR};}
  </style>
  <script>
  var theme_color = "brown";
  if("${sessionScope.SESSION_THEME_COLOR}") theme_color = "${sessionScope.SESSION_THEME_COLOR}";
  var noticeList = []; 
  var msgList = [];
  
  $(function(){
    jssor_1_slider_init();
    getNoticeAndMsg();
    $("body").fadeIn(1200);

    selectMenuList(0);
    getUserInfo();
    
    if(theme_color != "brown") {
    	$(".brown_font").addClass(theme_color+"_font");
      $(".brown_bt_infobg").addClass(theme_color+"_bt_infobg");
      $(".brown_bt_info_title").addClass(theme_color+"_bt_info_title");
      
      $(".brown_font").removeClass("brown_font");
      $(".brown_bt_infobg").removeClass("brown_bt_infobg");
      $(".brown_bt_info_title").removeClass("brown_bt_info_title");
    }
    
  });
  
  function getUserInfo() {
	  $.ajax({
      url:'${contextPath}/json/bedview/ajaxRespSelectBedviewInfo.jsp',
      type:'POST',
      data:{bedview_id:"${sessionScope.SESSION_BEDVIEW_ID}"},
      datatype:'json',
      success:function(result){
    	  if(result.resultCode) {
    			var data = result.resultData;
    			$("#patient_nm").text(data.patient_nm);
    			$("#ward").text(data.ward);
    	  }
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
	      data:{bedview_id:"${sessionScope.SESSION_BEDVIEW_ID}", type:"B"},
	      datatype:'json',
	      success:function(result){
        	var html = "";
          var noticeArr = result.resultData.noticeList;
          var msgArr = result.resultData.msgList;

				  $("#marquee_notice").html("");

          for(var lp0 = 0 ; lp0 < noticeArr.length; lp0++){
            html = "<span class='font-notice'>[전체공지]</span> <span class='notice-content'>"+noticeArr[lp0].content+"</span>"
            $("#marquee_notice").append(html);
          }
		  		html = "";
          for(var lp1 = 0 ; lp1 < msgArr.length; lp1++){
						html = "<span class='font-notice'>[개인공지]</span><span class='notice-content'>"+msgArr[lp1].content+"</span>"
						$("#marquee_notice").append(html);
          }
	      },
	      error:function(request,status,error){
	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       }
	    });
	    setTimeout(getNoticeAndMsg, 1000 * 60 * 10);
  };
  
  function evClickLogo() {
	  $.ajax({
      url:'${contextPath}/json/bedview/ajaxRespSelectThemeColor.jsp',
      type:'POST',
      data:{},
      datatype:'json',
      success:function(result){
    	  if(result.resultCode) {
    		  location.href='${contextPath}/view/bedview/';
    	  }
      }
    });
  }
  
  function evClickMenu( obj, menuId ){
	  $("#modal-content").empty();
    var content = $(obj).find(".title").text();
    $("#modal-title").text(content);
      
    $.ajax({
      url:'${contextPath}/json/bedview/ajaxRespSelectContentInfo.jsp',
      type:'POST',
      data:{menu_id:menuId},
      datatype:'json',
      success:function(result){
        var resultCode = result.resultCode;
        var resultData = result.resultData;
        if( resultCode == 'success'){
          var html = '<p class="menu-content-p">'+resultData.content+'</p>';
          $("#modal-content").html(resultData.content);
        }else{
          var html = '<span class="text-center"><h3 style="margin-top:35%;">준비중입니다.</h3></span>';
          $("#modal-content").append(html);
        }
        $(".modal-info").modal();
      }
    });
  };
  
  function evClickBedCall(content){
    $.ajax({
      url: "${contextPath}/json/bedview/ajaxRespInsertBedCall.jsp",
      method: "POST",
      data:  {bedview_id:"${sessionScope.SESSION_BEDVIEW_ID}",content:content},
      dataType: "json",
      success:function( data ){
        $("#modal-nurse").modal();
        setTimeout(function(){
          $("#modal-nurse").modal("hide");
        },1500);
      }
    });
  }; 
  
  function evClickDiet(){
    $.ajax({
      url : "${contextPath}/json/bedview/ajaxRespSelectMealList.jsp",
      type : "get",
      cache : false,
      dataType : "json",
      success: function( result ) {
        var resultCode = result.resultCode;
        var resultData = result.resultData;
        console.log("test:"+result);
        if(resultCode == "success") {
          $("#modal-content").empty();
          var tableHtml = '<table class="table table-striped table-hover table-fw-widget meal-table">';
             tableHtml += '<thead>';
             tableHtml += '<tr>';
             tableHtml += '<th class="text-center">날짜</th>';
             tableHtml += '<th class="text-center">아침</th>';
             tableHtml += '<th class="text-center">점심</th>';
             tableHtml += '<th class="text-center">저녁</th>';
             tableHtml += '<th class="text-center">간식</th>';
             tableHtml += '</tr>';
             tableHtml += '</thead>';
             tableHtml += '<tbody id="weekMealList">';
             tableHtml += '</tbody>';
             tableHtml += '</table>';
          $("#modal-content").append(tableHtml);
          for( var lp0 = 0 ; lp0 < resultData.length ; lp0++ ){
            var trHtml = '<tr id="menu_'+ (lp0) +'">';
               trHtml += '<td class="text-center">'+ resultData[lp0].date +'</td>';
               trHtml += '<td class="text-center"><pre style="padding:2px">'+ resultData[lp0].breakfast +'</pre></td>';
               trHtml += '<td class="text-center"><pre style="padding:2px">'+ resultData[lp0].lunch +'</pre></td>';
               trHtml += '<td class="text-center"><pre style="padding:2px">'+ resultData[lp0].dinner +'</pre></td>';
               trHtml += '<td class="text-center"><pre style="padding:2px">'+ resultData[lp0].snack +'</pre></td>';
               trHtml += '</tr>';
               $(".meal-table").append(trHtml);
          }
        } else {
          $("#modal-content").append("준비중입니다.");
        }
      },
      error: function(request,status,error) {
      },
      complete: function(jqXHR, textStatus) {
        $(".modal-info").modal();
      }
    });
  };
  
  function selectMenuList(pid) {
	  if(pid == null || pid == "") {
		  pid = 0;
	  }
	  $.ajax({
      url: "${contextPath}/json/bedview/ajaxRespSelectMenuList.jsp",
      method: "POST",
      data:{"pid":pid, "lang":""},
      dataType: "json",
      success:function( result ){
       if(result.resultCode) {
    	   var list = result.resultData;
    	   if(list.length > 8) list = list.slice(0,8);
				 var menuDivs = [];
			   for(var lp=0; lp<list.length; lp++) {
				   var temp = "";
				   
				   if(list[lp].child_use_fg == "Y") {
					   if(list[lp].menu_type <= 1) {
						   temp ='<div class="btn_sm btn_cl '+theme_color+'" onClick="selectMenuList('+list[lp].menu_id+');">';
					   } else if(list[lp].menu_type == 2) {
						   temp ='<div class="btn_big btn_cl '+theme_color+'" onClick="selectMenuList('+list[lp].menu_id+');">';
					   } else {
						   temp ='<div class="btn_big btn_cl '+theme_color+'" onClick="selectMenuList('+list[lp].menu_id+');">';
					   }
				   } else {
					   if(list[lp].menu_type == 0) {
						   temp ='<div class="btn_sm btn_cl '+theme_color+'" onClick="evClickMenu(this, '+list[lp].menu_id+')">';
				     } else if(list[lp].menu_type == 1) {
				    	 temp ='<div class="btn_sm btn_cl '+theme_color+'" onClick="evClickDiet()">';
				     } else if(list[lp].menu_type == 2) {
				    	 temp ='<div class="btn_big btn_cl '+theme_color+'" onClick="evClickBedCall(\''+list[lp].menu_nm+'\')">';
				     } else {
				    	 temp ='<div class="btn_big btn_cl '+theme_color+'" onClick="showTv()">';
				     }
				   }

				   if(list[lp].icon_url != "" && list[lp].icon_url != null) {
					 temp +='<img src="'+list[lp].icon_url+'"/>';
				   }
				   
				   var menu_nm = list[lp].menu_nm;
			   	 if(!menu_nm) menu_nm = "";
			   	 temp +='<p class="title text-center">'+menu_nm+'</p></div>';
				   
				   	menuDivs.push(temp);
			   }
    	   
			   var menuList = "";
    	   var openArr = [2,4];
    	   var closeArr = [1,3];
    	   
    	   if(menuDivs.length > 6) {
    		   openArr = [2,5];
    		   closeArr = [1,4];
    	   }
    	   
   		   for(var lp0=0; lp0<menuDivs.length; lp0++) {
   			   if(openArr.indexOf(lp0) > -1 || lp0 == 0) {
   				   menuList += '<div class="menu-row">';
   			   }
   			   
   			   menuList += menuDivs[lp0];
   			   
   			   if(closeArr.indexOf(lp0) > -1 || menuDivs.length == lp0+1) {
   				   menuList +='</div>';
   			   }
   		   }
			   
    	   jQuery("#menu-div").html(menuList);
    	   
    	   jQuery(".menu-row").each(function(indx) { 
    		   jQuery(this).children("div").each(function(index, item) {
    			   if(index != 0) jQuery(this).addClass("btn_right");
    			   if(menuDivs.length < 7 && indx > 0) jQuery(this).css("margin-top","10px");
    		   });
    	   });
    	   
       } else if(result.resultCode == "none"){
    	   jQuery("#menu-div").html("<div class='col-md-12' style='height:100%;'><div class='col-md-12 btn_cl "+theme_color+" btn_sm'><p>메뉴가 없습니다.</p></div></div>");
       }
      }
    });
  };
  </script>
</head>
<body>
<form name="mainForm" id="mainForm" method="post" action="/index.jsp">
  <input type="hidden" name="pid" id="pid" value="0"/>

</form>
<div style="width:100%; height:100%; margin:0; padding:0;">
	<div id="main_left">
	  <div class="left_top">
			<div>
				<img class="top_logo" src="${sessionScope.SESSION_MOBILE_LOGO_URL}" onclick="evClickLogo()" style="cursor:pointer;"/>
			</div>
			<div class="top_info1 metal" >
				<p id="patient_nm" class="title_main brown_font" style="margin: 0.2em 0em 0em 1.5em;"></p>
				<p class="title_sub" style="margin: 1em 0em 0em 1.5em;"> 님의 빠른쾌유를 기원합니다.</p>
			</div>
         
			<div class="top_info2 metal">
				<p class="title_sub" style="margin: 1em 0em 0em 2.7em;">현제 계신곳의 위치는</p>
				<p id="ward" class="title_main brown_font" style="margin: 0.2em 0em 0em 0.4em;"></p>
				<p class="title_sub" style="margin: 1em 0em 0em 1em;">입니다.</p>
			</div>
		</div>
		<div class="left_mid">
			<div id="jssor_1" style="position:relative;margin:0 auto;top:0px;left:0px;width:1048px;height:798px;overflow:hidden;visibility:hidden;">
			<!-- Loading Screen -->
				<div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
<!-- 				  <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="img/spin.svg" /> -->
				</div>
				<div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:1048px;height:798px;overflow:hidden;">
<!-- 						<div> -->
<%-- 							<img class="contants" data-u="image" src="${bedviewPath}/img/info_bg.png" /> --%>
<!-- 						</div> -->
						<c:forEach var="data" items="${imgList}">
							<div>
								<c:if test="${fn:indexOf(data.file_nm,'mp4') > 0}">
									<video class="contants video" controls style="width:100%;" onplay="jssor_1_slider_stop();" onpause="jssor_1_slider_start();" onended="jssor_1_slider_start();">
										<source src="${data.file_url}" type="video/mp4">
									</video>
								</c:if>
								<c:if test="${fn:indexOf(data.file_nm,'mp4') < 0}">
									<img class="contants" data-u="image" src="${data.file_url}"/>
								</c:if>
							</div>
						</c:forEach>
				</div>
				<!-- Bullet Navigator -->
				<div data-u="navigator" class="jssorb032" style="position:absolute;bottom:12px;right:12px;" data-autocenter="1" data-scale="0.5" data-scale-bottom="0.75">
			    <div data-u="prototype" class="i" style="width:16px;height:16px;">
		        <svg viewbox="0 0 16000 16000" style="position:absolute;top:0;left:0;width:100%;height:100%;">
	            <circle class="b" cx="8000" cy="8000" r="5800"></circle>
            </svg>
          </div>
	      </div>
	    </div>
		</div>
	</div>
  
	<div id="main_right">
		<div class="menu-div" id="menu-div">
	
		</div>
	</div>
	 
	<div id="main_bottom" class="brown_bt_infobg">
		<div class="bt_title brown_bt_info_title"> <p class="title_main theme_font" style="margin:0.1em 0px 0px 45px;">알 림</p></div>
		<div class="bt_con"> 
			<p class="title_main" style="font-size:2.3em; margin:0.27em 15px 0px 45px; color:#fff; min-width:83%;">
				<marquee behavior="scroll" scrollamount="2" scrolldelay="1"  direction="left" width="100%">
					<div id="marquee_notice"></div>
				</marquee>
			</p>
		</div>
	</div>
 </div>
  
  <div class="modal modal-info fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-info-dialog modal-sm">
      <div class="modal-content modal-info-content text-center sub_frame blue_bt_infobg">
        <div id="modal-header">
          <div class="sub_title blue_bt_info_title"> 
		         <p id="modal-title">병원정보_관절치료센터</p>
		         <img src="${bedviewPath}/img/icon_5.png" data-dismiss="modal" aria-label="Close">
			     </div>
        </div>
        <div id="modal-content">
        </div>
      </div>
    </div>
  </div>
  <div class="modal fade bs-example-modal-sm" id="modal-nurse" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content text-center">
      요청이 전송되었습니다.
    </div>
  </div>
</div>
</body>
</html>