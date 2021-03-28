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
List leftList = null;
List rightList = null;
FloorBiz floorBiz = null;
BedviewBiz bedviewBiz = null;
try {
	floorBiz = new FloorBiz();
  resultMap = floorBiz.selectFloor(paramMap);
  
  bedviewBiz = new BedviewBiz();
  List list = bedviewBiz.selectBedviewList(paramMap);
   
  if(list.size() > 2) {
	  int index = 0;
	  index = list.size()/2;
	  
	  leftList = list.subList(0, index);
	  rightList = list.subList(index, list.size());
  } else if(list.size() == 1) {
	  leftList = list.subList(0, 1);
  }
  
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="leftList" value="<%=leftList%>" />
<c:set var="rightList" value="<%=rightList%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<head>
	<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
	<link rel="stylesheet" type="text/css" href="css/callPop.css">
	<script src="${contextPath}/common/js/jquery-3.3.1.min.js"></script>
  <script src="${contextPath}/common/js/bootstrap.min.js"></script>
	
  <script type="text/javascript">
    
    jQuery(document).ready(function(){
      getCallList();
      today();
    });
    
    function SoundPlay(){
      var html = '<audio src="call.wav" type="audio/mpeg" autoplay="autoplay">'+
                   '<embed srd="call.wav">'+ 
                 '</audio>';
        $("#sound").empty();
        $("#sound").append(html);
    }
    
    function evClickCompelete( idx, obj ) {
      $.ajax({
          url : "${bedviewPath}/call/json/updateCall.jsp",
          type : "POST",
          cache : false,
          dataType : "json",
          data : {"call_id":idx,"check_yn":"Y"},
          success: function( result ) {
             if(result.resultCode){
           	  $(obj).parent().parent().remove();
             } else {
            	 alert("알람 삭제에 실패하였습니다.");
             }
          },
          error: function(request,status,error) {
          },
          complete: function(jqXHR, textStatus) {
          
          }
      });
    }
    
    function getCallList(){
        $.ajax({
            url : "${bedviewPath}/call/json/selectCallList.jsp",
            type : "post",
            cache : false,
            dataType : "json",
            data : {"check_yn":"N","floor_id":'${paramMap.floor_id}' },
            success: function( result ) {
              insertCallCard(result.resultData);
            },
            error: function(request,status,error) {
              console.log(error);
            },
            complete: function(jqXHR, textStatus) {
              
            }
        });
//         setTimeout(getCallList, 2000);
    }
    
    function insertCallCard( data ) {
        var temp = "";
      	for ( lp0 = 0 ; lp0 < data.length; lp0 ++){
          temp += '<table class="type09">';       
          temp += '<tr>'
          temp += '<th scope="row" style="width: 15%;">'+data[lp0].ward+'</th>';
          temp += '<td style="width: 50%; font-size:1.8em;">'+data[lp0].content+'</td>';
         	temp += '<td style="width: 25%;">'+data[lp0].time+'</td>';
       		temp += '<td style="width: 10%; cursor:pointer;" onclick="evClickCompelete('+data[lp0].call_id+', this)">X</td>';
         	temp += '</tr>';
         	temp += '</table>';
        }
      	jQuery("#callList").html(temp);
    }
    
    function submitForm() {
        $("#cfMainForm").submit();
        $('#cfCallModal').modal('hide');
    }
    
    function today() {
    	var today = new Date();
    	var str = today.getFullYear();
    	if(today.getMonth() + 1 < 10) {
    		str += "-0" + (today.getMonth() + 1);
    	} else {
    		str += "-" + (today.getMonth() + 1);
    	}
    	if(today.getDate() < 10) {
    		str += "-0" + today.getDate();
    	} else {
    		str += "-" + today.getDate();
    	}
    	
    	str += "<br/>";
    	if(today.getHours() < 10) {
    		str += "0" + today.getHours();
    	} else {
    		str += today.getHours();
    	}
    	if(today.getMinutes() < 10) {
    		str += ":0" + today.getMinutes() + " ";
    	} else {
    		str += ":" + today.getMinutes() + " ";
    	}
    	
    	if(today.getDay() == 0) {
    		str += "일요일";
    	} else if(today.getDay() == 1) {
    		str += "월요일";
    	} else if(today.getDay() == 2) {
    		str += "화요일";
    	} else if(today.getDay() == 3) {
    		str += "수요일";
    	} else if(today.getDay() == 4) {
    		str += "목요일";
    	} else if(today.getDay() == 5) {
    		str += "금요일";
    	} else {
    		str += "토요일";
    	}
    	$("#today").html(str);
      setTimeout(today, 60000);
    }
  </script>
</head>

<body>
<div id="sound">
</div>
      <div class="be-content">
<!--         <div class="page-head"> -->
<!--           <h2 class="page-head-title">호출 관리</h2> -->
<!--           <ol class="breadcrumb page-head-nav"> -->
<!--             <li><a href="#">침상용 관리 메뉴</a></li> -->
<!--             <li class="active">호출 관리</li> -->
<!--           </ol> -->
<!--         </div> -->

        <div class="main-content container-fluid" style="background:white;">
          <div>
				    <div class="ns_top">
						  <div class="ns_top2">
						     <div style="width:15%; float:left;"><p class="if_title">M-tv</p></div>
						     <div style="width:70%; float:left;"><p class="if_title">${resultMap.floor_nm}</p></div>
						     <div style="width:10%; float:left; margin: 10px;">
						     	<p id="today" class="if_title" style="font-size: 1.6em; margin:10px;"></p>
						     </div>
						  </div>
						</div>
						<div class="ns_mid">
							<div class="ns_mid_l">
					    	<table class="type07">
							  	<thead>
										<tr>
											<th style="height: 70px; font-size: 1.8em; width: 10%;">병실</th>
											<th style="font-size: 1.8em; width: 15%;">이름</th>
											<th style="font-size: 1.8em; width: 8%;">성별</th>
											<th style="font-size: 1.8em; width: 12%;">진료과</th>
											<th style="font-size: 1.8em; width: 15%;">주치의</th>
											<th style="font-size: 1.8em;">기타 / 메모</th>
										</tr>
					        </thead>
								  <tbody>
									  <tr>
	                   <td>501호</td>
									   <td>홍길동</td>
									   <td>남/32</td>
									   <td>OS</td>
									   <td>김병원</td>
									   <td>12:30분 수액투여</td>
									 </tr>
									 <tr>
					           <td rowspan="2">502호<br>2인실</td>
									   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									 <tr>                  
									   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									 <tr>
					                   <td rowspan="2">503호<br>2인실</td>
									   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									 <tr>
					                   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									 <tr>
					                   <td>505호</td>
									   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									 <tr>
					                   <td rowspan="4">506호<br>4인실</td>
									   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									 <tr>
					                   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									<tr>
					                   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									 <tr>
					                   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									  <td rowspan="4">507호<br>4인실</td>
									   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									 <tr>
					                   
									   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									<tr>
					                   
									   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
									 <tr>
					                   
									   <td>이름</td>
									   <td>성별</td>
									   <td>진료과</td>
									   <td>주치의</td>
									   <td>기타 / 메모</td>
									 </tr>
								  </tbody>
							  </table>
							</div>
							<div class="ns_mid_r">
					    	<table class="type07">
							  	<thead>
										<tr>
											<th style="height: 70px; font-size: 1.8em; width: 10%;">병실</th>
											<th style="font-size: 1.8em; width: 15%;">이름</th>
											<th style="font-size: 1.8em; width: 8%;">성별</th>
											<th style="font-size: 1.8em; width: 12%;">진료과</th>
											<th style="font-size: 1.8em; width: 15%;">주치의</th>
											<th style="font-size: 1.8em;">기타 / 메모</th>
										</tr>
					        </thead>
								  <tbody>
									<tr>
                   <td rowspan="6">508호<br>6인실</td>
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                  
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                   <td rowspan="4">509호<br>4인실</td>
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								<tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								  <tr>
				                   <td rowspan="4">510호<br>4인실</td>
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								<tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								 <tr>
				                   
								   <td>이름</td>
								   <td>성별</td>
								   <td>진료과</td>
								   <td>주치의</td>
								   <td>기타 / 메모</td>
								 </tr>
								  </tbody>
							  </table>
							</div>
						</div>
						<div class="ns_bt">
							<div class="ns_bt2">
								<div class="ns_bt_l">
					   			<div class="bt_bar_title">
					   				<p class="bt_title">입/퇴원 현황</p>
					   			</div>
									<div>
										<table class="type08" style="width:30%; float: left;">
											<thead>
												<tr>
													<th scope="cols" style="font-size: 1.8em">입원</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td scope="row" style="font-size: 3em">10명</td>
												</tr>
											</tbody>
										</table>
										<table class="type08" style="width:30%; float: left;">
											<thead>
												<tr>
													<th scope="cols" style="font-size: 1.8em">퇴원</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td scope="row" style="font-size: 3em">10명</td>
												</tr>
											</tbody>
										</table>
										<table class="type08" style="width:30%; float: left;">
											<thead>
												<tr>
													<th scope="cols" style="font-size: 1.8em">재원</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td scope="row" style="font-size: 3em">10명</td>
												</tr>
											</tbody>
										</table>				
									</div>
					  		</div>
			          <div class="bt_bar"></div>
					  		<div class="ns_bt_r">
						  		<div class="bt_bar_title">
						  			<p class="bt_title">호출 현황</p>
						  		</div>
						    	<div id="callList">
						 			</div>
								</div>
							</div>
						</div>
				  </div>
        </div><!-- /.main-content -->
      </div><!-- /.be-content -->

    <script src="${contextPath}/common/js/main.js" type="text/javascript"></script>
    <script src="${contextPath}/common/js/dataTableOption.js" type="text/javascript"></script>
    <script src="${contextPath}/common/js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="${contextPath}/common/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/dataTables.buttons.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.html5.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.flash.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.print.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.colVis.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/datatables/plugins/buttons/js/buttons.bootstrap.js" type="text/javascript"></script>

    <script type="text/javascript">
      $(document).ready(function(){
        //initialize the javascript
        App.init();
        setMainDataTable('#mainDataTable');
      });
    </script>

</body>