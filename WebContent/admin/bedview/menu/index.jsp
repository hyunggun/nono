<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="com.cofac.treat.ora.biz.non.MenuBiz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="requestURI" value="<%=request.getRequestURI()%>" />
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<c:set var="bedviewPath" value="${contextPath}/admin/bedview" />
<c:set var="themePath" value="${contextPath}/outsrc/beagle" />
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
HashMap resultMap = null;
MenuBiz menuBiz = null;

paramMap.put("pid", "0");

try {
	menuBiz = new MenuBiz();
  resultMap = menuBiz.selectMenuPage(paramMap);
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
<c:set var="resultMap" value="<%=resultMap%>" />
<c:set var="paramMap" value="<%=paramMap%>" />
<head>
<!--     <script src="//cdn.ckeditor.com/4.5.8/standard/ckeditor.js"></script> -->
		<script src="${contextPath}/common/js/jquery.form.min.js"></script>
    <script type="text/javascript" src="${contextPath}/common/js/jindo.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${contextPath}/common/js/HuskyEZCreator.js" charset="utf-8"></script>
    <script type="text/javascript" src="${contextPath}/common/js/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
    <style>
      .custom-width { width: 1000px; }
      iframe {min-height: 460px;}
      .switch {
			  position: relative;
			  display: inline-block;
			  width: 30px;
			  height: 17px;
			  vertical-align:middle;
			}
			 
			/* Hide default HTML checkbox */
			.switch input {display:none;}
			 
			/* The slider */
			.slider {
			  position: absolute;
			  cursor: pointer;
			  top: 0;
			  left: 0;
			  right: 0;
			  bottom: 0;
			  background-color: #ccc;
			  -webkit-transition: .4s;
			  transition: .4s;
			}
			 
			.slider:before {
			  position: absolute;
			  content: "";
			  height: 13px;
			  width: 13px;
			  left: 2px;
			  bottom: 2px;
			  background-color: white;
			  -webkit-transition: .4s;
			  transition: .4s;
			}
			 
			input:checked + .slider {
			  background-color: #2196F3;
			}
			 
			input:focus + .slider {
			  box-shadow: 0 0 1px #2196F3;
			}
			 
			input:checked + .slider:before {
			  -webkit-transform: translateX(13px);
			  -ms-transform: translateX(13px);
			  transform: translateX(13px);
			}
			 
			/* Rounded sliders */
			.slider.round {
			  border-radius: 17px;
			}
			 
			.slider.round:before {
			  border-radius: 50%;
			}
			 
			p {
			  margin:0px;
			  display:inline-block;
			  font-size:10px;
			  font-weight:bold;
			}
			
			.modal-view {
				display:block; left: -9999px !important; top: -9999px !important;
			}
    </style>
    <script type="text/javascript">
    var oEditors = [];
    function smartEditor(){

      var sLang = "ko_KR";  // 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR

      // 추가 글꼴 목록
      //var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

      nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "content",
        sSkinURI: "smartEditor/SmartEditor2Skin.html",
        fCreator: "createSEditor2",
        htParams : {
          bUseToolbar : true,       // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
          bUseVerticalResizer : false,   // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
          bUseModeChanger : true,     // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
          bSkipXssFilter : true,    // client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
          //aAdditionalFontList : aAdditionalFontSet,   // 추가 글꼴 목록
          fOnBeforeUnload : function(){
            //alert("완료!");
          },
          I18N_LOCALE : sLang
        }, //boolean
        fOnAppLoad : function(){
          //예제 코드
          jQuery("#cfContentModal").removeClass('modal-view');
//           if(${resultMap.count == 0}){
//             var sHTML = 'test';
//             oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
//           }
        },
        fCreator: "createSEditor2"
      });
    }
    
//     function evClickAdd() {
//     	jQuery("#menu_id").val("");
//     	jQuery("#menu_nm").val("");
//     	jQuery("#menu_type").val("0");
//     	jQuery("#uploadFile").val("");
    	
//       jQuery('#cfMenuModal').modal('show');
//     }

//     function evClickRow( menuKey ) {
//   	  jQuery.ajax({
//         url : "${bedviewPath}/menu/json/menuInfo.jsp",
//         type : "get",
//         cache : false,
//         dataType : "json",
//         data : {menu_id:menuKey},
//         success: function( result ) {
//             setMenuOnForm( result.resultData );
//         },
//         error: function(jqXHR, textStatus) {
      	  
