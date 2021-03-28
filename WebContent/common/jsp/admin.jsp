<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="startkr.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<c:set var="commonPath" value="${contextPath}/common/jsp/user" />
<c:set var="adminPath" value="${contextPath}/admin" />
<c:set var="commonviewPath" value="${adminPath}/commonview" />
<c:set var="emrviewPath" value="${adminPath}/emrview" />
<c:set var="treatviewPath" value="${adminPath}/treatview" />
<c:set var="bedviewPath" value="${adminPath}/bedview" />
<c:set var="inpatviewPath" value="${adminPath}/inpatview" />
<c:set var="opeationviewPath" value="${adminPath}/operationview" />
<%
Long sUserId = (Long) session.getAttribute("SESSION_USER_ID");
String sSignId = (String) session.getAttribute("SESSION_SIGN_ID");
String sUserNm = (String) session.getAttribute("SESSION_USER_NM");
if( sSignId == null || sSignId.equals("")) {
%>
<script type="text/javascript">
location.href = "${adminPath}/login.jsp";
</script>
<%
	return;
}
%>
<!DOCTYPE html>
<html lang="ko">
  <head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta http-equiv="X-UA-Compatible" content="Chrome" />
  <meta name="description" content="Makros" />
  <meta name="author" content="Makros" />
  <link rel="shortcut icon" href="/favicon.ico">
  <title>진료현황판 관리시스템</title>
  <!-- Google fonts -->
  <link href='//fonts.googleapis.com/css?family=Open+Sans:400,600,700,300' rel='stylesheet' type='text/css' />
  <link href='//fonts.googleapis.com/css?family=Roboto:400,100,300' rel='stylesheet' type='text/css' />
  <!-- meta info -->
  <link rel="stylesheet" type="text/css" href="${themePath}/assets/lib/perfect-scrollbar/css/perfect-scrollbar.min.css"/>
  <link rel="stylesheet" type="text/css" href="${themePath}/assets/lib/material-design-icons/css/material-design-iconic-font.min.css"/>
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  <!-- Your custom styles -->
  <link rel="stylesheet" type="text/css" href="${themePath}/assets/css/style.css" />
  <link rel="stylesheet" type="text/css" href="${contextPath}/common/css/style.css" />

  <script src="${themePath}/assets/lib/jquery/jquery.min.js" type="text/javascript"></script>
  <script src="${themePath}/assets/lib/perfect-scrollbar/js/perfect-scrollbar.jquery.min.js" type="text/javascript"></script>
  <script src="${themePath}/assets/lib/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
  
	<script type="text/javascript">
		function checkSession() {
		 var sessionTime = <%=session.getMaxInactiveInterval()%> + "000";
		 var createdTime = new Date(<%=session.getCreationTime()%>).getTime();
		 sessionTime = parseInt(createdTime) + parseInt(sessionTime);
		 var endSession = new Date(sessionTime).getTime();
		 var today = new Date().getTime();
		 endSession = endSession - 3600000;
		 console.log("check");
		 if(endSession <= today) {
			 location.href="${adminPath}/logoutProc.jsp"
		 }
		}
		function checkStart() {
		 checkSession();
		 setInterval(checkSession, 1000*60*60);
		}
	
		checkStart();
		
		$(document).ready(function() {
			var thisUrl = "${requestURI}";
		    if( thisUrl ) {
		      jQuery(".be-left-sidebar li.active").removeClass("active");
		      console.log(thisUrl)
		      if(thisUrl.includes("treatview")) {
		    	  if(thisUrl.includes("machine") || thisUrl.includes("machine_file")) {
		    		  jQuery("#tvMachine").addClass("active open");
		    		  if(thisUrl.includes("machine/")) {
			    		  jQuery("#tvMachineThis").addClass("active");
		    		  } else if(thisUrl.includes("machine_file")) {
			    		  jQuery("#tvMachineFile").addClass("active");
		    		  }
		    	  } else if(thisUrl.includes("room") || thisUrl.includes("treat")) {
		    		  jQuery("#tvTreat").addClass("active open");
		    		  if(thisUrl.includes("room")) {
			    		  jQuery("#tvTreatRoom").addClass("active");
		    		  } else if(thisUrl.includes("treat")) {
			    		  jQuery("#tvTreatThis").addClass("active");
		    		  }
		    	  }
		      } else if(thisUrl.includes("bedview")) {
		    	  if(thisUrl.includes("bedview/bedview") || thisUrl.includes("bedview_file")) {
		    		  jQuery("#bvBedview").addClass("active open");
		    		  if(thisUrl.includes("bedview/bedview/")) {
			    		  jQuery("#bvBedviewThis").addClass("active");
		    		  } else if(thisUrl.includes("bedview_file")) {
			    		  jQuery("#bvBedviewFile").addClass("active");
		    		  }
		    	  } else if(thisUrl.includes("menu")) {
		    		  jQuery("#bvBedviewMenu").addClass("active");
		    	  } else if(thisUrl.includes("meal")) {
		    		  jQuery("#bvBedviewMeal").addClass("active");
		    	  } else if(thisUrl.includes("call")) {
		    		  jQuery("#bvBedviewCall").addClass("active");
		    	  } else if(thisUrl.includes("document")) {
		    		  jQuery("#bvBedviewDoc").addClass("active");
		    	  }
		    	  
		      } else if(thisUrl.includes("inpatview")) {
		    	  if(thisUrl.includes("room") || thisUrl.includes("file")) {
		    		  jQuery("#rvRoom").addClass("active open");
		    		  if(thisUrl.includes("room")) {
			    		  jQuery("#rvRoomThis").addClass("active");
		    		  } else if(thisUrl.includes("file")) {
			    		  jQuery("#rvRoomFile").addClass("active");
		    		  }
		    	  }
		      } else if(thisUrl.includes("emrview")) {
		    	  if(thisUrl.includes("treat") || thisUrl.includes("patient") || thisUrl.includes("inpatient") || thisUrl.includes("checkout")) {
		    		  jQuery("#evEmr").addClass("active open");
		    		  if(thisUrl.includes("treat")) {
			    		  jQuery("#evEmrTreat").addClass("active");
		    		  } else if(thisUrl.includes("/patient")) {
			    		  jQuery("#evEmrPatient").addClass("active");
		    		  } else if(thisUrl.includes("inpatient")) {
			    		  jQuery("#evEmrInpatient").addClass("active");
		    		  } else {
		    			  jQuery("#evEmrCheckout").addClass("active");
		    		  }
		    	  }
		      } else {
		    	  if(thisUrl.includes("doctor") || thisUrl.includes("nurse")) {
		    		  jQuery("#cvUser").addClass("active open");
		    		  if(thisUrl.includes("doctor")) {
			    		  jQuery("#cvUserDoctor").addClass("active");
		    		  } else if(thisUrl.includes("nurse")) {
			    		  jQuery("#cvUserNurse").addClass("active");
		    		  }
		    	  } else if(thisUrl.includes("notice") || thisUrl.includes("notice_target")) {
		    		  jQuery("#cvNotice").addClass("active open");
		    		  if(thisUrl.includes("notice/")) {
			    		  jQuery("#cvNoticeThis").addClass("active");
		    		  } else if(thisUrl.includes("notice_target")) {
			    		  jQuery("#cvNoticeTarget").addClass("active");
		    		  }
		    	  } else if(thisUrl.includes("patient")) {
		    		  jQuery("#cvPatient").addClass("active");
		    	  } else {
		    		  jQuery("#cvDashBoard").addClass("active");
		    	  }
		      }
		    }
		});
	</script>
	<script>
		
	function evClickUpdatePasswd() {
		jQuery("#passwdMyself").val("");
		jQuery("#passwdNew").val("");
		jQuery("#passwdCheck").val("");
		jQuery("#cfPasswordModal").modal();
	}
	
