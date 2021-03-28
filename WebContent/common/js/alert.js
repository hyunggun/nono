function floatAlertArea(title, msg, button) {
	jQuery("#cfAlertBox").children(".cf-alert-header").html(title);
	jQuery("#cfAlertBox").children(".cf-alert-body").html(msg);
	jQuery("#cfAlertBox").children(".cf-alert-btnbox").children(".cf-alert-btn").html(button);
	
	jQuery("#cfAlertArea").show();
	
	setTimeout(function() {
		jQuery("#cfAlertArea").hide();
	}, 3000);
}

function evClickDialog(result) {
	if(result == "no") {
		jQuery("#cfConfirmArea").hide();
		updateStatus(jQuery("#cfConfirmStatus").val());
		return;
	}
	
	jQuery.ajax({
		url : "ajax/ajaxUpdateStatus.jsp",
		type : "post",
		cache : false,
		dataType : "json",
		data : {treatment_id:jQuery("#cfConfirmId").val(), status:"F"},
		success: function( result ) {
		    if(result.resultCode == "success") {
		    	jQuery("#cfConfirmArea").hide();
		    	updateStatus(jQuery("#cfConfirmStatus").val());
		    } else {
		    	floatAlertArea("진료상태 정보 변경", "진료중인 환자를 진료완료로 변경하는데 실패하였습니다.", "확인");
		    }
		},
		error: function(request,status,error) {
		},
		complete: function(jqXHR, textStatus) {
		}
	});
}