//         }
//       });
//     }
    
    function evClickSaveMenu() {
  	  
    	var menuIdx = jQuery("#menu_id").val();
    	var url = "${bedviewPath}/menu/json/insertMenu.jsp";
    	if(menuIdx) {
    		url = "${bedviewPath}/menu/json/updateMenu.jsp";
    	}
    	jQuery('#cfMenuForm').attr("action", url);
    	jQuery("#page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
    	jQuery('#cfMenuModal').modal('hide');
    	
    	jQuery('#cfMenuForm').ajaxForm({
    		beforeSubmit: function (data,form,option) {
					if( validate("menu") ) {
						return true;
		       } else {
		       	return false;
		       }
    		},
    		success: function(data, status) {
					if(data.resultCode) {
	      	  alert("메뉴가 저장되었습니다.");
	        } else {
	      	  alert("메뉴 저장에 실패하였습니다.");
	        }
// 					pageReload()
						location.reload();
    		},
    		error: function() {
    			alert('통신 실패');
    		}
    	});

    	jQuery('#cfMenuForm').submit();
    }
    
//     function evClickDelete( menuKey ) {
//       var result = confirm('해당 메뉴를 삭제하시겠습니까?'); 
//       if(result) {
        
//       	jQuery.ajax({
//             url : "${bedviewPath}/menu/json/deleteMenu.jsp",
//             type : "POST",
//             dataType : "json",
//             data : {menu_id:menuKey},
//             success: function( result ) {
//               if(result.resultCode){
//             	  alert("메뉴 삭제에 성공하였습니다.");
//               } else {
//             		alert("메뉴 삭제에 실패하였습니다.");
//               }
//               pageReload();
//             },
//             complete: function(jqXHR, textStatus) {
            	
//             }
//         });
//       }
//     };
    
//     function evClickMenuLangs( menuKey ) {
//   	  jQuery.ajax({
//         url : "${bedviewPath}/menu/json/menuInfo.jsp",
//         type : "get",
//         cache : false,
//         dataType : "json",
//         data : {menu_id:menuKey},
//         success: function( result ) {
//             setMenuLangsOnForm( result.resultData );
//         },
//         error: function(jqXHR, textStatus) {
      	  
//         }
//       });
//     }
    
//     function evClickSaveMenuLangs() {
//     	jQuery('#cfLangsModal').modal('hide');
    	
//     	jQuery.ajax({
//           url : "${bedviewPath}/menu/json/updateMenu.jsp",
//           type : "POST",
//           dataType : "json",
//           data : jQuery("#cfLangsForm").serialize(),
//           success: function( result ) {
//             if(result.resultCode){
//           	  alert("언어 저장에 성공하였습니다.");
//             } else {
//           		alert("언어 저장에 실패하였습니다.");
//             }
//             pageReload();
//           },
//           complete: function(jqXHR, textStatus) {
          	
//           }
//       });
//     }
    
    function evClickMenuContent( menuKey ){
//     		oEditors.getById["content"].exec("MSG_EDITING_AREA_RESIZE_STARTED", []);
        oEditors.getById["content"].exec("LOAD_CONTENTS_FIELD");
        jQuery("#content_menu_id").val(menuKey);
        
        jQuery.ajax({
            url : "${bedviewPath}/menu/json/contentInfo.jsp",
            type : "get",
            dataType : "json",
            data : "menu_id="+menuKey,
            success: function( result ) {
              var resultCode = result.resultCode;
              if(resultCode){
            	  setMenuContentOnForm( result.resultData );
              } else {
            		alert("상세 정보를 가져오는데 실패하였습니다.");
              }
            },
            error: function(jqXHR, textStatus) {
            	
            }
        });
    }
    
    
       
    function evClickSaveContent() {
      oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
      
      if( !validate("content") ) {
          return;
      }
      
      var url = "${bedviewPath}/menu/json/insertMenuContent.jsp";
      if(jQuery("#content_id").val()) url = "${bedviewPath}/menu/json/updateMenuContent.jsp";
      
      // 에디터의 내용에 대한 값 검증은 이곳에서
      // document.getElementById("textAreaContent").value를 이용해서 처리한다.
      
      jQuery.ajax({
          url : url,
          type : "POST",
          dataType : "json",
          data : jQuery("#cfContentForm").serialize(),
          success: function( result ) {
            if(result.resultCode){
          	  alert("상세정보 저장에 성공하였습니다.");
            } else {
          		alert("상세정보 저장에 실패하였습니다.");
            }
            location.reload();
          },
          complete: function(jqXHR, textStatus) {
          	jQuery('#cfContentModal').modal('show');
          }
      });
      
    }
    
    function post_to_url(path, params, method) {
        method = method || "post"; // Set method to post by default, if not specified.
        // The rest of this code assumes you are not using a library.
        // It can be made less wordy if you use one.
        var form = document.createElement("form");
        form.setAttribute("method", method);
        form.setAttribute("action", path);
        for(var key in params) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);
            form.appendChild(hiddenField);
        }
        document.body.appendChild(form);
        form.submit();
    }
    
    function evClickChildMenu(idx, name) {
    	post_to_url('childMenu.jsp', {'pid':idx, 'menu_nm':name});
    }