// 	function evClickUpdateColor() {
// 		$('input[name="theme_color"]:radio[value="${sessionScope.SESSION_THEME_COLOR}"]').prop('checked',true);
// 		jQuery("#font_color").val("${sessionScope.SESSION_FONT_COLOR}");
// 		jQuery("#cfColorModal").modal();
// 	}
	
	function evClickSaveInfo() {
		if(validateInfo()) {
    	jQuery("#cfInfoForm").submit();
		}
	}
		
	function evClickSavePassword() {
		if(validatePassword()) {
    	jQuery("#cfPasswordForm").submit();
		}
	}
	
// 	function evClickSaveColor() {
// 		jQuery("#cfColorForm").submit();
// 	}
		
	function validateInfo() {
		if(!jQuery("#userNameMyself").val()) {
			alert("이름을 입력해 주세요");
			return false;
		}
		return true;
	}
		
	function validatePassword() {
		if(!jQuery("#passwdMyself").val()) {
  			alert("비밀번호를 입력해 주세요");
  			return false;
 		}
		if(!jQuery("#passwdNew").val()) {
 			alert("새 비밀번호를 입력해 주세요");
 			return false;
 		}
		if(jQuery("#passwdNew").val() != jQuery("#passwdCheck").val()) {
 			alert("새 비밀번호와 재입력한 비밀번호가 다릅니다.");
 			return false;
 		}
		return true;
	}
	</script>
  
