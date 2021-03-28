<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.PatientBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.UserBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);

HashMap userMap = null;
// HashMap emrMap = null;
HashMap patientMap = null;
UserBiz userBiz = null;
// EmrBiz emrBiz = null;
PatientBiz patientBiz = null;
try {
    userBiz = new UserBiz();
    paramMap.put("use_fg", "Y");
    userMap = userBiz.selectUserCount(paramMap);
    
    patientBiz = new PatientBiz();
    patientMap = patientBiz.selectPatientCountPage(paramMap);
    // TODO CHECK
//     emrBiz = new EmrBiz();
//     emrMap = emrBiz.selectEmrCountPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="userMap" value="<%=userMap%>" />
<%-- <c:set var="emrMap" value="<%=emrMap%>" /> --%>
<c:set var="patientMap" value="<%=patientMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<head>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
</head>

<body>
      <div class="be-content">
        <div class="main-content container-fluid">
        	<div class="row">
<!--             <div class="col-sm-12"> -->
<!--               <div class="widget widget-tile"> -->
<!--                 <div class="col-xs-6"> -->
<!--                   <i class="fa fa-plus-square fa-4x"></i> -->
<!--                 </div> -->
<!--                 <div class="data-info col-xs-6"> -->
<!--                   <div class="desc">진료 내역</div> -->
<!--                   <div class="value"> -->
<!--                     <span class="indicator indicator-equal mdi mdi-chevron-right"></span> -->
<%--                     <span id="allDetectorCount" data-toggle="counter" data-start="0" data-end="10" class="number">${emrMap.acceptCount}</span> --%>
<!--                   </div> -->
<!--                 </div> -->
<!--               </div>/.widget -->
<!--             </div>/.col- -->
            
            <div class="col-sm-12">
              <div class="widget widget-tile">
                <div class="col-xs-6">
                  <i class="fa fa-plus-square fa-4x"></i>
                </div>
                <div class="data-info col-xs-6">
                  <div class="desc">환자 내역</div>
                  <div class="value">
                    <span class="indicator indicator-equal mdi mdi-chevron-right"></span>
                    <span id="allDetectorCount" data-toggle="counter" data-start="0" data-end="10" class="number">${patientMap.count}</span>
                  </div>
                </div>
              </div><!-- /.widget -->
            </div><!-- /.col- -->

            <div class="col-sm-12">
              <div class="widget widget-tile">
                <div class="col-xs-6">
                  <i class="fa fa-hotel fa-4x"></i>
                </div>
                <div class="data-info col-xs-6">
                  <div class="desc">입원자 내역</div>
                  <div class="value">
                    <span class="indicator indicator-equal mdi mdi-chevron-right"></span>
                    <span id="allCompanyCount" data-toggle="counter" data-start="0" data-end="10" class="number">0</span>
                  </div>
                </div>
              </div><!-- /.widget -->
            </div><!-- /.col- -->
            
            <div class="col-sm-12">
              <div class="widget widget-tile">
                <div class="col-xs-6">
                  <i class="fa fa-user fa-4x"></i>
                </div>
                <div class="data-info col-xs-6">
                  <div class="desc">사용자 내역</div>
                  <div class="value">
                    <span class="indicator indicator-equal mdi mdi-chevron-right"></span>
                    <span id="outerMoveCount" data-toggle="counter" data-start="0" data-end="10" class="number">${userMap.count}</span>
                  </div>
                </div>
              </div><!-- /.widget -->
            </div><!-- /.col- -->
            
          </div><!-- /.row -->
        </div><!-- /.main-content -->
      </div><!-- /.be-content -->

    <script src="${contextPath}/common/js/main.js" type="text/javascript"></script>
    <script src="${contextPath}/common/js/highchart.js" type="text/javascript"></script>

    <script src="${themePath}/assets/lib/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
    <script src="${contextPath}/common/js/dataTableOption.js" type="text/javascript"></script>
    
    <!-- sparkline lib -->
    <script src="${themePath}/assets/lib/jquery.sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="${themePath}/assets/lib/countup/countUp.min.js" type="text/javascript"></script>

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
        // initialize the javascript
        App.init();
    });
    </script>

</body>