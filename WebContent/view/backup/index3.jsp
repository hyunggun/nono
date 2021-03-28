<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
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
    
    <!-- Google awesome -->
    <link rel="stylesheet" href="${contextPath}/common/css/font-awesome.min.css">
    <link rel="stylesheet" href="${contextPath}/common/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/common/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="${contextPath}/common/css/main.css">
    
    <script src="${contextPath}/common/js/jquery-3.3.1.min.js"></script>
    <script src="${contextPath}/common/js/bootstrap.min.js"></script>
    
<style>
</style>
    <!-- plugin -->
    <!-- marquee -->
    <script src="${contextPath}/common/js/marquee/gistfile1.js"></script>
    <!-- slide -->
    <script type="text/javascript" src="${contextPath}/common/js/jssor.slider.min.js"></script>
    <script src="${contextPath}/common/js/bedview.js"></script>
    
    <style>
    .notice, .modal-info-content, .home-btn,.jssorb032 .iav .b, .btn-basic { background-color: ${sessionScope.SESSION_THEME_COLOR}; fill: ${sessionScope.SESSION_THEME_COLOR}; stroke:${sessionScope.SESSION_THEME_COLOR};}
    .font-notice { color: ${sessionScope.SESSION_THEME_COLOR};}
    .btn-basic .title{ color: ${sessionScope.SESSION_FONT_COLOR}}
    #modal-content img {width:100%;}
    </style>
  <script>
  var noticeList = []; 
  var msgList = [];
  
  $(function(){
    var windowH = $(window).height();
    $("#top-bar").height(windowH/9);
    jssor_1_slider_init();
    showDateTime();
    getNoticeAndMsg();
    $("body").fadeIn(1200);
    var noticeH = $(".notice").outerHeight();
    var topbarH = $("#top-bar").outerHeight();
    var paddingTop = ( topbarH - $(".language img").height() ) / 2;
    $(".logo img").height(topbarH/10 * 7);
    $(".main-div").outerHeight( windowH - topbarH - noticeH);
    $(".language").css("padding-top", paddingTop);
    
    $(".home-btn").css("padding-top", paddingTop);
    
    $(".home-btn").click(function(){
    	selectMenuList(0);
    });
    selectMenuList(0);
  });
  
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
            html = "<span class='font-notice'>[전체공지]</span> <span style='margin-top:9px;color:#545454;margin-right:10%'>"+noticeArr[lp0].content+"</span>"
            $("#marquee_notice").append(html);
          }
		  		html = "";
          for(var lp1 = 0 ; lp1 < msgArr.length; lp1++){
						html = "<span class='font-notice'>[개인공지]</span><span style='margin-top:9px;color:#545454;margin-right:10%'>"+msgArr[lp1].content+"</span>"
						$("#marquee_notice").append(html);
          }
	      },
	      error:function(request,status,error){
	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       }
	    });
	    setTimeout(getNoticeAndMsg, 1000 * 60 * 10);
  };
  
  function evClickMenu( obj, menuId ){
	  $("#modal-content").empty();
    var content = $(obj).find(".title").text();
    $("#modal-title").text(content);
      
    $.ajax({
      url:'${contextPath}/json/bedview/ajaxRespSelectContentInfo.jsp',
      type:'POST',
      datatype:'json',
      data:{menu_id:menuId},
      success:function(result){
        var resultCode =result.resultCode;
        var resultData = result.resultData;
        if( resultCode == 'success'){
          var html = '<p class="menu-content-p">'+resultData.content+'</p>';
          $("#modal-content").append(html);
        }else{
          var html = '<p class="text-center" style="margin-top:25%;"><h3>준비중입니다.</h3></p>';
          $("#modal-content").append(html);
        }
        $(".modal-info").modal();
      }
    });
  };
  
  function evClickBedCall(menu_id){
    $.ajax({
      url: "${contextPath}/json/bedview/ajaxRespInsertBedCall.jsp",
      method: "POST",
      dataType: "json",
      data:  {bedview_id:"${sessionScope.SESSION_BEDVIEW_ID}",content_id:menu_id},
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
  
  function selectMenuList2(pid) {
	  if(pid == null || pid == "") {
		  pid = 0;
	  }
	  if(pid > 0){
		  $(".home-btn").show();
	  } else {
		  $(".home-btn").hide();
	  }
	  $.ajax({
      url: "${contextPath}/json/bedview/ajaxRespSelectMenuList.jsp",
      method: "POST",
      dataType: "json",
      data:{"pid":pid, "lang":"${paramMap.lang}"},
      success:function( result ){
       if(result.resultCode) {
    	   var list = result.resultData;
    	   console.log(list);
    	   var temp ="";
    	   var listLg = list.length;
				 var listTemp = [];
    	   for(var lp=0; lp<listLg; lp++) {
    		   if(listLg < 7) {
    			   if(lp % 2 == 0) {
    				   if(lp == 0) {
    	    			  temp +='<div class="col-md-12" style="height:49%; margin-bottom:0.5%;">';
    				   } else {
    	    			  temp +='<div class="col-md-12" style="height:49%; margin-top:0.5%;">';
    				   }
    			   }
    			   
    			   if(list[lp].child_use_fg == "Y") {
        			   temp +='<div class="col-md-6 text-center btn-basic" style="padding-top:85px;" onClick="selectMenuList('+list[lp].menu_id+');">';
    			   } else {
    				     if(list[lp].type == 1) {
    				    	 temp +='<div class="col-md-6 text-center btn-basic" style="padding-top:85px;" onClick="evClickBedCall('+list[lp].menu_id+')">';
    				     } else if(list[lp].type == 2) {
    				    	 temp +='<div class="col-md-6 text-center btn-basic" style="padding-top:85px;" onClick="evClickDiet()">';
    				     } else if(list[lp].type == 3) {
    				    	 temp +='<div class="col-md-6 text-center btn-basic" style="padding-top:85px;" onClick="evClickDiet()">';
    				     } else {
    				    	 temp +='<div class="col-md-6 text-center btn-basic" style="padding-top:85px;" onClick="evClickMenu(this, '+list[lp].menu_id+')">';
    				     }
    			   }
    			   if(list[lp].icon_url != null) {
        			 temp +='<img src="'+list[lp].icon_url+'"/>';
    			   }
    			   var menu_nm = list[lp].menu_nm;
    			   if(!menu_nm) menu_nm = "";
    			   temp +='<div class="title">'+menu_nm+'</div></div>';
    			   if(lp % 2 == 1 || listLg == lp+1) {
     			   	temp +='</div>';
     			   }
    			   
    		   } else if(listLg < 7) {
    			   
    			   if(lp % 3 == 0) {
    				   if(lp == 0) {
     	    			  temp +='<div class="col-md-12" style="height:49%; margin-bottom:0.5%;">';
     				   } else {
     	    			  temp +='<div class="col-md-12" style="height:49%; margin-top:0.5%;">';
     				   }
    			   }
    			   if(list[lp].child_use_fg == "Y") {
        			   temp +='<div class="col-md-4 text-center btn-basic" style="padding-top:80px;" onClick="selectMenuList('+list[lp].menu_id+');">';
    			   } else {
    				     if(list[lp].type == 2){
    				    	 temp +='<div class="col-md-4 text-center btn-basic" style="padding-top:80px;" onClick="evClickBedCall('+list[lp].menu_id+')">';
    				     } else if(list[lp].type == 3) {
    				    	 temp +='<div class="col-md-4 text-center btn-basic" style="padding-top:80px;" onClick="evClickDiet()">';
    				     } else {
    				    	 temp +='<div class="col-md-4 text-center btn-basic" style="padding-top:80px;" onClick="evClickMenu(this, '+list[lp].menu_id+')">';
    				     }
    			   }
    			   if(list[lp].icon_url != null) {
        			 temp +='<img src="'+list[lp].icon_url+'"/>';
    			   }
    			   var menu_nm = list[lp].menu_nm;
    			   if(!menu_nm) menu_nm = "";
    			   temp +='<div class="title">'+menu_nm+'</div></div>';
    			   if(lp % 3 == 2 || listLg == lp+1) {
     			   	temp +='</div>';
     			   }
    			   
    		   } else {
    			   
    			   if(lp % 3 == 0) {
    				   if(lp == 0) {
    	    		   temp +='<div class="col-md-12" style="height:32%; margin-bottom:0.5%;">';
    				   } else if(lp == 3) {
    					   temp +='<div class="col-md-12" style="height:32%; margin-top:0.5%; margin-bottom:0.5%;">';
    				   } else {
    					   temp +='<div class="col-md-12" style="height:32%; margin-top:0.5%;">';
    				   }
    			   }
    			   if(list[lp].child_use_fg == "Y") {
        			   temp +='<div class="col-md-4 text-center btn-basic" style="padding-top:40px;" onClick="selectMenuList('+list[lp].menu_id+');">';
    			   } else {
    				     if(list[lp].type == 2){
    				    	 temp +='<div class="col-md-4 text-center btn-basic" style="padding-top:40px;" onClick="evClickBedCall('+list[lp].menu_id+')">';
    				     } else if(list[lp].type == 3) {
    				    	 temp +='<div class="col-md-4 text-center btn-basic" style="padding-top:40px;" onClick="evClickDiet()">';
    				     } else {
    				    	 temp +='<div class="col-md-4 text-center btn-basic" style="padding-top:40px;" onClick="evClickMenu(this, '+list[lp].menu_id+')">';
    				     }
    			   }
    			   if(list[lp].icon_url != null) {
        			 temp +='<img src="'+list[lp].icon_url+'"/>';
    			   }
    			   var menu_nm = list[lp].menu_nm;
    			   if(!menu_nm) menu_nm = "";
    			   temp +='<div class="title">'+menu_nm+'</div></div>';
    			   if(lp % 3 == 2 || listLg == lp+1) {
     			   	temp +='</div>';
     			   }
    			   
    		   }
    		   if(lp == 8) break;
    	   }
    	   console.log(temp);
    	   jQuery("#menu-div").html(temp);
       } else if(result.resultCode){
    	   jQuery("#menu-div").html("<div class='col-md-12' style='height:100%;'><div class='col-md-12 btn-basic' style='font-size:2vw; color:white;'>메뉴가 없습니다.</div></div>");
       }
      }
    });
  };
  
  function selectMenuList(pid) {
	  if(pid == null || pid == "") {
		  pid = 0;
	  }
	  if(pid > 0){
		  $(".home-btn").show();
	  } else {
		  $(".home-btn").hide();
	  }
	  $.ajax({
      url: "${contextPath}/json/bedview/ajaxRespSelectMenuList.jsp",
      method: "POST",
      dataType: "json",
      data:{"pid":pid, "lang":"${paramMap.lang}"},
      success:function( result ){
       if(result.resultCode) {
    	   var list = result.resultData;
    	   console.log(list);
    	   if(list.length > 8) list = list.slice(0,8);
				 var menuDivs = [];
    	   for(var lp=0; lp<list.length; lp++) {
    		   var temp = "";
    		   
    		   if(list[lp].child_use_fg == "Y") {
	   			   temp ='<div class="text-center btn-basic" onClick="selectMenuList('+list[lp].menu_id+');">';
				   } else {
					   if(list[lp].menu_type == 1) {
				    	 temp ='<div class="col-md-6 text-center btn-basic" onClick="evClickBedCall('+list[lp].menu_id+')">';
				     } else if(list[lp].menu_type == 2) {
				    	 temp ='<div class="text-center btn-basic" onClick="evClickDiet()">';
				     } else if(list[lp].menu_type == 3) {
				    	 temp ='<div class="col-md-6 text-center btn-basic" onClick="showTv()">';
				     } else {
				    	 temp ='<div class="text-center btn-basic" onClick="evClickMenu(this, '+list[lp].menu_id+')">';
				     }
				   }
    		   
    		   if(list[lp].icon_url != null) {
      			 temp +='<img src="'+list[lp].icon_url+'"/>';
  			   }
    		   
    		   var menu_nm = list[lp].menu_nm;
			   	 if(!menu_nm) menu_nm = "";
			   	 temp +='<div class="title">'+menu_nm+'</div></div>';
    		   
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
   				   menuList += '<div class="col-md-12 menu-row">';
   			   }
   			   
   			   menuList += menuDivs[lp0];
   			   
   			   if(closeArr.indexOf(lp0) > -1 || menuDivs.length == lp0+1) {
   				   menuList +='</div>';
   			   }
   			   
   		   }
   		   
    	   jQuery("#menu-div").html(menuList);
    	   var classTemp = "col-md-4"
    	   if(menuDivs.length > 6) {
    		   classTemp = "col-md-4"
    	   }
    	   
    	   jQuery(".btn-basic").each(function() {
    		   if(!jQuery(this).hasClass("col-md-6")) {
    			   jQuery(this).addClass(classTemp);
    		   }
    	   });
    	   
       } else if(result.resultCode){
    	   jQuery("#menu-div").html("<div class='col-md-12' style='height:100%;'><div class='col-md-12 btn-basic' style='font-size:2vw; color:white;'>메뉴가 없습니다.</div></div>");
       }
      }
    });
  };
  </script>
</head>
<body>
<form name="mainForm" id="mainForm" method="post" action="${contextPath}/index.jsp">
  <input type="hidden" name="pid" id="pid" value="${paramMap.pid}"/>
  <input type="hidden" name="lang" id="lang" value="${paramMap.lang}"/>
</form>
<div class="col-xs-12 container">
  <div class="col-xs-12 top-bar" id="top-bar">
    <div class="logo text-center">
<c:if test="${not empty sessionScope.SESSION_MOBILE_LOGO_URL}">
      <img src="${sessionScope.SESSION_MOBILE_LOGO_URL}" style="width:auto; max-width:100%;" />
</c:if>
<c:if test="${empty sessionScope.SESSION_MOBILE_LOGO_URL}">
      <img src="http://files.treatboard.com/logo/15064010730670.png" style="width:auto; max-width:100%;">
</c:if>
    </div>
    <div id="dateTime"></div>
    <div class="language">
      <img src="${contextPath}/common/img/nation_korea.png" onClick="location.href='${contextPath}/view/bedview/index.jsp'"/>
      <img src="${contextPath}/common/img/nation_america.png" onClick="location.href='${contextPath}/view/bedview/index.jsp?lang=eng'"/>
      <img src="${contextPath}/common/img/nation_china.png" onClick="location.href='${contextPath}/view/bedview/index.jsp?lang=chi'"/>
      <img src="${contextPath}/common/img/nation_japan.png" onClick="location.href='${contextPath}/view/bedview/index.jsp?lang=jap'"/>
      <img src="${contextPath}/common/img/nation_rusia.png" onClick="location.href='${contextPath}/view/bedview/index.jsp?lang=rus'"/>
    </div>
    <div class="text-center home-btn">
      <img src="${contextPath}/common/img/home.png">
    </div>
  </div>
  <div class="col-xs-12 main-div" id="main-div">
    <div class="col-xs-3 left-bar" id="left-bar" style="height: 100%;">
      <!-- 슬라이드 -->
      <div class="row" style="height:90%">
        
        <div id="jssor_1" style="position:relative;margin:0 auto;top:0px;left:0px;width:768px;height:1160px;overflow:hidden;visibility:hidden;">
            <!-- Loading Screen -->
            <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
<!--                 <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="img/spin.svg" /> -->
            </div>
            <div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:768px;height:1160px;overflow:hidden;">
<c:forEach var="data" items="${imgList}" varStatus="status"> 
                <div>
                    <img data-u="image" src="${data.file_url}" />
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
      
<!--       <div class="row" style="height:20%" >   -->
<%--         <div class="banner" style="background-image:url(${contextPath}/common/img/banner01.png)" onclick="showTv()"></div> --%>
<%--         <div class="banner" style="background-image:url(${contextPath}/common/img/banner02.png)" onclick="openInternet()"></div> --%>
<!--       </div> -->
    </div>

    <div class="col-xs-9 menu-div" id="menu-div" style="height: 100%;">
    </div>
  </div>
</div>
  <div class="col-xs-12 notice">
    <div class="sentence">
      <div class="text-center" style="width:9%; display: inline-block;">
        <span>공지사항</span>
      </div>
      <div style="width:90%;display: inline-block;background-color:#fff;">
        <marquee behavior="scroll" scrollamount="2" scrolldelay="1"  direction="left" width="100%">
          <div id="marquee_notice"></div>
        </marquee>
      </div>
    </div>
  </div>
  <div class="modal modal-info fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-info-dialog modal-sm">
      <div class="modal-content modal-info-content text-center">
        <div id="modal-header">
          <span id="modal-title"></span>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div id="modal-content"></div>
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