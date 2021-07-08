<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/favicon.ico">
    <title>BedView Login</title>
    <link rel="stylesheet" type="text/css" href="${themePath}/assets/lib/perfect-scrollbar/css/perfect-scrollbar.min.css"/>
    <link rel="stylesheet" type="text/css" href="${themePath}/assets/lib/material-design-icons/css/material-design-iconic-font.min.css"/><!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="${themePath}/assets/css/style.css" type="text/css"/>

    <script src="${themePath}/assets/lib/jquery/jquery.min.js" type="text/javascript"></script>
    <style>
      @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
      body { font-family: "Nanum Gothic", sans-serif; background-image: url("${contextPath}/common/img/bg.png"); }
      span { display: inherit;}
      .main-content { text-align: center;}
      .splash-container {max-width: 100%; padding: 50px; display: inline-block;}
      .panel-default { padding: 50px 100px; }
      .descript { font-size: 36px; color: #3b3b3b;}
      .title { font-size: 20px; color:#bdbdbd; font-weight: bold; }
      .panel-body { display: inline-block; }
      form { display: inline-block; }
      .form-group { border: 1px solid #bdc0c7; width:389px; }
      .panel-body .form-group input { width: 300px; height: 46px; border: none; display: inline;}
      .panel-border-color { border-top: none;}
      .login-submit button { width: 391px; height:48px; background-color: #4285f4; color: white;}
      .radio, .checkbox { text-align: left; }
    </style>
    <script>
    function setCookie(cookieName, value, exdays){
      var exdate = new Date();
      exdate.setDate(exdate.getDate() + exdays);
      var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
      document.cookie = cookieName + "=" + cookieValue;
  }
   
  function deleteCookie(cookieName){
      var expireDate = new Date();
      expireDate.setDate(expireDate.getDate() - 1); //어제날짜를 쿠키 소멸날짜로 설정
      document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
  }
   
  function getCookie(cookieName) {
      cookieName = cookieName + '=';
      var cookieData = document.cookie;
      var start = cookieData.indexOf(cookieName);
      var cookieValue = '';
      if(start != -1){
          start += cookieName.length;
          var end = cookieData.indexOf(';', start);
          if(end == -1)end = cookieData.length;
          cookieValue = cookieData.substring(start, end);
      }
      return unescape(cookieValue);
  }
  
  $(document).ready(function() {
      //Id 쿠키 저장
      var userInputId = getCookie("userInputId");
      $("#sign_id").val(userInputId); 
       
      if($("#sign_id").val() != ""){ 
          $("#idSaveCheck").attr("checked", true); 
          $("#pwdSaveCheck").removeAttr("disabled");
      }
       
      $("#idSaveCheck").change(function(){ 
          if($("#idSaveCheck").is(":checked")){                     
                 //id 저장 클릭시 pwd 저장 체크박스 활성화
                 $("#pwdSaveCheck").removeAttr("disabled");
                 $("#pwdSaveCheck").removeClass('no_act');
              var userInputId = $("#sign_id").val();
              setCookie("userInputId", userInputId, 365);
          }else{ 
              deleteCookie("userInputId");
              $("#pwdSaveCheck").attr("checked", false); 
              deleteCookie("userInputPwd");
              $("#pwdSaveCheck").attr("disabled", true);
              $("#pwdSaveCheck").addClass('no_act');
          }
      });
       
    
      $("#sign_id").keyup(function(){ 
          if($("#idSaveCheck").is(":checked")){ 
              var userInputId = $("#sign_id").val();
              setCookie("userInputId", userInputId, 365);
          }
      });
      
      //Pwd 쿠키 저장 
      var userInputPwd = getCookie("userInputPwd");
      $("#patient_key").val(userInputPwd); 
       
      if($("#patient_key").val() != ""){ 
          $("#pwdSaveCheck").attr("checked", true);
          $("#pwdSaveCheck").removeClass('no_act');
      }
       
      $("#pwdSaveCheck").change(function(){ 
          if($("#pwdSaveCheck").is(":checked")){ 
              var userInputPwd = $("#patient_key").val();
              setCookie("userInputPwd", userInputPwd, 365);
          }else{ 
              deleteCookie("userInputPwd");
          }
      });
       
    
      $("#patient_key").keyup(function(){ 
          if($("#pwdSaveCheck").is(":checked")){ 
              var userInputPwd = $("#patient_key").val();
              setCookie("userInputPwd", userInputPwd, 365);
          }
      });
  });


    $(document).ready(function(){
      $("#patient_key").keydown(function (key) {
        if (key.which == 13){
          $("#patient_key").focus();
        }
      });
      $("#patient_key").keydown(function (key) {
        if (key.which == 13){
          $("#cfLoginForm").submit();
        }
      });
    });
    </script>
  </head>

  <body class="be-splash-screen">
    <div class="be-wrapper be-login">
      <div class="be-content">
        <div class="main-content container-fluid">
          <div class="splash-container">
            <img src="${contextPath}/common/img/icon_01.png" style="width:100px;height:100px;position: relative; top:50px;">
            <div class="panel panel-default panel-border-color panel-border-color-primary">
              <div class="panel-heading">
                <span class="descript">베드사이드 TV</span>
                <span class="title">USER LOGIN</span>
              </div>
              <div class="panel-body">
                <form id="cfLoginForm" name="loginForm" action="loginProc.jsp" method="post">
                  <input type="hidden" id="logo_url" name="logo_url" value="${param.logo_url}">
                  <div class="form-group">
                    <div style="display: inline-block;"><img src="${contextPath}/common/img/icon_02.png"></div>
                    <input id="sign_id" name="sign_id" type="text" placeholder="계정" autocomplete="off">
                  </div>
                  <div class="form-group">
                    <div style="display: inline-block;"><img src="${contextPath}/common/img/icon_03.png"></div>
                    <input id="patient_key" name="patient_key" type="text" placeholder="차트번호">
                  </div>
                  <div class="checkbox">
                    <label><input type="checkbox" id="idSaveCheck"/> 아이디 저장</label>
                  </div>
                </form>
                <div class="login-submit">
                  <button data-dismiss="modal" type="submit" onClick='$("#cfLoginForm").submit();'>로그인</button>
                </div>
              </div>
              
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="${themePath}/assets/js/main.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/perfect-scrollbar/js/perfect-scrollbar.jquery.min.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript">
      $(document).ready(function(){
        //initialize the javascript
        App.init();
      });
      
    </script>
  </body>
</html>