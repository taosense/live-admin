function checkIps(ips) {
	if (ips.length == 0) {
		return true;
	}
	// var exp =
	// /^([1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.){2}([1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/;
	var exp = /^(0|[1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.((0|[0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.){2}(0|[1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])((,)(0|[1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.((0|[0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.){2}(0|[1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))*$/;
	var reg = ips.match(exp);
	if (reg == null) {
		return false;
	}
	return true;
}
function replaceSplit(str,beforeFlag,afterFlag){
	var reg=new RegExp(beforeFlag,"g"); //创建正则RegExp对象  
	str = str.replace(reg,afterFlag);  
    return str;
}
function checkIp(ip) {
	if (ip.length == 0) {
		return true;
	}
	var exp = /^(0|[1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.((0|[0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.){2}(0|[1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/;
	return exp.test(ip);
}
function checkMobiles(mobiles) {
	
	var pattern = /^(0?(13|14|15|17|18)[0-9]{9})((,)(0?(13|14|15|17|18)[0-9]{9}))*$/;
	var reg = mobiles.match(pattern);
	if (reg == null) {
		return false;
	}
	return true;
}
function checkPwd(pwd) {
	var exp = /[0-9a-zA-Z]{8,20}/;
	// var exp = /(?!^\d+$)(?!^[a-zA-Z]+$)[0-9a-zA-Z]{8,20}/;
	return exp.test(pwd);
}
function changePlaceHolder(selectId, inputId) {
	if ($("#" + selectId).val() != null) {
		$("#" + inputId).attr("placeholder",
				$('#' + selectId + ' option:selected').text());
	}
}
function checkServer(obj, formId) {
	var th_checked = obj.checked;

	$("#" + formId + " input[type=checkbox][name=serverSelectList]").each(
			function() {
				$(this).prop('checked', th_checked);
			});
}
function getCheckServer(formId) {
	var str = '';
	if ($("#" + formId + " input[name=checkAllBtn]").prop('checked')) {
		$("#" + formId + " input[name=servers]").val("-1");
	} else {
		$("#" + formId + " input[type=checkbox][name=serverSelectList]:checked")
				.each(function() {
					str += $(this).val() + ',';
				});
		if (str.length > 0) {
			$("#" + formId + " input[name=servers]").val(
					str.substring(0, str.length - 1));
		} else {
			$("#" + formId + " input[name=servers]").val(str);
		}
	}

}
function checkAllServerStatus(formId, size) {

	if ($("#" + formId + " input[type=checkbox][name=serverSelectList]:checked")
			.size() == size) {
		$("#" + formId + " input[name=checkAllBtn]").prop('checked', true);
	} else {
		$("#" + formId + " input[name=checkAllBtn]").prop('checked', false);
	}
}
function checkApp(obj, formId) {
	var th_checked = obj.checked;

	$("#" + formId + " input[type=checkbox][name=appSelectList]").each(
			function() {
				$(this).prop('checked', th_checked);
			});
}
function getCheckApp(formId) {
	var str = '';
	if ($("#" + formId + " input[name=checkAllBtn]").prop('checked')) {
		$("#" + formId + " input[name=appSelectStr]").val("-1");
	} else {
		$("#" + formId + " input[type=checkbox][name=appSelectList]:checked")
				.each(function() {
					str += $(this).val() + ',';
				});
		if (str.length > 0) {
			$("#" + formId + " input[name=appSelectStr]").val(
					str.substring(0, str.length - 1));
		} else {
			$("#" + formId + " input[name=appSelectStr]").val(str);
		}
	}

}
function checkAllStatus(formId, size) {
	if ($("#" + formId + " input[type=checkbox][name=appSelectList]:checked")
			.size() == size) {
		$("#" + formId + " input[name=checkAllBtn]").prop('checked', true);
	} else {
		$("#" + formId + " input[name=checkAllBtn]").prop('checked', false);
	}
}
function checkSelect(value, initFlag) {
	if (value == '') {
		value = 2;
	}
	if (value == 1 || value == 4) {
		$("#sKey").hide();
		if (value == 1) {
			$("#selectedId_publishType").show();
			$("#selectedId_serverGroups").hide();
		} else {
			$("#selectedId_publishType").hide();
			$("#selectedId_serverGroups").show();
		}
		if (initFlag) {
			if ($("#sKey").val() != '') {
				if (value == 1) {
					$("#selectedId_publishType").val($("#sKey").val());
				} else {
					$("#selectedId_serverGroups").val($("#sKey").val());
				}
				$("#sKey").val("");
			}
		}
	} else {
		$("#selectedId_publishType").hide();
		$("#selectedId_serverGroups").hide();
		$("#sKey").show();
	}
}
function checkSkey() {
	if ($("#stype").val() == 1) {
		$("#sKey").val($("#selectedId_publishType").val());
	} else if ($("#stype").val() == 4) {
		$("#sKey").val($("#selectedId_serverGroups").val());
	}
}
function isPositiveNum(s) {// 是否为正整数
	var re = /^[0-9]*[1-9][0-9]*$/;
	return re.test(s)
}
function format2JSON(txt, compress/* 是否为压缩模式 */) {/* 格式化JSON源码(对象转换为JSON文本) */
	var indentChar = '    ';
	if (/^\s*$/.test(txt)) {
		alert('数据为空,无法格式化! ');
		return;
	}
	try {
		var data = eval('(' + txt + ')');
	} catch (e) {
		alert('数据源语法错误,格式化失败! 错误信息: ' + e.description, 'err');
		return;
	}
	;
	var draw = [], last = false, This = this, line = compress ? '' : '\n', nodeCount = 0, maxDepth = 0;

	var notify = function(name, value, isLast, indent/* 缩进 */, formObj) {
		nodeCount++;/* 节点计数 */
		for (var i = 0, tab = ''; i < indent; i++)
			tab += indentChar;/* 缩进HTML */
		tab = compress ? '' : tab;/* 压缩模式忽略缩进 */
		maxDepth = ++indent;/* 缩进递增并记录 */
		if (value && value.constructor == Array) {/* 处理数组 */
			draw.push(tab + (formObj ? ('"' + name + '":') : '') + '[' + line);/*
																				 * 缩进'['
																				 * 然后换行
																				 */
			for (var i = 0; i < value.length; i++)
				notify(i, value[i], i == value.length - 1, indent, false);
			draw.push(tab + ']' + (isLast ? line : (',' + line)));/* 缩进']'换行,若非尾元素则添加逗号 */
		} else if (value && typeof value == 'object') {/* 处理对象 */
			draw.push(tab + (formObj ? ('"' + name + '":') : '') + '{' + line);/*
																				 * 缩进'{'
																				 * 然后换行
																				 */
			var len = 0, i = 0;
			for ( var key in value)
				len++;
			for ( var key in value)
				notify(key, value[key], ++i == len, indent, true);
			draw.push(tab + '}' + (isLast ? line : (',' + line)));/* 缩进'}'换行,若非尾元素则添加逗号 */
		} else {
			if (typeof value == 'string')
				value = '"' + value + '"';
			draw.push(tab + (formObj ? ('"' + name + '":') : '') + value
					+ (isLast ? '' : ',') + line);
		}
		;
	};
	var isLast = true, indent = 0;
	notify('', data, isLast, indent, false);
	return draw.join('');
}
function json2str(jsonObj) {
	var jStr = "{ ";
	for ( var item in jsonObj) {
		jStr += "'" + item + "':'" + jsonObj[item] + "',";
	}
	jStr += " }";
	return jStr;
}
function formatAdd() {
	try {
		JSON.parse($('#aval').val());
	} catch (e) {
		alert("不正确的JSON格式");
		return;
	}
	$('#aval').val(format2JSON($('#aval').val(), false));
	formatAddRef();
	return false;
}
function formatModRef() {
	$id('test-j').innerHTML = "<PRE class='CodeContainer'>"
			+ Process($('#appEdit_value').val()) + "</PRE>";
}
function formatAddRef() {
	$id('test-j-add').innerHTML = "<PRE class='CodeContainer'>"
			+ Process($('#aval').val()) + "</PRE>";
}
function formatMod() {
	try {
		JSON.parse($('#appEdit_value').val());
	} catch (e) {
		alert("不正确的JSON格式");
		return;
	}
	$('#appEdit_value').val(format2JSON($('#appEdit_value').val(), false));
	formatModRef();
	return false;
}
function hideTr(id) {
	$("#tr-" + id).removeAttr("rel");
	$("#" + id).removeAttr("rel");
	$("#tr-" + id).hide();
}

function changeSelect(id) {
	jQuery.ajax({
		url : "menu?statisticType=" + id,
		type : 'POST',
		async : false,
		success : function(result) {
			$("#selectedId").empty();
			$("#selectedId").append("<option value='-1'>全部</option>");
			for (var i = 0; i < result.length; i++) {
				$("#selectedId").append(
						"<option value='" + result[i].id + "'>"
								+ result[i].name + "</option>");
			}
		}
	});
}
