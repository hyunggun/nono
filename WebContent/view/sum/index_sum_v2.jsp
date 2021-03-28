<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Calendar"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.common.Constants"%>
<%@page import="com.cofac.treat.ora.biz.non.FileBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.RoomBiz"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<c:set var="sumPath" value="${contextPath}/view/sum" />
<%
  Constants context = new Constants();
			RequestUtils util = new RequestUtils();
			HashMap paramMap = util.makeParamMap(request);
			List fileList = null;
			FileBiz fileBiz = null;
			try {
				fileBiz = new FileBiz();
				paramMap.put("file_position", "O");
				fileList = fileBiz.selectFileList(paramMap);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			RoomBiz roomBiz = null;
			List roomList = null;
			try {
				Calendar cal = Calendar.getInstance();
				int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
				int hour = cal.get(Calendar.HOUR);
				switch (dayOfWeek) {
					case 1 :
						paramMap.put("day", "SU");
						break;
					case 2 :
						paramMap.put("day", "M");
						break;
					case 3 :
						paramMap.put("day", "T");
						break;
					case 4 :
						paramMap.put("day", "W");
						break;
					case 5 :
						paramMap.put("day", "TH");
						break;
					case 6 :
						paramMap.put("day", "F");
						break;
					case 7 :
						paramMap.put("day", "S");
						break;
				}

				if (hour > 12)
					paramMap.put("time", "A");
				else
					paramMap.put("time", "P");
				roomBiz = new RoomBiz();
				roomList = roomBiz.selectRoomDoctorForSum(paramMap);
				String logo_url = context.LOGO_BASIS_URL;
			} catch (Exception ex) {
				ex.printStackTrace();
			}

			String logo_url = context.LOGO_BASIS_URL;
%>
<c:set var="roomList" value="<%=roomList%>" />
<c:set var="logo_url" value="<%=logo_url%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<c:set var="fileList" value="<%=fileList%>" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<title>외래접수현황</title>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css"
  href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
<link rel="stylesheet" type="text/css"
  href="https://cdn.rawgit.com/innks/NanumSquare/master/NanumSquare.min.css">
<script src="${themePath}/assets/lib/jquery/jquery.min.js"
  type="text/javascript"></script>
<style type="text/css">
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
.wrap {
  width: 1920px;
  height: 1080px;
}

.top-container {
  width: 1920px;
  height: 90px;
  padding: 5px 0px;
  display: inline-block;
  border-bottom: 3px solid rgba(29, 58, 90, .5);
  box-shadow: 0px 3px 3px #ccc;
}

.top-logo {
  width: 400px;
  height: 80px;
  float: left;
  padding-left: 0.75%;
}

.top-logo img {
  width: auto;
  max-height: 100%;
}

.top-title {
  width: 700px;
  height: 80px;
  float: left;
  margin: 0px 160px;
  text-align: center;
  display: table;
}

.top-title a {
  font-size: 3.0rem;
  font-weight: bold;
  color: #1D3A5A;
  display: table-cell;
  vertical-align: middle;
}

.top-time {
  width: 500px;
  height: 80px;
  float: left;
  text-align: right;
  display: table;
  padding-right: 1.5%;
}

.top-time a {
  color: #1D3A5A;
  font-size: 1.5rem;
  font-weight: 600;
  line-height: 1.0;
  display: table-cell;
  vertical-align: middle;
}

.mid-container {
  width: 1920px;
  height: 920px;
  display: inline-block;
}

.mid-container>.contants-box-l, .mid-container>.contants-box-r {
  height: 100%;
  float: left;
}

.contants-box-l {
  width: 77%;
}

.contants-box-r {
  width: 23%;
}

.contants-box-l>.mid-card-item {
  width: 24%;
  height: 23%;
  float: left;
  margin: 0.575% 0.5%;
  padding: 0%;
  border-radius: 20px;
  box-shadow: 0px 5px 3px rgba(0, 0, 0, .7);
}

.mid-card-item>.d-title {
  width: 100%;
  height: 28%;
  border-radius: 20px 20px 0px 0px;
  line-height: 1.55;
  text-align: center;
  font-size: 2.4rem;
  letter-spacing: 0.22rem;
  color: #EDEDED;
  font-weight: bolder;
}

tr {
  border-bottom: 2px solid #ddd;
}

tr:last-child {
  border: 0px;
}

td:first-child {
  border-right: 2px solid #ddd;
}

.mid-r-box {
  width: 98%;
  height: 97.5%;
  margin: 2% 0% 0% 1%;
  padding: 1%;
  border: 1px solid #000;
  box-shadow: 2px 3px 5px #1d2129;
  border-radius: 5px 70px 5px 70px;
}

.mid-r-box>.r-title {
  width: 400px;
  height: 8%;
  margin: 2% 2.2%;
  border-bottom: 3px solid #fff;
  text-align: center;
  display: table;
}

.r-title p {
  display: table-cell;
  color: #FFF;
  font-size: 2.25rem;
  font-weight: bold;
  vertical-align: middle;
}

.to-view {
  width: 97.5%;
  height: auto;
  max-height: 90%;
  border: 1px solid #fff;
}

.bottom-container {
  width: 1920px;
  height: 70px;
  display: inline-block;
  float: left;
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

.bg8 {
  background: #74BC2F;
}

.bg9 {
  background: #E55D5C;
}

.bg10 {
  background: #06BFC4;
}

.bgi-1 {
  background-image: url(bg_line_blue02.png);
  background-repeat: repeat;
  background-size: cover;
}

.bg1-1 {
  background: #ccc;
}

.bg-gr-1 {
  background: #B2FEFA; /* fallback for old browsers */
  background: -webkit-linear-gradient(to top, #0ED2F7, #B2FEFA);
  /* Chrome 10-25, Safari 5.1-6 */
  background: linear-gradient(to top, #0ED2F7, #B2FEFA);
  /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
}

.contants-box-l>.mid-card-item {
  width: 24%;
  height: 23%;
  float: left;
  margin: 0.575% 0.5%;
  padding: 0%;
}

#table-r-box {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
  border-radius: 20px;
  overflow: hidden;
  background: #fff;
}

#table-r-box td, #table-r-box th {
  border: 0px solid #FCFCFC;
  padding: 8px 0px;
}

#table-r-box tr:nth-child(even) {
  background-color: #f2f2f2;
}

#table-r-box th {
  font-size: 1.8rem;
  text-align: center;
  color: #000;
}