<decorator:head />
  </head>

  <body>
    <div class="be-wrapper">
      <nav class="navbar navbar-default navbar-fixed-top be-top-header">
        <div class="container-fluid">
          <div class="navbar-header">
            <a href="${adminPath}/index.jsp" class="navbar-brand" style="padding-top:16px;background:none">
              <c:if test="${!empty sessionScope.SESSION_LOGO_URL}">
				        <img src="${sessionScope.SESSION_LOGO_URL}" height="32"/>
				      </c:if>
            </a>
          </div>
          <div class="be-right-navbar">
            <ul class="nav navbar-nav navbar-right be-user-nav">
              <li class="dropdown">
                <a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="dropdown-toggle">
                  <img src="${themePath}/assets/img/avatar.png" alt="Avatar"><span class="user-name"><%=sUserNm%></span>
                </a>
                <ul role="menu" class="dropdown-menu">
                  <li>
                    <div class="user-info">
                      <div class="user-name"><%=sUserNm%></div>
                      <div class="user-position online">Available</div>
                    </div>
                  </li>
                  <li><a href="#" onclick='jQuery("#cfInfoModal").modal();'><span class="icon mdi mdi-face"></span> 개인정보 수정</a></li>
                  <li><a href="#" onclick="evClickUpdatePasswd()"><span class="icon mdi mdi-lock"></span> 비밀번호 수정</a></li>
<%--                   <c:if test="${sessionScope.SESSION_BEDVIEW_FG eq 'TRUE'}"> --%>
<!--                   <li><a href="#" onclick="evClickUpdateColor()"><span class="icon mdi mdi-lock"></span> 색상 변경 </a></li> -->
<%--                   </c:if> --%>
                  <li><a href="${adminPath}/logoutProc.jsp"><span class="icon mdi mdi-power"></span> Logout</a></li>
                </ul>
              </li>
            </ul>
            <div class="page-title"><span>진료현황판 관리시스템</span></div>
          </div>
        </div>
      </nav>
      <div class="be-left-sidebar">
        <div class="left-sidebar-wrapper"><a href="#" class="left-sidebar-toggle">진료현황판 관리시스템</a>
          <div class="left-sidebar-spacer">
            <div class="left-sidebar-scroll">
              <div class="left-sidebar-content">
                <ul class="sidebar-elements">
                
                	<li class="divider">EMR 조회 메뉴</li>
                	<li id="evEmr" class="parent"><a href="#"><i class="icon mdi mdi-collection-plus"></i><span>EMR</span></a>
                    <ul class="sub-menu">
                      <li id="evEmrTreat"><a href="${emrviewPath}/treat/">진료 조회</a></li>
<%--                       <li id="evEmrCheckout"><a href="${emrviewPath}/checkout/">진료지원 조회</a></li> --%>
                      <c:if test="${sessionScope.SESSION_INPATVIEW_FG eq 'TRUE'}">
