<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="adminPath" value="${contextPath}/admin" />
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
    <title>404 page not found</title>
    <link rel="stylesheet" type="text/css" href="${themePath}/assets/lib/perfect-scrollbar/css/perfect-scrollbar.min.css"/>
    <link rel="stylesheet" type="text/css" href="${themePath}/assets/lib/material-design-icons/css/material-design-iconic-font.min.css"/><!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="${themePath}/assets/css/style.css" type="text/css"/>
  </head>

  <body class="be-splash-screen">
    <div class="be-wrapper be-error be-error-404">
      <div class="be-content">
        <div class="main-content container-fluid">
          <div class="error-container">
            <div class="error-number">404</div>
            <div class="error-description">해당 페이지 없음</div>
            <div class="error-goback-text">(경로를 다시 확인해 주세요.)</div>
            <div class="error-goback-button"><a href="${adminPath}/index.jsp" class="btn btn-xl btn-primary">홈으로</a></div>
            <div class="footer">&copy; 2018 Makros</div>
          </div>
        </div>
      </div>
    </div>
    <script src="${themePath}/assets/lib/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/perfect-scrollbar/js/perfect-scrollbar.jquery.min.js" type="text/javascript"></script>
    <script src="${themePath}/assets/js/main.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript">
      $(document).ready(function(){
      	//initialize the javascript
      	App.init();
      });
      
    </script>
  </body>
</html>