#table-r-box td {
  font-size: 1.7rem;
  text-align: center;
  color: #1d2129;
}

#table-card {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 98%;
  height: 72%;
  margin-left: 1%;
  border-radius: 1rem;
  overflow: hidden;
}

#table-card td, #table-card th {
  padding: 0px;
}

#table-card tr:first-child {
  background-color: #fff;
}

#table-card tr:nth-child(even) {
  background-color: #f2f2f2;
}

#table-card th {
  font-size: 1.9rem;
  color: #FFF;
  letter-spacing: 0.45rem;
  text-align: center;
  line-height: 0.7;
  border: hidden;
}

#table-card td {
  font-size: 1.8rem;
  font-weight: bold;
  letter-spacing: 0.15rem;
  line-height: 1.0;
  text-align: center;
  color: #1d2129;
}

.noti_title {
  width: 400px;
  height: 70px;
  display: table;
  text-align: left;
  background-image: url(noti_bg.png);
  padding-left: 100px;
  float: left;
}

.noti_title>p {
  font-size: 2rem;
  display: table-cell;
  vertical-align: middle;
  letter-spacing: 2rem;
}

.noti_con {
  width: 1520px;
  height: 70px;
  display: table;
  text-align: left;
  float: left;
}

.noti_con>p {
  font-size: 2rem;
  display: table-cell;
  vertical-align: middle;
  letter-spacing: 0.125rem;
  color: #fff;
}

.noti_con {
  
}
</style>
<script>
  function getRoomList() { //대기인원수 구하기
    jQuery.ajax({
      url : "${sumPath}/select/ajaxWaiting.jsp",
      type : "post",
      cache : false,
      dataType : "json",
      data : {},
      success : function(result) {
        var rData = result.resultData.acceptList;
        var idList = "";
        if (rData != undefined) {
          for (var lp0 = 0; lp0 < rData.length; lp0++) {
            $("#" + rData[lp0].doctor_key).text(rData[lp0].alertCount + " 명");
            if (idList != "")
              idList += ",";
            idList += "#" + rData[lp0].doctor_key;
          }
        }
        console.log(idList)
        $(".amount").not(idList).text("0명");
      },
      error : function(request, status, error) {
      },
      complete : function(jqXHR, textStatus) {
      }
    });
    setTimeout(function() {
      getRoomList();
    }, 5000);
  }

  function getRoomStatus() { //진료실 상태구하기
    jQuery.ajax({
      url : "${sumPath}/select/ajaxRoomStatus.jsp",
      type : "post",
      cache : false,
      dataType : "json",
      data : {},
      success : function(result) {
        var rData = result.resultData.acceptList;
        console.log(rData)
        var idList = "";
        if (rData != undefined) {
          for (var lp0 = 0; lp0 < rData.length; lp0++) {
            $("#status" + rData[lp0].room_id).text(rData[lp0].status_text)
            if (idList != "")
              idList += ",";
            idList += "#" + rData[lp0].room_code;
          }
        }
        console.log(idList)
        $(".amount").not(idList).text("0명");
      },
      error : function(request, status, error) {
      },
      complete : function(jqXHR, textStatus) {
      }
    });
    setTimeout(function() {
      getRoomStatus();
    }, 10000);
  }
  function setTime() {
    var date = new Date();
    var year = date.getFullYear();
    var month = new String(date.getMonth() + 1);
    if (month < 10)
      month = "0" + month;
    var day = new String(date.getDate());
    if (day < 10)
      day = "0" + day;
    var hour = new String(date.getHours());
    if (hour < 10)
      hour = "0" + hour;
    var minutes = new String(date.getMinutes());
    if (minutes < 10)
      minutes = "0" + minutes;
    $(".top-time").html(
        year + "-" + month + "-" + day + "<br/>" + hour + ":" + minutes);
    setTimeout(function() {
      setTime();
    }, 10000);
  }
  $(function() {
    //setTime();
    //getRoomList();
    getRoomStatus();
  });