//       function evClickAddContent(){
//         oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
//         jQuery("#cfContentForm").attr("action","prcInsertContent.jsp");
//         submitForm();
//       }
//       function evClickModifiedContent(){
//         oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
//         submitForm();
//       }
    
    function setMenuOnForm( data ) {
    	  jQuery("#menu_id").val(data.menu_id);
        jQuery("#menu_nm").val(data.menu_nm);
        jQuery("#menu_type").val(data.menu_type);
        jQuery("#file_id").val(data.file_id);
        jQuery("#cfIconImg").attr("src", data.icon_url);
        
        jQuery("#cfMenuModal").modal('show');
    }

//     function setMenuLangsOnForm( data ) {
//   	  jQuery("#langs_menu_id").val(data.menu_id);
//       jQuery("#lang_eng").val(data.lang_eng);
//       jQuery("#lang_chi").val(data.lang_chi);
//       jQuery("#lang_jap").val(data.lang_jap);
//       jQuery("#lang_rus").val(data.lang_rus);
      
//       jQuery("#cfLangsModal").modal('show');
//   	}
    
    function setMenuContentOnForm( data ) {
    	if(Object.keys(data).length > 0) {
    		oEditors.getById["content"].exec("PASTE_HTML", [data.content]);
 	      jQuery('#content_id').val(data.content_id);
    	}
      jQuery("#cfContentModal").modal('show');
    }
    
    function validate(type) {
      if( !document.getElementById("content").value && type == "content" ) {
      	  alert("내용을 입력하세요");
      	  return false;
      }
      if( !jQuery("#menu_nm").val() && type == "menu" ) {
      	  alert("메뉴 이름을 입력하세요");
      	  return false;
      }
        
        return true;
    }
    
    function readURL(input) {
  	  if(input.files.length == 1) {
  		  var reader = new FileReader();
  		  reader.addEventListener("load", function() {
  			  jQuery("#cfIconImg").attr("src", reader.result);
  		  }, false);
  		  
  		  reader.readAsDataURL(input.files[0]);
  		  
  		  reader.onerror = function(err) {
  			  var errcode = err.targer.error.code;
  			  if(errcode == 1) {
  				  alert("File Not Found");
  			  } else if(errcode == 2) {
  				  alert("File Not Safe Or File Changed");
  			  } else if(errcode == 3) {
  				  alert("Stop Reading File");
  			  } else if(errcode == 4) {
  				  alert("Cannot Reading for Access Authority");
  			  } else {
  				  alert("URL Size Limit Problem");
  			  }
   		  };
  	  }
    }
    
    function pageReload() {
    	
    	jQuery("#s_page_no").val(jQuery("#mainDataTable").DataTable().page.info().page);
  		jQuery("#searchForm").submit();
    }
     
    jQuery(function(){
    	smartEditor();
    	
    	jQuery(".cf-switch").click(function(e) {
    		 e.preventDefault();
//     		var switcher = jQuery(this);
//     		if(jQuery(switcher).val() == "N") {
//     			jQuery(switcher).val("Y");
//     		} else {
//     			jQuery(switcher).val("N");
//     		}
//     		jQuery.ajax({
//             url : "${bedviewPath}/menu/json/updateChildUseFg.jsp",
//             type : "get",
//             cache : false,
//             dataType : "json",
//             data : {"menu_id":jQuery(this).attr("menuIdx"),"child_use_fg":jQuery(switcher).val()},
//             success: function( result ) {
//               if(result.resultCode){
//           			jQuery(switcher).closest("td").children("p").toggle();
//               }else{
//             	  if(jQuery(switcher).val() == "N") {
// 	          			jQuery(switcher).val("Y");
// 	          		} else {
// 	          			jQuery(switcher).val("N");
// 	          		}
//               }
//             }
//         });
    		
    	});
    });
    </script>
