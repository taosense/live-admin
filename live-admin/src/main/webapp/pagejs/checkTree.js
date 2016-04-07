// 树配置
var setting = {
	view : {
		selectedMulti : true
	},
	check : {
		enable : true
	},
	data : {
		simpleData : {
			enable : true,
			idKey : "id",
			pIdKey : "parentId",
			rootPId : 0
		}
	},
	callback : {
		onCheck : onCheck
	}
};

// ztree节点checkBox选中后的回调函数
function onCheck(e, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	var zTreeCheckedList = zTree.getCheckedNodes(true);
	var checkedNameArr = [];
	var checkedIdArr = [];

	$.each(zTreeCheckedList, function(k, value) {
		checkedNameArr.push(value.name);
		checkedIdArr.push(value.id);
	});
	var checkedIdStr = checkedIdArr.join();
	var checkedNameStr = checkedNameArr.join();

	$("#organIds").val(checkedIdStr);
	$("#ztreeValText").val(checkedNameStr).attr("title", checkedNameStr);
}

$(document).ready(
		function() {
			if ($(".ztreeWrap").length != 0) {

				// ztreeShowMenu显示隐藏
				$(".ztreeShowBtn").on('click', function() {
					$(".ztreeShowMenu").toggle();
					return false;
				});

				// 点击旁边关闭ztreeShowMenu
				$("body").on('click', function(e) {
					if (($(".ztreeShowMenu").find(e.target)).length == 0) {
						$(".ztreeShowMenu").hide();
					}
				});

				$.getJSON("commons/json/organization_index_data.json",
						function(result) {
							var zNodes = result;
							$.fn.zTree.init($("#treeDemo"), setting, zNodes);

							// 根据id赋值
							var treeIdArr = $("#organIds").val().split(",");
							var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
							var treeNameArr = [];
							for (var i = 0; i < treeIdArr.length; i++) {
								var nodeObj = treeObj.getNodeByParam("id",
										treeIdArr[i]);
								if (nodeObj) {
									treeNameArr.push(nodeObj.name);
									treeObj.checkNode(nodeObj, true);
								}
							}
							var treeNameStr = treeNameArr.join();
							$("#ztreeValText").val(treeNameStr).attr("title",
									treeNameStr);
						});
			}
		});
