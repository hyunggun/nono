<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="/favicon.ico">
<title>로그인</title>
<link rel="stylesheet" href="${contextPath}/common/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
@font-face { font-family:'NanumGothicBold'; src: url('${contextPath}/common/fonts/nanum/NanumGothicBold.woff') format('woff'); }
@font-face { font-family:'NotoSansBold'; src: url('${contextPath}/common/fonts/notosans/NotoSans-Bold.ttf') format('woff'); }
.cf-login-pd0 { padding:0; }
.cf-login-mg10 { margin:10px 0; }
.cf-login-box { background:white; border:1px solid #b0bec5; }
.cf-login-icon { padding:10px 5px; text-align:center; }
.cf-login-input { width:100%; font-size:17px; color:#343434; font-family:NanumGothicBold; padding:13px; border:0; }
.cf-login-btn { background-color:#00bbff; color:#fff; width:100%; padding:10px; border-radius:5px; border:0; margin-top:20px; font-size:22px; font-family:NanumGothic; }
select {  width:100%; -webkit-appearance: none; /* 네이티브 외형 감추기 */ -moz-appearance: none;  appearance: none; 
background: url('${contextPath}/common/img/worker/arrow.png') no-repeat 95% 50%; /* 화살표 모양의 이미지 */ background-color:#e4f4fb; } /* IE 10, 11의 네이티브 화살표 숨기기 */ 
select::-ms-expand { display: none; }
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
		jQuery("#loginForm").submit();
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

<body style="width:100%; height:100%; background:#f1f5f8;">
	<div class="col-xs-12">
		<div class="col-xs-12 text-center" style="margin:80px 0 20px 0;">
    	<img src="${contextPath}/common/img/worker/login-icon01.png" />
    	<div style="font-size:30px; font-family:NanumGothicBold; color:#343434;">실무자 로그인</div>
    	<div style="font-size:16px; color:#bdbdbd; font-family:NotoSansBold;">WORKER LOGIN</div>
		</div>
		<div class="col-xs-12">
			<form id="loginForm" name="loginForm" action="loginProc.jsp" method="post">
				<div class="col-xs-12 cf-login-pd0 cf-login-mg10">
					<select name="view_type" style="font-size:18px; color:#343434; font-family:NanumGothic; width:100%; padding:10px;">
						<option value="single">SINGLE</option>
						<option value="multi">MULTI</option>
					</select>
				</div>
				<div class="col-xs-12 cf-login-pd0 cf-login-mg10 cf-login-box">
					<div class="col-xs-2 cf-login-icon"><img src="${contextPath}/common/img/worker/login-icon02.png"></div>
					<div class="col-xs-10 cf-login-pd0"><input class="cf-login-input" type="text" id="sign_id" name="sign_id" placeholder="계정"></div>
				</div>
				<div class="col-xs-12 cf-login-pd0 cf-login-mg10 cf-login-box">
					<div class="col-xs-2 cf-login-icon"><img src="${contextPath}/common/img/worker/login-icon03.png"></div>
					<div class="col-xs-10 cf-login-pd0"><input class="cf-login-input" type="password" id="password" name="password" placeholder="비밀번호"></div>
				</div>
			</form>
			<button class="cf-login-btn" type="button" onclick="evClickLogin()">실무자 접속</button>
		</div>
	</div>
</body>
</html>