<%--                       <li id="evEmrPatient"><a href="${emrviewPath}/patient/">환자 조회</a></li> --%>
                      <li id="evEmrInpatient"><a href="${emrviewPath}/inpatient/">입원자 조회</a></li>
                      </c:if>
                    </ul>
                  </li>
                	<c:if test="${sessionScope.SESSION_TREATVIEW_FG eq 'TRUE'}">
                  <li class="divider">현황판 관리 메뉴</li>
                  <li id="tvMachine" class="parent"><a href="#"><i class="icon mdi mdi-devices"></i><span>현황판</span></a>
                    <ul class="sub-menu">
                      <li id="tvMachineThis"><a href="${treatviewPath}/machine/">현황판 관리</a></li>
                      <li id="tvMachineFile"><a href="${treatviewPath}/machine_file/">현황판 파일</a></li>
                    </ul>
                  </li>
                  <li id="tvTreat" class="parent"><a href="#"><i class="icon mdi mdi-hospital-alt"></i><span>진료</span></a>
                    <ul class="sub-menu">
                    	<li id="tvTreatRoom"><a href="${treatviewPath}/room/">진료실 관리</a></li>
                    	<c:if test="${sessionScope.SESSION_EMR_FG eq 'FALSE'}">
                      <li id="tvTreatThis"><a href="${treatviewPath}/treat/">진료 관리</a></li>
											</c:if>
                    </ul>
                  </li>
                  </c:if>
                  
                  <c:if test="${sessionScope.SESSION_BEDVIEW_FG eq 'TRUE'}">
                  <li class="divider">병상용 관리 메뉴</li>
                  <li id="bvBedview" class="parent"><a href="#"><i class="icon mdi mdi-developer-board"></i><span>병상용</span></a>
                    <ul class="sub-menu">
                      <li id="bvBedviewThis"><a href="${bedviewPath}/bedview/">병상용 관리</a></li>
                      <li id="bvBedviewFile"><a href="${bedviewPath}/bedview_file/">병상용 파일</a></li>
                    </ul>
                  </li>
                  <li id="bvBedviewMenu">
                  	<a href="${bedviewPath}/menu/"><i class="icon mdi mdi-format-list-numbered"></i><span>메뉴</span></a>
                  </li>
                  <li id="bvBedviewMenu">
                  	<a href="${bedviewPath}/meal/"><i class="icon mdi mdi-cutlery"></i><span>식단</span></a>
                  </li>
                  <li id="bvBedviewCall">
                  	<a href="${bedviewPath}/call/"><i class="icon mdi mdi-local-phone"></i><span>간호사호출</span></a>
                  </li>
                  <li id="bvBedviewDoc">
                  	<a href="${bedviewPath}/document/"><i class="icon mdi mdi-assignment-check"></i><span>재증명발급</span></a>
                  </li>
                  </c:if>
                  
                  <c:if test="${sessionScope.SESSION_INPATVIEW_FG eq 'TRUE'}">
                  <li class="divider">입원실 관리 메뉴</li>
                  <li id="rvRoom" class="parent"><a href="#"><i class="icon glyphicon glyphicon-plus"></i><span>입원실</span></a>
                    <ul class="sub-menu">
                      <li id="rvRoomThis"><a href="${inpatviewPath}/room/">입원실 관리</a></li>
                      <li id="rvRoomFile"><a href="${inpatviewPath}/file/">입원실 이미지</a></li>
                    </ul>
                  </li>
                  </c:if>
                  
                  <c:if test="${sessionScope.SESSION_OPERATION_FG eq 'TRUE'}">
                  <li class="divider">수술실 관리 메뉴</li>
                  <li id="rvRoom" class="parent"><a href="#"><i class="icon glyphicon glyphicon-warning-sign"></i><span>수술실</span></a>
                    <ul class="sub-menu">
                      <li id="rvRoomThis"><a href="${opeationviewPath}/room/">수술실 관리</a></li>
                      <li id="rvRoomThis"><a href="${opeationviewPath}/file/">파일 관리</a></li>
                    </ul>
                  </li>
                  </c:if>
                  
                  <li class="divider">공통 관리 메뉴</li>
                  <li id="cvDashBoard" class="active">
                  	<a href="${commonviewPath}/"><i class="icon mdi mdi-chart"></i><span>대쉬 보드</span></a>
                  </li>
                  <li id="cvUser" class="parent"><a href="#"><i class="icon mdi mdi-face"></i><span>병원관계자</span></a>
                    <ul class="sub-menu">
                      <li id="cvUserDoctor"><a href="${commonviewPath}/doctor/">의사 관리</a></li>
                      <li id="cvUserNurse"><a href="${commonviewPath}/nurse/">간호사 관리</a></li>
                    </ul>
                  </li>
                  <li id="cvNotice" class="parent"><a href="#"><i class="icon mdi mdi-notifications"></i><span>공지사항</span></a>
                    <ul class="sub-menu">
                      <li id="cvNoticeThis"><a href="${commonviewPath}/notice/">공지글 관리</a></li>
                      <li id="cvNoticeTarget"><a href="${commonviewPath}/notice_target/">연동 관리</a></li>
                    </ul>
                  </li>
                  <li id="cvPatient">
                  	<c:if test="${sessionScope.SESSION_EMR_FG eq 'FALSE'}">
                  	<a href="${commonviewPath}/patient/"><i class="icon mdi mdi-hotel"></i><span>환자 관리</span></a>
                  	</c:if>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>