</script>
</head>


<body>
  <div class="wrap">
    <div class="top-container">
      <div class="top-logo">
        <img src="${logo_url}">
      </div>
      <div class="top-title">
        <a> 울진군 의료원 외래접수현황 </a>
      </div>
      <div class="top-time">
        <a>2019-2-14<br>am 10:00
        </a>
      </div>
    </div>
    <div class="mid-container">
      <div class="contants-box-l">
        <c:forEach var="data" items="${roomList}">
          <div class="mid-card-item bg10">
            <div class="d-title">
              <p>${data.room_nm}</p>
            </div>
            <table id="table-card">
              <tr>
                <td>진료의사</td>
                <td>${data.doctor_nm}${data.position}</td>
              </tr>
              <tr>
                <td>대기인원</td>
                <c:set var="emr_doctor_key"
                  value="${fn:toUpperCase(data.emr_doctor_key)}" />
                <td id="${emr_doctor_key}">25 명</td>
              </tr>
              <tr>
                <th colspan=2 class="status_${data.room_id}"> </th>
              </tr>
            </table>
          </div>
        </c:forEach>
<!--         <div class="mid-card-item bg9"> -->
<!--           <div class="d-title"> -->
<!--             <p>내과2</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>금일휴진</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg10"> -->
<!--           <div class="d-title"> -->
<!--             <p>내과3(신장)</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>오후내시경</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg10"> -->
<!--           <div class="d-title"> -->
<!--             <p>마취통증의학과</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg6"> -->
<!--           <div class="d-title bg6"> -->
<!--             <p>비뇨기과</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg6"> -->
<!--           <div class="d-title"> -->
<!--             <p>산부인과1</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg6"> -->
<!--           <div class="d-title"> -->
<!--             <p>소아청소년과</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg6"> -->
<!--           <div class="d-title"> -->
<!--             <p>신경외과</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg7"> -->
<!--           <div class="d-title"> -->
<!--             <p>안과</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg7"> -->
<!--           <div class="d-title"> -->
<!--             <p>이비인후과</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg7"> -->
<!--           <div class="d-title"> -->
<!--             <p>재활의학과</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg7"> -->
<!--           <div class="d-title"> -->
<!--             <p>정형외과2</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg8"> -->
<!--           <div class="d-title"> -->
<!--             <p>피부과</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg8"> -->
<!--           <div class="d-title"> -->
<!--             <p>비고</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg8"> -->
<!--           <div class="d-title"> -->
<!--             <p>비고</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
<!--         <div class="mid-card-item bg8"> -->
<!--           <div class="d-title"> -->
<!--             <p>비고</p> -->
<!--           </div> -->
<!--           <table id="table-card"> -->
<!--             <tr> -->
<!--               <td>진료의사</td> -->
<!--               <td>박상천 과장</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <td>대기인원</td> -->
<!--               <td>25 명</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--               <th colspan=2>진료중</th> -->
<!--             </tr> -->
<!--           </table> -->
<!--         </div> -->
      </div>



      <div class="contants-box-r">
        <div class="mid-r-box bg1">
          <div class="r-title">
            <p>금일 진료과별 안내</p>
          </div>
          <table id="table-r-box">
            <tr>
              <th style="width: 210px;">진료과</th>
              <th>오전</th>
              <th>오후</th>
            </tr>
            <c:forEach var="data" items="${roomList}">
            <tr>
              <td>${data.room_nm}</td>
              <td>${data.AM}</td>
              <td>${data.PM}</td>
            </tr>
            </c:forEach>
          </table>
        </div>
      </div>
    </div>




    <div class="bottom-container bg6">
      <div class="noti_title">
        <p>알림</p>
      </div>
      <div class="noti_con">
        <p>본 알림은 참고사항이며 현제 상황과 오차가 있을수 있습니다.</p>
      </div>
    </div>
  </div>
  </div>


</body>

</html>
