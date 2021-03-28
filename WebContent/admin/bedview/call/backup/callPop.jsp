<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.FloorBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.BedviewBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="bedviewPath" value="${contextPath}/admin/bedview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap resultMap = null;
List list = null;
FloorBiz floorBiz = null;
BedviewBiz bedviewBiz = null;
int index = 0;
try {
	floorBiz = new FloorBiz();
  resultMap = floorBiz.selectFloor(paramMap);
  
  bedviewBiz = new BedviewBiz();
  list = bedviewBiz.selectBedviewList(paramMap);
  
  index = list.size()/2;
  if(index == 0) index = 1;
  
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="leftList" value="<%=list.subList(0, index)%>" />
<c:set var="rightList" value="<%=list.subList(index, list.size())%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
 <head>
   <title> 병상용TV </title>
   <meta charset="utf-8">
   <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
   <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquare/master/NanumSquare.min.css">
	 <link rel="stylesheet" type="text/css" href="css/callPop.css">
	 <script src="${contextPath}/common/js/jquery-3.3.1.min.js"></script>
   <script src="${contextPath}/common/js/bootstrap.min.js"></script>
    
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
          h1,h2,h3,h4,h5,h6 {margin: 0px;}
          
          p {margin: 0px;}
          
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
              body, p, a {margin:0; padding: 0;}
              body{width: 1920px; height: 1080px; background-image: url(img/bigbg-2.jpg); background-size: cover;	background-repeat: no-repeat} 
              .top-container{ width: 100%; height: 7%; background:rgba(255,255,255, .93); border-bottom: 4px solid #ccc; box-shadow: 0px 2px 1px #000;}
              .mid-container{ width: 100%; height: 72.6%; background: rgba(255,255,255, .85); }
              .bottom-container{ width: 100%; height: 20%; display: inline-block; }
              
              .top-container>.top-title{
                width: 30%;
                height: 120%;
                margin: 0% 10%;
                position: relative;
                float: left;
                text-align: center;
                border-radius: 0px 0px 10px 10px;
                line-height: 1.5;
              }
              .top-title>a{
                font-size: 3rem;
                font-weight: bold;
                color: rgba(0,0,0,0.6);
                text-shadow: 2px 8px 6px rgba(0,0,0,0.2), 0px -5px 35px rgba(255,255,255,0.3);
                letter-spacing: 0.25rem;
              }
              .top-container>.top-time{
                width: 23.5%;
                height: 90%;
                margin-top: 0.5%;
                margin-right : 1.5%;
                position: relative;
                float: right;
                text-align: right;
                line-height: 1.3;
                
              }
              .top-container>.top-logo{
                width: 25%;
                height: 100%;
                position: relative;
                float: left;
                top: 0%; left: 0%; bottom: 0%; right: 0%
              }
              .top-logo>img{
                width: auto;
                height: 80%;
                margin: 2.5% 4%;
              }
              .top-container>.top-time>a{
                font-size: 1.5rem;
                font-weight: bold;
                color: rgba(0,0,0,0.6);
                text-transform: uppercase;
                letter-spacing: 0.15rem;
               }
              
              .mid-container>.contants-box{
                width: 49%;
                height: 97%;
                margin: 0% 0.5%;
                float: left;
                background: rgba(255,255,255, .75);
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
          table thead tr {
            height: 60px;
            background: #36304a;
          }
          table tbody tr {
            height: 44px;
            
          }
          table tbody tr:last-child {
            border: 0;
          }
          table tbody tr:last-child {
           
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
          .h-dashboard th{
            font-family: OpenSans-Regular;
            font-size: 1.15rem;
            color: #fff;
            line-height: 1.2;
            font-weight: unset;
          }
          tbody tr:nth-child(even) {
            background-color: #f5f5f5;
          }
          
          tbody tr {
            font-family: OpenSans-Regular;
            font-size: 1.1rem;
            color: #000;
            line-height: 1.1;
            font-weight: unset;
            
          }
          
          tbody tr:hover {
            color: #555555;
            background-color: #f5f5f5;
            cursor: pointer;
          }
          
          .bottom-container>.bt-container{
             width: 50%;
             height: 100%;
             float: left;
             background: rgba(255,255,255, .95);
             position: relative;
             box-shadow: 0px -2px 10px #ccc;
             justify-content: space-around;
          }
          .bt-container>.info-title{
              width: 30%;
              height: 20%;
              margin: 0.5% auto;
              line-height: 1.2;
              font-size: 2rem;
              font-weight: bold;
              border-bottom: 2px solid #ccc;
              color: #000;
              letter-spacing: 0.25rem;
              text-shadow: 2px 8px 6px rgba(0,0,0,0.35), 0px -5px 35px rgba(0,0,0,0.3);
              text-align: center;
          }
          
          .bt-container>.info-box{
              width: 32%;
              height: 70%;
              margin: 0.5% 0% 0% 1%;
              float: left;
              border-radius: 10px;
              text-align: center;
              box-shadow: inset 0px 0px 5px #fff;
          }
          .info-box>.title{
              width: 70%;
              height: 50%;
              margin: auto;
              color: #fff;
              line-height: 1.8;
              border-bottom: 3px solid #fff;
          }  
          .info-box>.title>p{
              width: auto;
              margin: auto;
              font-size: 2.5rem;
              font-weight: bold;
              margin-left: 7%;
              letter-spacing: 1.5rem;
              text-shadow: 2px 8px 6px rgba(0,0,0,0.2), 0px -5px 35px rgba(0,0,0,0.5);
          }
          .info-box>.con{
              width: 70%;
              height: 40%;
              margin: auto;
              color: #fff;
              line-height: 1.8;
          }
          .info-box>.con>p{
              font-size: 2.5rem;
              font-weight: bold;
              margin-left: 0%;
              letter-spacing: 0.5rem;
              text-shadow: 2px 8px 6px rgba(0,0,0,0.2), 0px -5px 35px rgba(0,0,0,0.3);
          }
          .bt-container>.call-box{
              width: 98%;
              height: 96%;
              margin: 0.5% 1%;
              float: left;
              border-radius: 5px;
              text-align: center;
              justify-content: center;
              box-shadow: inset 0px 0px 5px #000;
          }
          .call-box>.title{
              width: 30%;
              height: 20%;
              margin: 0.5% auto;
              line-height: 1.2;
              font-size: 2rem;
              font-weight: bold;
              border-bottom: 1px solid #fff;
              color: #fff;
              letter-spacing: 0.25rem;
              text-shadow: 2px 8px 6px rgba(0,0,0,0.35), 0px -5px 35px rgba(0,0,0,0.3);
              
          }
          .call-box>.call-con{
              width: 47%;
              height: 20%;
              margin: 0.5% 1.5%;
              float: left;
              line-height: 1.2;
              background: rgba(255,255,255, .99);
              border-radius: 5px 20px 20px 5px;
              box-shadow: 0px 3px 2px #ccc;
          }
          .call-con>.room,.call-con>.name,.call-con>.info,.call-con>.end{
              margin-top: 1%;
              padding: 0% 0.5%;
              float: left;
              color: #000;
              font-weight: bold;
              font-size: 1.3rem;
              line-height: 1.6;    
          }
          
          .call-con>.room{
            width: 18%;
            height: auto;
            border-right: 1px solid #ccc;
          }
          .call-con>.name{
            width: 22%;
            height: auto;
            border-right: 1px solid #ccc;
          
          }
          .call-con>.info{
            width: 50%;
            height: auto;
            border-right: 1px solid #ccc;
          }
          .call-con>.end{
            width: 7%;
            height: auto;
          }
          .bg0{background: #fff; color:#000; box-shadow: inset 0 0 1px #000;}
             .bg1{background: #1D3A5A;}
             .bg2{background: #F37E53;}
             .bg3{background: #FAB235;}
             .bg4{background: #B3AF44;}
             .bg5{background: #976EE8;}
             .bg6{background: #4B83C0;}
             .bg7{background: #23B6A6;}
            
  </style>
</head>
  
  
  <body>
   <div class="top-container">
        <div class="top-logo"><img src="img/logo.png"></div>
        <div class="top-title"><a>  제5병동 입원실 현황 </a></div>
        <div class="top-time"><a>2019-2-14<br>am 10:00</a></div>
     
   </div>  
   <div class="mid-container">
     <div class="contants-box">
       <table class="h-dashboard">
         <thead>
           <tr>
             <th>병실</th>
             <th>이름</th>
             <th>성별</th>
             <th>나이</th>
             <th>보험유형</th>
             <th>주치의</th>
             <th>진료과</th>
             <th>입원경과일</th>
             <th>수술일</th>
             <th>수술경과일</th>
             <th>진단명</th>
             <th>기타/오더</th>
           </tr>
         </thead>
         <tbody>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
            <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
          
           
       </table>
     </div>
     <div class="contants-box">
       <table class="h-dashboard">
         <thead>
            <tr>
             <th>병실</th>
             <th>이름</th>
             <th>성별</th>
             <th>나이</th>
             <th>보험유형</th>
             <th>주치의</th>
             <th>진료과</th>
             <th>입원경과일</th>
             <th>수술일</th>
             <th>수술경과일</th>
             <th>진단명</th>
             <th>기타/오더</th>
           </tr>
         </thead>
         <tbody>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
            <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
           <tr>
             <td>501호</td> <td>김ㅇ형</td> <td>fm</td> <td>31</td> <td>의료보험</td> <td>김명의</td> <td>os</td> <td>14</td> <td>19/02/05</td> <td>10</td> <td>asdudfnsa</td><td>금식</td>
           </tr>
         </tbody>
       </table>
     </div>
   </div>
   
   
   <div class="bottom-container">
      <div class="bt-container">
        <div class="info-title">입/퇴원 현황</div>
        <div class="info-box bg5">
        <div class="title"><p> 재원 </p> </div>
        <div class="con"><p> 20명 </p> </div>
       </div>
       <div class="info-box bg6">
        <div class="title"> <p> 입원 </p> </div>
        <div class="con"><p> 10명 </p> </div>
       </div>
       <div class="info-box bg7">
        <div class="title"> <p> 퇴원 </p> </div>
        <div class="con"><p> 8명 </p> </div>
       </div>
      </div>
      <div class="bt-container">
        <div class="call-box bg1">
         <div class="title">병실호출현황</div>
         <div class="call-con">
           <div class="room">501호</div>
           <div class="name">엠티비</div>
           <div class="info">수액제거해주세요요</div>
           <div class="end">X</div>
         </div>
         <div class="call-con">
           <div class="room">501호</div>
           <div class="name">엠티비</div>
           <div class="info">수액제거해주세요</div>
           <div class="end">X</div>
         </div>
         <div class="call-con">
           <div class="room">501호</div>
           <div class="name">엠티비</div>
           <div class="info">수액제거해주세요</div>
           <div class="end">X</div>
         </div>
        <div class="call-con">
           <div class="room">501호</div>
           <div class="name">엠티비</div>
           <div class="info">수액제거해주세요</div>
           <div class="end">X</div>
         </div>
        <div class="call-con">
           <div class="room">501호</div>
           <div class="name">엠티비</div>
           <div class="info">수액제거해주세요</div>
           <div class="end">X</div>
         </div>
         <div class="call-con">
           <div class="room">501호</div>
           <div class="name">엠티비</div>
           <div class="info">수액제거해주세요</div>
           <div class="end">X</div>
         </div>
        </div>
      </div>
   </div>
   
   
  </body>
  
</html>
