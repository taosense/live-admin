function overLayer(oper, info, time, dataType) {
	var obj = bootbox;
	if (dataType != null && dataType == 1) {
		obj = window.parent.bootbox;
	} else if (dataType != null && dataType == 2) {
		obj = window.parent.parent.bootbox;
	}
	var showTime = 500;
	if (time != null) {
		if (time == 0) {
			obj.hideAll();
			return;
		} else {
			showTime = time;
		}
	}
	var showInfo = '';
	if (oper == 'warning') {
		showInfo = '正在处理，请稍后...';
		if (info != null) {
			showInfo = info;
		}
		obj.dialog({
			message : '<i class="ace-icon fa fa-spinner"></i>  ' + showInfo
		});
		if (dataType != null && dataType == 1) {

			$(".bootbox-close-button", window.parent.document).hide();

			$(".modal-content:not(.lay)", window.parent.document).addClass(
					"btn-lg");
			$(".modal-content:not(.lay)", window.parent.document).removeClass(
					"btn-success").removeClass("btn-danger",
					window.parent.document).addClass("btn-warning");
		} else if (dataType != null && dataType == 2) {
			$(".bootbox-close-button", window.parent.parent.document).hide();

			$(".modal-content:not(.lay)", window.parent.parent.document)
					.addClass("btn-lg");
			$(".modal-content:not(.lay)", window.parent.parent.document)
					.removeClass("btn-success").removeClass("btn-danger",
							window.parent.parent.document).addClass(
							"btn-warning");
		} else {

			$(".bootbox-close-button").hide();

			$(".modal-content:not(.lay)").addClass("btn-lg");
			$(".modal-content:not(.lay)").removeClass("btn-success")
					.removeClass("btn-danger").addClass("btn-warning");
		}
	} else if (oper == 'success') {
		showInfo = '操作成功';
		if (info != null) {
			showInfo = info;
		}
		if (dataType != null && dataType == 1) {

			$(".modal-content:not(.lay)", window.parent.document).removeClass(
					"btn-warning").addClass("btn-success");
			$(".bootbox-body", window.parent.document).html(
					"<i class='ace-icon fa fa-check'></i>  " + showInfo);
			window.parent.setTimeout(function() {
				obj.hideAll();
			}, showTime);
		} else if (dataType != null && dataType == 2) {
			$(".modal-content:not(.lay)", window.parent.parent.document)
					.removeClass("btn-warning").addClass("btn-success");
			$(".bootbox-body", window.parent.parent.document).html(
					"<i class='ace-icon fa fa-check'></i>  " + showInfo);
			window.parent.parent.setTimeout(function() {
				obj.hideAll();
			}, showTime);
		} else {
			$(".modal-content:not(.lay)").removeClass("btn-warning").addClass(
					"btn-success");
			$(".bootbox-body").html(
					"<i class='ace-icon fa fa-check'></i>  " + showInfo);

		}
		window.setTimeout(function() {
			obj.hideAll();
		}, showTime);
	} else {
		showInfo = '操作失败';
		if (info != null) {
			showInfo = info;
		}
		if (dataType != null && dataType == 1) {

			$(".bootbox-body", window.parent.document).html(
					"<i class='ace-icon fa fa-exclamation-triangle'></i>  "
							+ showInfo);
			$(".bootbox-close-button", window.parent.document).show();
			$(".modal-content:not(.lay)", window.parent.document).removeClass(
					"btn-warning").addClass("btn-danger");
		} else if (dataType != null && dataType == 2) {
			$(".bootbox-body", window.parent.parent.document).html(
					"<i class='ace-icon fa fa-exclamation-triangle'></i>  "
							+ showInfo);
			$(".bootbox-close-button", window.parent.parent.document).show();
			$(".modal-content:not(.lay)", window.parent.parent.document)
					.removeClass("btn-warning").addClass("btn-danger");
		} else {
			$(".bootbox-body").html(
					"<i class='ace-icon fa fa-exclamation-triangle'></i>  "
							+ showInfo);
			$(".bootbox-close-button").show();
			$(".modal-content:not(.lay)").removeClass("btn-warning").addClass(
					"btn-danger");

		}
	}
}