<decorator:body />

			<div id="cfInfoModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
	      <div class="modal-dialog custom-width">
	        <form id="cfInfoForm" name="infoForm" method="POST" action="${commonPath}/updateProc.jsp">
						<input type="hidden" name="user_id" value="${sessionScope.SESSION_USER_ID}">
					
		        <div class="modal-content">
		          <div class="modal-header">
		            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
		            <h3 class="modal-title">사용자 정보</h3>
		          </div>
		
		          <div class="modal-body">
		            <div class="form-group">
		              <label>아이디</label>
		              <input id="signIdMyself" name="sign_id_myself" type="text" placeholder="아이디를 입력하세요" class="form-control input-sm" readonly="readonly" value="${sessionScope.SESSION_SIGN_ID }"/>
		            </div>
		            <div class="form-group">
		              <label>이름</label>
		              <input id="userNameMyself" name="user_nm" type="text" placeholder="이름을 입력해 주세요" class="form-control input-sm" maxlength="30" value="${sessionScope.SESSION_USER_NM}"/>
		            </div>
		          </div>
		          
		          <div class="modal-footer">
		            <button type="button" data-dismiss="modal" class="btn btn-default md-close">닫기</button>
		            <button type="button" class="btn btn-success" onclick="evClickSaveInfo()">저장</button>
		          </div>
		        </div>
	        </form>
	      </div>
	    </div>
	    
	    <div id="cfPasswordModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
	      <div class="modal-dialog custom-width">
	        <form id="cfPasswordForm" name="passwordForm" method="POST" action="${commonPath}/updatePasswd.jsp">
						<input type="hidden" name="user_id" value="${sessionScope.SESSION_USER_ID}">
					
		        <div class="modal-content">
		          <div class="modal-header">
		            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
		            <h3 class="modal-title">비밀번호 변경</h3>
		          </div>
		
		          <div class="modal-body">
		            <div id="newPasswordBox">    
			            <div class="form-group">
			              <label>비밀번호</label>
			              <input id="passwdMyself" name="passwd_myself" type="password" placeholder="비밀번호를 입력해 주세요" class="form-control input-sm" maxlength="30" />
			            </div>
			            <div class="form-group">
			              <label>새 비밀번호</label>
			              <input id="passwdNew" name="passwd_new" type="password" placeholder="새롭게 지정할 비밀번호를 입력해 주세요" class="form-control input-sm" maxlength="30" />
			            </div>
			            <div class="form-group">
			              <label>새 비밀번호 재입력</label>
			              <input id="passwdCheck" name="passwd_check" type="password" placeholder="새 비밀번호를 다시 입력해 주세요" class="form-control input-sm" maxlength="30" />
			            </div>
		            </div>
		          </div>
		          
		          <div class="modal-footer">
		            <button type="button" data-dismiss="modal" class="btn btn-default md-close">닫기</button>
		            <button type="button" class="btn btn-success" onclick="evClickSavePassword()">저장</button>
		          </div>
		          
		        </div>
	        </form>
	      </div>
	    </div>
	    
