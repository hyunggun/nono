var App = (function () {
	'use strict';

  App.textEditors = function( ){

    //Summernote
    $('#msg').summernote({
    	height:300,
    	lang:'ko-KR'
    });
    
  };

  return App;
})(App || {});
