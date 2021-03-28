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
    <link rel="shortcut icon" href="${themePath}/assets/img/logo-fav.png">
    <title>Code-factory Login</title>
    <link rel="stylesheet" type="text/css" href="${themePath}/assets/lib/perfect-scrollbar/css/perfect-scrollbar.min.css"/>
    <link rel="stylesheet" type="text/css" href="${themePath}/assets/lib/material-design-icons/css/material-design-iconic-font.min.css"/><!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="${themePath}/assets/css/style.css" type="text/css"/>

    <script src="${themePath}/assets/lib/jquery/jquery.min.js" type="text/javascript"></script>
    <style>
      @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
      body { font-family: "Nanum Gothic", sans-serif; background-image: url("${contextPath}/common/img/bglogin.png"); }
      span { display: inherit;}
      .main-content { text-align: center;}
      .splash-container {max-width: inherit; padding: 50px; display: inline-block;}
      .panel-default { padding: 50px 100px; }
      .descript { font-size: 36px; color: #3b3b3b;}
      .title { font-size: 20px; color:#bdbdbd; font-weight: bold; }
      .panel-body { display: inline-block; }
      form { display: inline-block; }
      .form-group { border: 1px solid #bdc0c7; width:389px; }
      .panel-body input { width: 300px; height: 46px; border: none; display: inline;}
      .panel-border-color { border-top: none;}
      .login-submit button { width: 391px; height:48px; background-color: #4285f4; color: white;}
    </style>
    <script>
		jQuery(document).ready(function() {
			jQuery("#password").keypress(function(event) {
				if(event.keyCode == "13") {
					evClickLogin();
				}
			});
		});
		function evClickLogin() {
			if(validate()) {
				jQuery("#cfLoginForm").submit();
			}
		}
		
		function validate() {
			if(!jQuery("#sign_id").val()) {
				alert("아이디를 입력해 주세요");
				return false;
			}
			if(!jQuery("#password").val()) {
				alert("비밀번호를 입력해 주세요");
				return false;
			}
			return true;
		}
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
                <span class="descript">진료 관리 시스템</span>
                <span class="title">USER LOGIN</span>
              </div>

              <div class="panel-body">
                <form id="cfLoginForm" name="loginForm" action="loginProc.jsp" method="post">
                  <div class="form-group">
                    <div style="display: inline-block;"><img src="${contextPath}/common/img/icon_02.png"></div>
                    <input id="sign_id" name="sign_id" type="text" placeholder="계정" autocomplete="off" style="padding-left:10px;">
                  </div>
                  <div class="form-group">
                    <div style="display: inline-block;"><img src="${contextPath}/common/img/icon_03.png"></div>
                    <input id="password" name="password" type="password" placeholder="비밀번호" style="padding-left:10px;">
                  </div>
                  <div class="login-submit">
                    <button type="button" onclick="evClickLogin()">로그인</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>