</head>

<body>

      <div class="be-content">
        <div class="page-head">
          <h2 class="page-head-title">상위메뉴 관리</h2>
          <ol class="breadcrumb page-head-nav">
            <li><a href="#">침상용 관리 메뉴</a></li>
            <li class="active">메뉴 관리</li>
          </ol>
        </div>

        <div class="main-content container-fluid">
<!--           <div class="cf-search-area"> -->
<!--           	<form id="searchForm" method="POST" action="index.jsp"> -->
<!--           		<input type="hidden" id="s_page_no" name="page_no"> -->
<!--           		<div class="row"> -->
<!-- 	                <div class="col-xs-12 col-sm-12 text-right"> -->
<!-- 	                  <button type="button" class="btn btn-space btn-primary cf-mobile-btn" onclick="evClickAdd()">메뉴 추가</button> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<!--           	</form> -->
<!--           </div> -->
          
          <div class="row">
            <div class="col-sm-12">
              <div class="panel panel-default panel-table">
                <div class="panel-body">
                  <table id="mainDataTable" class="table table-striped table-hover table-fw-widget">
                    <thead>
                      <tr class="text-center">
                        <th class="text-center">No.</th>
                        <th class="text-center">메뉴명</th>
                        <th class="text-center">메뉴타입</th>
<!--                         <th class="text-center">언어 설정</th> -->
                        <th class="text-center">상세 내용</th>
                        <th class="text-center">하위메뉴</th>
                        <th class="text-center">하위메뉴 연결상태</th>
<!--                         <th class="text-center">메뉴삭제</th> -->
                      </tr>
                    </thead>
                    <tbody>
  <c:forEach var="data" items="${resultMap.list}" varStatus="status">
                      <tr class="text-center">
                        <td>${status.count}</td>
<%--                         <td><a href="javascript:evClickRow('${data.menu_id}')">${data.menu_nm}</a></td> --%>

                        <td>${data.menu_nm}</td>
<%--                         <td><img src="${data.icon_url}" style="max-width:100px;"></td> --%>
                        <td>
                        	<c:choose>
                        		<c:when test="${data.menu_type == 0}">
															기본
														</c:when>
														<c:when test="${data.menu_type ==  1}">
															호출용
														</c:when>
														<c:when test="${data.menu_type ==  2}">
															식단용
														</c:when>
														<c:otherwise>
															TV시청용
														</c:otherwise>
                        	</c:choose>
                        </td>
<%--                         <td><button class="btn btn-success" onclick="evClickMenuLangs(${data.menu_id})">보기</button></td> --%>
                        
                        
                        <c:if test="${data.child_use_fg ne 'Y'}">
	                        <c:if test="${data.menu_type == 0}">
	                        	<td><button class="btn btn-success" onclick="evClickMenuContent(${data.menu_id})">설정</button></td>
	                        </c:if>
	                        <c:if test="${data.menu_type != 0}">
	                        	<td></td>
	                        </c:if>
                        	<td></td>
                        </c:if>
                        <c:if test="${data.child_use_fg eq 'Y'}">
	                        <td></td>
	                        <td><button class="btn btn-success" onclick="evClickChildMenu(${data.menu_id},'${data.menu_nm}')">메뉴</button></td>
                        </c:if>
                        <td>
                        	<label class="switch">
                        	<c:if test="${data.child_use_fg eq 'Y'}">
													  <input class="cf-switch" name="child_use_fg" type="checkbox" value="Y" menuIdx="${data.menu_id}" checked>
                        	</c:if>
                        	<c:if test="${data.child_use_fg eq 'N'}">
													  <input class="cf-switch" name="child_use_fg" type="checkbox" value="N" menuIdx="${data.menu_id}">
                        	</c:if>
													  <span class="slider round"></span>
													</label>
													<c:if test="${data.child_use_fg eq 'Y'}">
														<p style="display:none;">OFF</p><p>ON</p>
													</c:if>
													<c:if test="${data.child_use_fg eq 'N'}">
														<p>OFF</p><p style="display:none;">ON</p>
													</c:if>
												</td>
