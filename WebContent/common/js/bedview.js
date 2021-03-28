var jssor_1_slider;
function jssor_1_slider_init() {

  var jssor_1_SlideoTransitions = [
    [{b:-1,d:1,o:-0.7}],
    [{b:900,d:2000,x:-379,e:{x:7}}],
    [{b:900,d:2000,x:-379,e:{x:7}}],
    [{b:-1,d:1,o:-1,sX:2,sY:2},{b:0,d:900,x:-171,y:-341,o:1,sX:-2,sY:-2,e:{x:3,y:3,sX:3,sY:3}},{b:900,d:1600,x:-283,o:-1,e:{x:16}}]
  ];

  var jssor_1_options = {
    $AutoPlay: 1,
    $SlideDuration: 800,
    $SlideEasing: $Jease$.$OutQuint,
    $CaptionSliderOptions: {
      $Class: $JssorCaptionSlideo$,
      $Transitions: jssor_1_SlideoTransitions
    },
    $ArrowNavigatorOptions: {
      $Class: $JssorArrowNavigator$
    },
    $BulletNavigatorOptions: {
      $Class: $JssorBulletNavigator$
    }
  };

  jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

  /*#region responsive code begin*/

  var MAX_WIDTH = 3000;
  var MAX_HEIGHT = 3000;
  var MAX_BLEEDING = 0.128;
  function ScaleSlider() {
      var containerElement = jssor_1_slider.$Elmt.parentNode;
      var containerWidth = containerElement.clientWidth;

      if (containerWidth) {
        var originalWidth = jssor_1_slider.$OriginalWidth();
        var originalHeight = jssor_1_slider.$OriginalHeight();

        var containerHeight = containerElement.clientHeight || originalHeight;

        var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);
        var expectedHeight = Math.min(MAX_HEIGHT || containerHeight, containerHeight);

        //scale the slider to expected size
        jssor_1_slider.$ScaleSize(expectedWidth, expectedHeight, MAX_BLEEDING);

        //position slider at center in vertical orientation
        jssor_1_slider.$Elmt.style.top = ((containerHeight - expectedHeight) / 2) + "px";

        //position slider at center in horizontal orientation
        jssor_1_slider.$Elmt.style.left = ((containerWidth - expectedWidth) / 2) + "px";
      }
      else {
          window.setTimeout(ScaleSlider, 30);
      }
  }

  ScaleSlider();

  $Jssor$.$AddEvent(window, "load", ScaleSlider);
  $Jssor$.$AddEvent(window, "resize", ScaleSlider);
  $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
  /*#endregion responsive code end*/
};

function jssor_1_slider_stop(){
    jssor_1_slider.$Pause();
}

function jssor_1_slider_start(){
    jssor_1_slider.$Play();
}

function showTv() {
  window.MtvAndroidApp.executeType("iptv");
};
function openInternet() {
    window.MtvAndroidApp.executeType("internet");
};
function showEvacuation(){
  $(".modal-info").modal();
};
function showMap(){
  $(".modal-info").modal();
};
function movePage( page ){
  if(page == "map") {
    showMap();
    return false;
  }
  if(page == "evacuation"){
    showEvacuation();
    return false;
  } 
  
  var url = "./"+ page +".jsp";
  location.href = url;
};

function showDateTime( lang ) {

  var weekday = new Array(7);
  var strYear = "";
  var strMonth = "";
  var strDay = "";
  if(lang == "" || lang == null){
    weekday[0]=  "월";
    weekday[1] = "화";
    weekday[2] = "수";
    weekday[3] = "목";
    weekday[4] = "금";
    weekday[5] = "토";
    weekday[6] = "일";
  }
  if(lang == "eng" ){
    weekday[0]=  "월";
    weekday[1] = "화";
    weekday[2] = "수";
    weekday[3] = "목";
    weekday[4] = "금";
    weekday[5] = "토";
    weekday[6] = "일";
  }
  if(lang == "chi" ){
    weekday[0]=  "월";
    weekday[1] = "화";
    weekday[2] = "수";
    weekday[3] = "목";
    weekday[4] = "금";
    weekday[5] = "토";
    weekday[6] = "일";
  }
  if(lang == "jap" ){
    weekday[0]=  "월";
    weekday[1] = "화";
    weekday[2] = "수";
    weekday[3] = "목";
    weekday[4] = "금";
    weekday[5] = "토";
    weekday[6] = "일";
  }
  if(lang == "rus" ){
    weekday[0]=  "월";
    weekday[1] = "화";
    weekday[2] = "수";
    weekday[3] = "목";
    weekday[4] = "금";
    weekday[5] = "토";
    weekday[6] = "일";
  }

  var d = new Date()
  var strDateTime = "";
  strDateTime = ""
    + d.getFullYear() + "년 " + (d.getMonth()+1) + "월 " + d.getDate() +  "일 "
    + "(" +  weekday[d.getDay()] + ") "
    + d.getHours() + "시 " + d.getMinutes() + "분 " ;
  console.log(strDateTime)
  $('#dateTime').html(strDateTime);
  setTimeout(showDateTime, 30000);
};