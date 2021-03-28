<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@page import="com.cofac.treat.ora.biz.non.OproomBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.FileBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<c:set var="oproomPath" value="${contextPath}/json/oproom" />
<%
Constants context = new Constants();
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
HashMap roomMap = null;
OproomBiz oproomBiz = null;
try {
  oproomBiz = new OproomBiz();
    
    paramMap.put("use_fg", "Y");
    roomMap = oproomBiz.selectOproomPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
List fileList = null;
FileBiz fileBiz = null;
try {
  fileBiz = new FileBiz();
  paramMap.put("file_position", "O");
  fileList = fileBiz.selectFileList(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}

String logo_url = context.LOGO_BASIS_URL;
%>
<c:set var="logo_url" value="<%=logo_url%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<c:set var="roomMap" value="<%=roomMap%>" />
<c:set var="fileList" value="<%=fileList%>" />
<head>
<title>수술실현황</title>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css"
  href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
<link rel="stylesheet" type="text/css"
  href="https://cdn.rawgit.com/innks/NanumSquare/master/NanumSquare.min.css">
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="${contextPath}/common/css/swiper.css">
<!-- Swiper JS -->
<script src="${contextPath}/common//js/swiper.js"></script>

<script src="${themePath}/assets/lib/jquery/jquery.min.js"
  type="text/javascript"></script>
<style>
/*//////////////////////////////////////////////////////////////////
    [ RESTYLE TAG ]*/
* {
  margin: 0px;
  padding: 0px;
  box-sizing: border-box;
}

body, html {
  height: 100%;
  font-family: sans-serif;
}

/* ------------------------------------ */
a {
  margin: 0px;
  transition: all 0.4s;
  -webkit-transition: all 0.4s;
  -o-transition: all 0.4s;
  -moz-transition: all 0.4s;
}

a:focus {
  outline: none !important;
}

a:hover {
  text-decoration: none;
}

/* ------------------------------------ */
h1, h2, h3, h4, h5, h6 {
  margin: 0px;
}

p {
  margin: 0px;
}

ul, li {
  margin: 0px;
  list-style-type: none;
}

/* ------------------------------------ */
input {
  display: block;
  outline: none;
  border: none !important;
}

textarea {
  display: block;
  outline: none;
}

textarea:focus, input:focus {
  border-color: transparent !important;
}

/* ------------------------------------ */
button {
  outline: none !important;
  border: none;
  background: transparent;
}

button:hover {
  cursor: pointer;
}

iframe {
  border: none !important;
}

/*//////////////////////////////////////////////////////////////////
          [ Utiliti ]*/
body, p, a {
  margin: 0;
  padding: 0;
}

body {
  width: 1920px;
  height: 1080px;
}

.top-container {
  width: 100%;
  height: 10%;
  background: rgba(255, 255, 255, .93);
  border-bottom: 4px solid #ccc;
  box-shadow: 0px 2px 1px #000;
}

.mid-container {
  width: 100%;
  height: 78%;
  background: rgba(255, 255, 255, .85);
}

.bottom-container {
  width: 100%;
  height: 16%;
  display: inline-block;
}

.top-container>.top-title {
  width: 35%;
  height: 120%;
  margin: 0% 7.5%;
  position: relative;
  float: left;
  text-align: center;
  border-radius: 0px 0px 10px 10px;
  line-height: 1.5;
}

.top-title>a {
  font-size: 4rem;
  font-weight: bold;
  color: rgba(0, 0, 0, 0.6);
  text-shadow: 2px 8px 6px rgba(0, 0, 0, 0.2), 0px -5px 35px
    rgba(255, 255, 255, 0.3);
  letter-spacing: 0.25rem;
}

.top-container>.top-time {
  width: 23.5%;
  height: 90%;
  margin-top: 0.5%;
  margin-right: 1.5%;
  position: relative;
  float: right;
  text-align: right;
  line-height: 1.3;
}

.top-container>.top-logo {
  width: 25%;
  height: 100%;
  position: relative;
  float: left;
  top: 0%;
  left: 0%;
  bottom: 0%;
  right: 0%
}

.top-logo>img {
  width: auto;
  height: 80%;
  margin: 2.5% 4%;
}

.top-container>.top-time>a {
  font-size: 1.5rem;
  font-weight: bold;
  color: rgba(0, 0, 0, 0.6);
  text-transform: uppercase;
  letter-spacing: 0.15rem;
}

.mid-container>.contants-box {
  width: 99%;
  height: 97%;
  margin: 0% 0.5%;
  float: left;
}

table {
  border-spacing: 1px;
  border-collapse: collapse;
  background: white;
  border-radius: 10px;
  overflow: hidden;
  width: 100%;
  margin: 0 auto;
  position: relative;
  box-shadow: 0px 0px 10px #ccc;
}

table * {
  position: relative;
}

table td, table th {
  border-left: 1px dashed #ccc;
}

table td:first-child, table th:first-child {
  border-left: 0px;
}

table thead tr {
  height: 100px;
  background: #36304a;
}

table tbody {
  height: 100%;
  font-weight: bolder;
}

table tbody tr {
  height: 100px;
}

table
 
tbody
 
tr
:last-child
,
{
border-left
:
 
0
px
;

          
}
table td, table th {
  text-align: center;
}

table td.l, table th.l {
  text-align: center;
}

table td.c, table th.c {
  text-align: center;
}

table td.r, table th.r {
  text-align: center;
}

.h-dashboard th {
  font-family: OpenSans-Regular;
  font-size: 2.75rem;
  color: #fff;
  line-height: 1.2;
  font-weight: unset;
}

tbody tr:nth-child(even) {
  background-color: #BFBFBF;
}

tbody tr {
  font-family: OpenSans-Regular;
  font-size: 2.3rem;
  line-height: 1.1;
  font-weight: unset;
}

.bottom-container img {
  width: 100%;
  height: 100%;
}

.bottom-container>.bt-container {
  width: 50%;
  height: 100%;
  float: left;
  background: rgba(255, 255, 255, .95);
  position: relative;
  box-shadow: 0px -2px 10px #ccc;
  justify-content: space-around;
}

.bt-container>.info-title {
  width: 30%;
  height: 20%;
  margin: 0.5% auto;
  line-height: 1.2;
  font-size: 2rem;
  font-weight: bold;
  border-bottom: 2px solid #ccc;
  color: #000;
  letter-spacing: 0.25rem;
  text-shadow: 2px 8px 6px rgba(0, 0, 0, 0.35), 0px -5px 35px
    rgba(0, 0, 0, 0.3);
  text-align: center;
}

.bt-container>.info-box {
  width: 32%;
  height: 70%;
  margin: 0.5% 0% 0% 1%;
  float: left;
  border-radius: 10px;
  text-align: center;
  box-shadow: inset 0px 0px 5px #fff;
}

.info-box>.title {
  width: 70%;
  height: 50%;
  margin: auto;
  color: #fff;
  line-height: 1.8;
  border-bottom: 3px solid #fff;
}

.info-box>.title>p {
  width: auto;
  margin: auto;
  font-size: 2.5rem;
  font-weight: bold;
  margin-left: 7%;
  letter-spacing: 1.5rem;
  text-shadow: 2px 8px 6px rgba(0, 0, 0, 0.2), 0px -5px 35px
    rgba(0, 0, 0, 0.5);
}

.info-box>.con {
  width: 70%;
  height: 40%;
  margin: auto;
  color: #fff;
  line-height: 1.8;
}

.info-box>.con>p {
  font-size: 2.5rem;
  font-weight: bold;
  margin-left: 0%;
  letter-spacing: 0.5rem;
  text-shadow: 2px 8px 6px rgba(0, 0, 0, 0.2), 0px -5px 35px
    rgba(0, 0, 0, 0.3);
}

.bt-container>.call-box {
  width: 98%;
  height: 96%;
  margin: 0.5% 1%;
  float: left;
  border-radius: 5px;
  text-align: center;
  justify-content: center;
  box-shadow: inset 0px 0px 5px #000;
}

.call-box>.title {
  width: 30%;
  height: 20%;
  margin: 0.5% auto;
  line-height: 1.2;
  font-size: 2rem;
  font-weight: bold;
  border-bottom: 1px solid #fff;
  color: #fff;
  letter-spacing: 0.25rem;
  text-shadow: 2px 8px 6px rgba(0, 0, 0, 0.35), 0px -5px 35px
    rgba(0, 0, 0, 0.3);
}

.call-box>.call-con {
  width: 47%;
  height: 20%;
  margin: 0.5% 1.5%;
  float: left;
  line-height: 1.2;
  background: rgba(255, 255, 255, .99);
  border-radius: 5px 20px 20px 5px;
  box-shadow: 0px 3px 2px #ccc;
}

.call-con>.oproom, .call-con>.name, .call-con>.info, .call-con>.end {
  margin-top: 1%;
  padding: 0% 0.5%;
  float: left;
  color: #000;
  font-weight: bold;
  font-size: 1.3rem;
  line-height: 1.6;
}

.call-con>.oproom {
  width: 18%;
  height: auto;
  border-right: 1px solid #ccc;
}

.call-con>.name {
  width: 22%;
  height: auto;
  border-right: 1px solid #ccc;
}

.call-con>.info {
  width: 50%;
  height: auto;
  border-right: 1px solid #ccc;
}

.call-con>.end {
  width: 7%;
  height: auto;
}

.bg0 {
  background: #fff;
  color: #000;
  box-shadow: inset 0 0 1px #000;
}

.bg1 {
  background: #1D3A5A;
}

.bg2 {
  background: #F37E53;
}

.bg3 {
  background: #FAB235;
}

.bg4 {
  background: #B3AF44;
}

.bg5 {
  background: #976EE8;
}

.bg6 {
  background: #4B83C0;
}

.bg7 {
  background: #23B6A6;
}
</style>
<script>
  var roomList = [];
  <c:forEach var="data" items="${roomMap.list}">
  roomList.push("${data.apporoom}");
	</c:forEach>
  function getOpertaionList(){
    jQuery.ajax({
      url : "${oproomPath}/select/ajaxOperation.jsp",
      type : "post",
      cache : false,
      dataType : "json",
      data : {},
      success: function( result ) {
				var rData = result.resultData.acceptList;
        $(".opdata").empty();
        if(rData != undefined){
          var patname = "";
          var diagcdnm = "";
          var appodoct = "";
          var room = "";
          var appoflag = "";
          
          for(var lp1 = 0 ; lp1 < roomList.length ; lp1 ++ ){
            patname = "";
            diagcdnm = "";
            appodoct = "";
            room = "";
            appoflag = "";
          	for(var lp0 = 0 ; lp0 < rData.length ; lp0++){
            		if(roomList[lp1] == rData[lp0].ROOMNUM && rData[lp0].APPOFLAG != "수술완료"){
            		  patname = rData[lp0].PATNAME;
            		  diagcdnm = rData[lp0].DIAGCDNM;
            		  appodoct = rData[lp0].APPODOCT;
            		  room = rData[lp0].ROOM;
            		  appoflag = rData[lp0].APPOFLAG;
                  break;
            		}
            	}
          	$(".patient_nm_"+ roomList[lp1]).html( patname );
            $(".digcdnm_"+ roomList[lp1]).html( diagcdnm );
            $(".appodoct_"+ roomList[lp1]).html( appodoct );
            $(".room_"+ roomList[lp1]).html( room );
            $(".appoflag_"+ roomList[lp1]).html( appoflag );
          }
        }
      },
      error: function(request,status,error) {
      },
      complete: function(jqXHR, textStatus) {
      }
    });
    setTimeout(function(){ getOpertaionList(); }, 5000);
  }
  function setTime(){
    var date = new Date(); 
    var year = date.getFullYear(); 
    var month = new String(date.getMonth()+1); 
    var day = new String(date.getDate()); 
    var hour = new String(date.getHours());
    var minutes = new String(date.getMinutes());
    $("#date").text(year+"-"+month+"-"+day);
    $("#timer").text(hour+":"+minutes);
    setTimeout(function(){ setTime(); }, 10000);
  }
	$(function(){
	  getOpertaionList();
	  setTime();
	  var roomLength = $(".h-dashboard tbody tr").length; // 방의 갯수
	  var contantsHeight = $(".contants-box").height(); //전체의 높이
	  var headerHeight = $(".h-dashboard thead tr").height(); //헤더의 높이
	  var trHeight = (contantsHeight - headerHeight) / roomLength;
	  $(".h-dashboard tbody tr").css("height", trHeight+"px");
	});
  </script>
</head>


<body>
  <div class="top-container">
    <div class="top-logo">
      <img src="${logo_url}">
    </div>
    <div class="top-title">
      <a> 중앙수술실 진행현황 </a>
    </div>
    <div class="top-time">
      <a id="date"></a><br>
      <a id="timer"></a>
    </div>

  </div>
  <div class="mid-container">
    <div class="contants-box">
      <table class="h-dashboard">
        <thead>
          <tr>
            <th>수술실명</th>
            <th>입원실</th>
            <th>환자명</th>
            <th>상태</th>
            <!--              <th>과명</th> -->
            <!--              <th>집도의</th> -->
          </tr>
        </thead>
        <tbody>
          <c:forEach var="data" items="${roomMap.list}">
            <tr class="oproom_${data.apporoom}">
              <td>${data.oproom_nm}</td>
              <td class="opdata room_${data.apporoom}"></td>
              <td class="opdata patient_nm_${data.apporoom}"></td>
              <td class="opdata appoflag_${data.apporoom}"></td>
              <%--                 <td class="opdata digcdnm_${data.apporoom}"></td> --%>
              <%--                 <td class="opdata appodoct_${data.apporoom}"></td> --%>
            </tr>
          </c:forEach>
      </table>
    </div>



    <div class="bottom-container">
      <div class="swiper-container">
        <div class="swiper-wrapper">
          <c:forEach var="data" items="${fileList}" varStatus="status">
            <div class="swiper-slide">
              <img src="${data.file_url}">
            </div>
          </c:forEach>
        </div>
      </div>
    </div>
  </div>
  <script>
     var swiper = "";
     function autoPlay(){
       swiper.slideNext();
       setTimeout(function(){
         autoPlay();
       },6000);
     }
      $(function(){
        swiper = new Swiper('.swiper-container', {
          autoplay: 1000,
          loop: true
      	});
        setTimeout(function(){
          autoPlay();
        },6000);
      });
    </script>

</body>
</html>