<%--                         <td><button class="btn btn-danger" onclick="evClickDelete(${data.menu_id})">삭제</button></td> --%>
                      </tr>
  </c:forEach>
                    </tbody>
                  </table>
                </div><!-- /.panel-body -->
              </div><!-- /.panel -->
            </div><!-- /.col-sm-12 -->
          </div><!-- /.row -->

        </div><!-- /.main-content -->
      </div><!-- /.be-content -->

    <!--Form Modals-->
    <div id="cfMenuModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfMenuForm" name="cfMenuForm" method="POST" enctype="multipart/form-data">
				  <input type="hidden" id="menu_id" name="menu_id">
				  <input type="hidden" id="file_id" name="file_id">
				  <input type="hidden" id="pid" name="pid" value="0">
				  <input type="hidden" id="page_no" name="page_no">
			  
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">컨텐츠  이름</h3>
	          </div>
	          <div class="modal-body">
	            <div class="form-group">
	              <label>메뉴명</label>
	              <input type="text" class="form-control" name="menu_nm" id="menu_nm" value="" >
	            </div>
	            <div class="form-group">
	              <label>메뉴타입</label>
	              <select class="form-control" id="menu_type" name="menu_type">
	              	<option value="0">기본</option>
	              	<option value="1">식단용</option>
	              	<option value="2">호출용</option>
	              	<option value="3">TV시청용</option>
	              </select>
	            </div>
	            <div class="form-group">
	              <label>메뉴 아이콘</label>
	              <input type="file" class="form-control" name="uploadFile" id="uploadFile" onchange="readURL(this)" accept="image/jpg, image/jpeg, image/png">
	              <img id="cfIconImg" style="max-height:200px; max-width:300px; margin-top:30px;">
	            </div>
	          </div>
	          <div class="modal-footer">
	            <button type="button" data-dismiss="modal" class="btn btn-default md-close">취소</button>
	            <button type="button" id="cfMenuBtn" class="btn btn-success" onclick="evClickSaveMenu()">저장</button>
	          </div>
	          
	        </div>
        </form>
      </div>
    </div>
		
		<div id="cfLangsModal" tabindex="-1" role="dialog" class="modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfLangsForm" name="mainForm" method="POST">
   			  <input type="hidden" id="langs_menu_id" name="menu_id"/>
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">언어 정보</h3>
	          </div>
	          <div class="modal-body" style="min-height:500px">
		          <div class="form-group">
	              <label>영어</label>
	              <input type="text" class="form-control" name="lang_eng" id="lang_eng">
	            </div>
		          <div class="form-group">
	              <label>중국어</label>
	              <input type="text" class="form-control" name="lang_chi" id="lang_chi">
		          </div>
		          <div class="form-group">
	              <label>일본</label>
	              <input type="text" class="form-control" name="lang_jap" id="lang_jap">
		          </div>
		          <div class="form-group">
	              <label>러시아</label>
	              <input type="text" class="form-control" name="lang_rus" id="lang_rus">
		          </div>
	          </div>
	          <div class="modal-footer">
	            <button type="button" data-dismiss="modal" class="btn btn-default md-close">취소</button>
	            <button type="button" class="btn btn-success" onclick="evClickSaveMenuLangs()">저장</button>
	          </div>
	          
	        </div>
        </form>
      </div>
    </div>
    
    <div id="cfContentModal" tabindex="-1" role="dialog" class="modal-view modal fade colored-header colored-header-primary">
      <div class="modal-dialog custom-width">
        <form id="cfContentForm" name="mainForm" method="POST">
       		<input type="hidden" id="content_id" name="content_id" />
   			  <input type="hidden" id="content_menu_id" name="menu_id"/>
				
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><span class="mdi mdi-close"></span></button>
	            <h3 class="modal-title">컨텐츠 정보</h3>
	          </div>
	
	          <div class="modal-body" style="min-height:500px">
	              <label>내용</label>
                <textarea name="content" id="content" rows="10" cols="100" style="width:100%; height:412px;"> </textarea>
	          </div>
	          
	          <div class="modal-footer">
	            <button type="button" data-dismiss="modal" class="btn btn-default md-close">취소</button>
	            <button type="button" class="btn btn-success" onclick="evClickSaveContent()">저장</button>
	          </div>
	          
	        </div>
        </form>
      </div>
    </div>

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
      jQuery(function(){
        //initialize the javascript
        App.init();
        setMainDataTable('#mainDataTable');
        var pageNo = "${paramMap.page_no}";
        if(pageNo != "") {
        	jQuery("#mainDataTable").dataTable().fnPageChange(${paramMap.page_no});
        }
      });
    </script>

</body>