<!-- 	    <div id="cfColorModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary"> -->
<!-- 	      <div class="modal-dialog custom-width"> -->
<%-- 	        <form id="cfColorForm" name="colorForm" method="POST" action="${commonPath}/updateColor.jsp"> --%>
					
<!-- 		        <div class="modal-content"> -->
<!-- 		          <div class="modal-header"> -->
<!-- 		            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button> -->
<!-- 		            <h3 class="modal-title">색상 변경</h3> -->
<!-- 		          </div> -->
		
<!-- 		          <div class="modal-body"> -->
<!-- <!-- 		            <div class="form-group"> -->
<!-- <!--                   <label>테마색</label> -->
<!-- <!--                   <input type="color" id="theme_color" name="theme_color" class="form-control input-sm" /> -->
<!-- <!--                 </div> -->
<!--                 <div class="form-group"> -->
<!--                   <label>테마색</label> -->
<!--                   <div> -->
<!-- 	                  <div class="theme_color_box"> -->
<!-- 		                  <input type="radio" id="theme_skybule" name="theme_color" class="theme_color" value="skyblue"/> -->
<!-- 		                  <label for="theme_skybule"><div class="theme_color skyblue"></div></label> -->
<!-- 	                  </div> -->
<!-- 	                  <div class="theme_color_box"> -->
<!-- 		                  <input type="radio" id="theme_bule" name="theme_color" class="theme_color" value="blue"/> -->
<!-- 		                  <label for="theme_bule"><div class="theme_color blue"></div></label> -->
<!-- 	                  </div> -->
<!-- 	                  <div class="theme_color_box"> -->
<!-- 		                  <input type="radio" id="theme_deepblue" name="theme_color" class="theme_color" value="deepblue"/> -->
<!-- 		                  <label for="theme_deepblue"><div class="theme_color deepblue"></div></label> -->
<!-- 	                  </div> -->
<!-- 	                  <div class="theme_color_box"> -->
<!-- 		                  <input type="radio" id="theme_orange" name="theme_color" class="theme_color" value="orange"/> -->
<!-- 		                  <label for="theme_orange"><div class="theme_color orange"></div></label> -->
<!-- 	                  </div> -->
<!-- 	                  <div class="theme_color_box"> -->
<!-- 		                  <input type="radio" id="theme_brown" name="theme_color" class="theme_color" value="brown"/> -->
<!-- 		                  <label for="theme_brown"><div class="theme_color brown"></div></label> -->
<!-- 	                  </div> -->
<!-- 	                  <div class="theme_color_box"> -->
<!-- 		                  <input type="radio" id="theme_green" name="theme_color" class="theme_color" value="green"/> -->
<!-- 		                  <label for="theme_green"><div class="theme_color green"></div></label> -->
<!-- 	                  </div> -->
<!-- 	                  <div class="theme_color_box"> -->
<!-- 		                  <input type="radio" id="theme_purple" name="theme_color" class="theme_color" value="purple"/> -->
<!-- 		                  <label for="theme_purple"><div class="theme_color purple"></div></label> -->
<!-- 	                  </div> -->
<!-- 	                  <div class="theme_color_box"> -->
<!-- 		                  <input type="radio" id="theme_pink" name="theme_color" class="theme_color" value="pink"/> -->
<!-- 		                  <label for="theme_pink"><div class="theme_color pink"></div></label> -->
<!-- 	                  </div> -->
<!--                   </div> -->
<!--                   </div> -->
<!--                 <div class="form-group"> -->
<!--                   <label>글자색</label> -->
<!--                   <input type="color" id="font_color" name="font_color" class="form-control input-sm" /> -->
<!--                 </div> -->
<!-- 		          </div> -->
<!-- 		          <div class="modal-footer"> -->
<!-- 		            <button type="button" data-dismiss="modal" class="btn btn-default md-close">닫기</button> -->
<!-- 		            <button type="button" class="btn btn-success" onclick="evClickSaveColor()">저장</button> -->
<!-- 		          </div> -->
		          
<!-- 		        </div> -->
<!-- 	        </form> -->
<!-- 	      </div> -->
<!-- 	    </div>		 -->
    </div>
  </body>
</html>