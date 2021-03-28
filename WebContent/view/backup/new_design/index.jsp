<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.MenuBiz"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<%
	if( session.getAttribute("SESSION_HOSPITAL_ID") == null ){
    response.sendRedirect("login.jsp");
  }

  RequestUtils util = new RequestUtils();
  HashMap paramMap = util.makeParamMap(request);
  HashMap resultMap = null;
  MenuBiz menuBiz = new MenuBiz();
  try {
	  paramMap.put("pid", 0);
    resultMap = menuBiz.selectMenuPage(paramMap);
  } catch (Exception e) {
      e.printStackTrace();
  }
%>
<c:set var="resultMap" value="<%=resultMap%>" />
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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/new_design/css/main.css">
  	<link rel="stylesheet" type="text/css" href="${contextPath}/new_design/css/color.css">
  	<link rel="stylesheet" type="text/css" href="${contextPath}/new_design/css/design.css">
  	<link rel="stylesheet" type="text/css" href="${contextPath}/new_design/scss/btn.css">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<style>
</style>
    <!-- plugin -->
    <!-- marquee -->
    <script src="${contextPath}/common/js/marquee/gistfile1.js"></script>
    <!-- slide -->
    <script type="text/javascript" src="${contextPath}/common/js/jssor.slider.min.js"></script>
    <script src="${contextPath}/common/js/bedview.js"></script>
    
    <style>
    #modal-content img {width:100%;}
    </style>
  <script>
  var noticeList = []; 
  var msgList = [];
  
  $(function(){
    jssor_1_slider_init();
    getNoticeAndMsg();
    $("body").fadeIn(1200);

    selectMenuList(0);
  });
  
  function getNoticeAndMsg(){
	  
	  $.ajax({
	      url:'${contextPath}/json/ajaxRespSelectNoticeList.jsp',
	      type:'POST',
	      data:{bedview_id:"1", type:"B"},
	      datatype:'json',
	      success:function(result){
	        var resultCode = result.resultCode;
	        if( resultCode == 'success'){
	          var html = "";
	          var noticeArr = result.noticeArr;
	          var msgArr = result.msgArr;

					  $("#marquee_notice").html("");

	          for(var lp0 = 0 ; lp0 < noticeArr.length; lp0++){
	            html = "<span class='font-notice'>[전체공지]</span> <span style='color:#fff;margin-right:10%'>"+noticeArr[lp0].content+"</span>"
	            $("#marquee_notice").append(html);
	          }
			  		html = "";
	          for(var lp1 = 0 ; lp1 < msgArr.length; lp1++){
							html = "<span class='font-notice'>[개인공지]</span><span style='color:#fff;margin-right:10%'>"+msgArr[lp1].content+"</span>"
							$("#marquee_notice").append(html);
	          }
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
      url:'${contextPath}/json/ajaxRespSelectContentInfo.jsp',
      type:'POST',
      data:{menu_id:menuId},
      datatype:'json',
      success:function(result){
    	  console.log(result)
        var resultCode = result.resultCode;
        var resultData = result.resultData;
        if( resultCode == 'success'){
          var html = '<p class="menu-content-p">'+resultData.content+'</p>';
          $("#modal-content").html(resultData.content);
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
	      url: "${contextPath}/json/ajaxRespInsertBedCall.jsp",
	      method: "POST",
	      data:  {bedview_id:"1",content_id:menu_id},
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
      url : "${contextPath}/json/ajaxRespSelectMealList.jsp",
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
      url: "${contextPath}/json/ajaxRespSelectMenuList.jsp",
      method: "POST",
      data:{"pid":pid, "lang":""},
      dataType: "json",
      success:function( result ){
       if(result.resultCode == "success") {
    	   var list = result.resultData;
    	   var temp ="";
    	   var listLg = list.length;
    	   for(var lp0=0; lp0<listLg; lp0++) {
    		   if(list[lp0].child_use_fg == "N" && list[lp0].type == 2) {
    			   list.splice(lp0,1);
    			   break;
    		   }
    	   }
    	   for(var lp=0; lp<listLg; lp++) {
    		   if(listLg < 5) {
    			   
    			   if(lp % 2 == 0) {
    				   temp +='<div>';
    			   }
    			   if(lp % 2 == 0) {
    				   temp += 'class="btn_cl brown btn_sm" ';
    			   } else {
    				   temp += 'class="btn_cl brown btn_sm btn_right" ';
    			   }
    			   if(list[lp].child_use_fg == "Y") {
        			   temp +='onClick="selectMenuList('+list[lp].menu_id+');">';
    			   } else {
    				     if(list[lp].type == 2){
    				    	 temp +='onClick="evClickBedCall('+list[lp].menu_id+')">';
    				     } else if(list[lp].type == 3) {
    				    	 temp +='onClick="evClickDiet()">';
    				     } else {
    				    	 temp +='onClick="evClickMenu(this, '+list[lp].menu_id+')">';
    				     }
    			   }
    			   if(list[lp].icon_url != null) {
        			 temp +='<img src="'+list[lp].icon_url+'"/>';
    			   }
    			   var menu_nm = list[lp].menu_nm;
    			   if(!menu_nm) menu_nm = "";
    			   temp +='<p class="title">'+menu_nm+'</p></div>';
    			   if(lp % 2 == 1 || listLg == lp+1) {
     			   	temp +='</div>';
     			   }
    			   
    		   } else {
    			   
    			   if(lp % 3 == 0) {
    				   temp +='<div>';
    			   }
    			   
    			   temp += '<div ';
    			   
    			   if(lp % 3 == 0) {
    				   temp += 'class="btn_cl brown btn_sm" ';
    			   } else {
    				   temp += 'class="btn_cl brown btn_sm btn_right" ';
    			   }
    			   
    			   if(list[lp].child_use_fg == "Y") {
        			   temp +='onClick="selectMenuList('+list[lp].menu_id+');">';
    			   } else {
    				     if(list[lp].type == 2){
    				    	 temp +='onClick="evClickBedCall('+list[lp].menu_id+')">';
    				     } else if(list[lp].type == 3) {
    				    	 temp +='onClick="evClickDiet()">';
    				     } else {
    				    	 temp +='onClick="evClickMenu(this, '+list[lp].menu_id+')">';
    				     }
    			   }
    			   console.log(list[lp]);
    			   if(list[lp].icon_url != null) {
        			 temp +='<img src="'+list[lp].icon_url+'"/>';
    			   }
    			   var menu_nm = list[lp].menu_nm;
    			   if(!menu_nm) menu_nm = "";
    			   temp +='<p class="title">'+menu_nm+'</p></div>';
    			   if(lp % 3 == 2 || listLg == lp+1) {
     			   	temp +='</div>';
     			   }
    			   
    		   }
    		   if(lp == 5) break;
    	   }
    	   jQuery("#menu-div").html(temp);
       } else if(result.resultCode == "none"){
    	   jQuery("#menu-div").html("<div class='col-md-12' style='height:100%;'><div class='col-md-12 btn_cl brown btn_sm'><p>메뉴가 없습니다.</p></div></div>");
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
<div>
	<div id="main_left">
	  <div class="left_top">
			<div><img class="top_logo" src="img/toplogo.png"></div>
			<div class="top_info1 metal" >
				<p class="title_main brown_font" style="margin: 0.35em 0em 0em 2em;">홍 길 동</p>
				<p class="title_sub" style="margin: 1.15em 0em 0em 2em;"> 님의 빠른쾌유를 기원합니다.</p>
			</div>
         
			<div class="top_info2 metal">
				<p style="margin: 1.15em 0em 0em 2em;"class="title_sub">현제 계신곳의 위치는</p>
				<p style="margin: 0.35em 0em 0em 0.4em;"class="title_main brown_font">501호입원실</p>
				<p style="margin: 1.15em 0em 0em 1em;"class="title_sub">입니다.</p>
			</div>
		</div>
		<div class="left_mid">
			<div id="jssor_1" style="position:relative;margin:0 auto;top:0px;left:0px;width:1048px;height:798px;overflow:hidden;visibility:hidden;">
			<!-- Loading Screen -->
				<div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
				<!--                 <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="img/spin.svg" /> -->
				</div>
				<div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:1048px;height:798px;overflow:hidden;">
						<div>
							<img class="contants" data-u="image" src="${contextPath}/new_design/img/info_bg.png" />
						</div>
						<div>
							<img class="contants" data-u="image" src="${contextPath}/new_design/img/info_bg.png" />
						</div>
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
		<div>
			<div class="btn_big btn_cl brown" onClick="evClickBedCall()">
				<img src="${contextPath}/new_design/img/icon/1.png">
				<p>간호사 호출</p>
			</div>
			<div class="btn_cl brown btn_big btn_right" onclick="showTv()">
				<img src="${contextPath}/new_design/img/icon/2.png">
				<p>TV시청</p>
			</div>
		</div>
		<div class="menu-div" id="menu-div">
	
		</div>
	</div>
	 
	<div id="main_bottom" class="Brown_bt_info">
		<div class="bt_title brown_bt_info_title"> <p class="title_main" style="margin:0.3em 0px 0px 60px; color:#fff;">알 림</p></div>
		<div class="bt_con"> 
			<p class="title_main" style="font-size:2.3em; margin:0.6em 15px 0px 45px; color:#fff;">
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
		         <img src="${contextPath}/new_design/img/icon_5.png" data-dismiss="modal" aria-label="Close">
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