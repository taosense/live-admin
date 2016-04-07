<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>角色管理</title>
<link rel="stylesheet"
	href="http://zhibo.news.cn/rlnbj/dist/css/bootstrap-duallistbox.min.css" />
</head>
<body>

	<div class="row">
		<div class="col-xs-12">
			<div>
				<div id="dynamic-table_wrapper"
					class="dataTables_wrapper form-inline no-footer">
					<div class="row">
						<div class="col-xs-2">
							<lable class="pink"> <i class="ace-icon fa fa-plus green"></i>
							<a href="#roleadd-modal" role="button" class="blue"
								data-toggle="modal" data-target="#roleadd-modal">新增角色</a> </lable>
						</div>
						<div class="col-xs-8">
							<div class="dataTables_length">
								<label class="right"> <input type="search"
									class="form-control input-sm" placeholder="名称" id="keyword"
									aria-controls="dynamic-table" value="${keyword }">
								</label> <label style="padding-left: 10px;">
									<button id="searchBtn" class="left">
										<span><i class="fa fa-search"></i></span>
									</button>
								</label>
							</div>
						</div>
						<div class="col-xs-2">
							<div id="dynamic-table_filter" class="dataTables_filter">
								<div class="hidden-sm hidden-xs action-buttons">
									<a class="red" href="javascript:batchOper('200')" title="批量删除">
										<i class="ace-icon fa fa-trash-o bigger-150"></i>
									</a>
								</div>
							</div>
						</div>
					</div>
					<table id="simple-table"
						class="table table-striped table-bordered table-hover dataTable no-footer DTTT_selectable">
						<thead>
							<tr>
								<th class="center"><label class="pos-rel"> <input
										type="checkbox" class="ace" /> <span class="lbl"></span>
								</label></th>
								<th>名称</th>
								<th>描述</th>

								<th><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>
									创建时间</th>
								<th><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>
									更新时间</th>
								<th>操作</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="role" items="${pager.results}">
								<tr>
									<td class="center"><label class="pos-rel"> <input
											type="checkbox" id="${role.id}" rel="check" class="ace" /> <span
											class="lbl"></span>
									</label></td>

									<td>${role.name}</td>
									<td>${role.description}</td>
									<td><span name="dateForm" data-date="${role.createdAt}"
										class="label label-sm label-warning"></span></td>
									<td><span name="dateForm" data-date="${role.updatedAt}"
										class="label label-sm label-warning"></span></td>


									<td>
										<div class="hidden-sm hidden-xs action-buttons">
											<a class="green pointer"
												onclick="editRole('${role.id}','${role.name}','${role.description}')"
												data-toggle="modal" data-target="#roleEdit-modal"
												title="修改角色"> <i
												class="ace-icon fa fa-pencil bigger-150"></i>
											</a> <a class="blue pointer"
												onclick="assignPermissions('${role.id}')"
												data-toggle="modal" data-target="#assignPermissions-modal"
												title="分配权限"> <i
												class="ace-icon fa fa-plus-circle bigger-150"></i>
											</a> <a class="red pointer" onclick="removeRole('${role.id}')"
												title="删除"> <i class="ace-icon fa fa-trash-o bigger-150"></i>
											</a>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@ include file="../censor_pager.jsp"%>
				</div>
				<!-- /.span -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->

	<!--  遮罩层start -->
	<div id="roleadd-modal" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="smaller lighter blue no-margin">新增角色</h3>
				</div>
				<form id="addForm" action="role/add" method="post">
					<div class="modal-body">

						<table id="info"
							class="table table-striped table-bordered table-hover dataTable no-footer DTTT_selectable">
							<tr>
								<td class=class="col-xs-6col-sm-6">角色名:</td>
								<td><input class="col-xs-12 col-sm-10" type="text"
									name="name" id="addRoleName" /></td>
							</tr>
							<tr>
								<td class="left">中文描述:</td>
								<td><input class="col-xs-12 col-sm-10" type="text"
									name="description" id="addRoleDes" /></td>
							</tr>
						</table>
					</div>

					<div class="modal-footer">
						<button class="btn btn-white btn-default btn-round"
							onclick="addRoleF();return false;">
							<i class="ace-icon fa fa-check red2"></i> 保存
						</button>
						<button class="btn btn-white btn-default btn-round"
							data-dismiss="modal">
							<i class="ace-icon fa fa-times red2"></i> 取消
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="roleEdit-modal" class="modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="smaller lighter blue no-margin">修改角色</h3>
				</div>
				<form id="editForm" action="role/edit" method="post">
					<div class="modal-body">

						<table id="info"
							class="table table-striped table-bordered table-hover dataTable no-footer DTTT_selectable">
							<tr>
								<td class="left">角色名:</td>
								<td><input type="hidden" name="id" id="roleEdit_id" /><input
									class="col-xs-12 col-sm-10" type="text" name="name"
									id="editRoleName" /></td>
							</tr>
							<tr>
								<td class="left">中文描述:</td>
								<td><input class="col-xs-12 col-sm-10" type="text"
									name="description" id="editRoleDes" /></td>
							</tr>
						</table>
					</div>

					<div class="modal-footer">
						<button class="btn btn-white btn-default btn-round"
							onclick="editRoleF();return false;">
							<i class="ace-icon fa fa-check red2"></i> 保存
						</button>
						<button class="btn btn-white btn-default btn-round"
							data-dismiss="modal">
							<i class="ace-icon fa fa-times red2"></i> 取消
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<div id="assignPermissions-modal" class="modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="smaller lighter blue no-margin">分配权限</h3>
				</div>
				<div class="modal-body">
					<input type="hidden" name="id" id="assignP_id" /> <select
						multiple="multiple" size="10" name="duallistbox_permissions"
						id="duallistbox_permissions">
					</select>
				</div>

				<div class="modal-footer">
					<button class="btn btn-white btn-default btn-round"
						onclick="assignPermission()">
						<i class="ace-icon fa fa-check red2"></i> 保存
					</button>
					<button class="btn btn-white btn-default btn-round"
						data-dismiss="modal">
						<i class="ace-icon fa fa-times red2"></i> 取消
					</button>
				</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 遮罩层end -->
	<input type="hidden" name="errorInfo" id="errorInfo"
		value="${errorInfo}" />
</body>
<!-- js 和 css -->
<div id="botton_javascript">
	<script
		src="http://zhibo.news.cn/rlnbj/dist/js/jquery.bootstrap-duallistbox.min.js"></script>
	<script
		src="http://zhibo.news.cn/rlnbj/commons/js/moment-with-locales.js"></script>
	<script src="http://zhibo.news.cn/rlnbj/dist/js/jquery.raty.min.js"></script>

	<script
		src="http://zhibo.news.cn/rlnbj/commons/js/bootstrap-pagination.js"></script>
	<script type="text/javascript">
	   window.onload=function(){
	        if(typeof($("#errorInfo").val()) != "undefined" && $("#errorInfo").val() !=null && $("#errorInfo").val()!="" ){
	            alert($("#errorInfo").val());
	        }
	    }
	   $('#keyword').focus();
	   $('#keyword').bind('keypress',function(event){
		   $("#keyword").val($.trim($("#keyword").val()));
		   if($("#keyword").val().length>0 && event.keyCode == "13"){
			   $("#searchBtn").click();
		   }
       });
	 function addRoleF(){
         var name =$("input[id='addRoleName']").val();
         var description =$("input[id='addRoleDes']").val();
         if(name==null||""==name){
             alert("权限名不能为空!");
         }else if(description==null||""==description){
             alert("权限中文描述不能为空!");
         }else{
             $('#addForm').submit();
         }
         
     }
     
     function editRoleF(){
         var name =$("input[id='editRoleName']").val();
         var description =$("input[id='editRoleDes']").val();
         
         if(name==null||""==name){
             alert("角色名不能为空!");
         }else if(description==null||""==description){
             alert("角色中文描述不能为空!");
         }else{
             $('#editForm').submit();
         }
     }
    
        function batchOper(oper) {
            var ids=new Array();
            $("input[type=checkbox][rel=check]:checked").each(
                  function() {
                      ids.push($(this).attr("id"));
                  });
            if(confirm("确定进行批量删除操作吗？")){
                window.location.href = "role/removeList?ids="+ids;
            }
        }
        
        function assignPermission(){
        	var ids=new Array();
        	$("select[name='duallistbox_permissions_helper2'] > option").each(
        			function(){
        				ids.push($(this).val());
        			});
        	window.location.href="role/assignPermissions?roleId="+$('#assignP_id').val()+"&ids="+ids;
        }
    
        $("#searchBtn").on(ace.click_event, function() {
            window.location.href = "role/all?pageSize=${pager.pageSize}&pageNumber=1&keyword="+$("#keyword").val();
        });
    
        function editRole(id,name,description){
    	    $("#roleEdit_id").val(id);
    	    $("#editRoleName").val(name);
    	    $("#editRoleDes").val(description);
        }
    
        function assignPermissions(id){
        	$("#assignP_id").val(id);
            $('select[name="duallistbox_permissions"]').empty();
            $.getJSON("role/permissions?id="+id, function(data){
                   $.each(data.all, function(name, id){
                	   var nade = new Array();
                       nade = id.split(",");
                       $('select[name="duallistbox_permissions"]').append("<option value="+name+" title="+nade[1]+">"+nade[0]+"</option>");
                   });
                   $('select[name="duallistbox_permissions"]').val(data.selected);
                   $('select[name="duallistbox_permissions"]').bootstrapDualListbox('refresh');
                    // 效果
                    var demo1 = $('select[name="duallistbox_permissions"]').bootstrapDualListbox({infoTextFiltered: '<span class="label label-purple label-lg">Filtered</span>'});
                    var container1 = demo1.bootstrapDualListbox('getContainer');
                    container1.find('.btn').addClass('btn-white btn-info btn-bold');

                    /**var setRatingColors = function() {
                       $(this).find('.star-on-png,.star-half-png').addClass('orange2').removeClass('grey');
                       $(this).find('.star-off-png').removeClass('orange2').addClass('grey');
                    }*/
                    $('.rating').raty({
                       'cancel' : true,
                       'half': true,
                       'starType' : 'i'
                       /**,

                       'click': function() {
                           setRatingColors.call(this);
                       },
                       'mouseover': function() {
                           setRatingColors.call(this);
                       },
                       'mouseout': function() {
                           setRatingColors.call(this);
                       }*/
                    })//.find('i:not(.star-raty)').addClass('grey');
            });

        }

        jQuery(function($) {
        	
        $("span[name='dateForm']").each(function(){
                
            var date = $(this);
            var time = date.attr('data-date');
            if(time!=null && time!=""){
            var dateForm = moment(new Date(time)).locale('zh-cn');
                $(this).html(dateForm.format('LLL'));
            }
        });

        var active_class = 'active';
        $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on(
                'click',
                function() {
                    var th_checked = this.checked;//checkbox inside "TH" table header
                    $(this).closest('table').find('tbody > tr').each(
                            function() {
                                var row = this;
                                if (th_checked)
                                    $(row).addClass(active_class).find(
                                            'input[type=checkbox]').eq(0)
                                            .prop('checked', true);
                                else
                                    $(row).removeClass(active_class).find(
                                            'input[type=checkbox]').eq(0)
                                            .prop('checked', false);
                            });
                });
        $('#simple-table').on('click', 'td input[type=checkbox]',
                function() {
                    var $row = $(this).closest('tr');
                    if (this.checked)
                        $row.addClass(active_class);
                    else
                        $row.removeClass(active_class);
                });

        });
        $('#page-size').val(${pager.pageSize});
        $('#pagination').pagination({
              link:'role/all?pageSize=${pager.pageSize}&pageNumber={p}&keyword=${keyword}',
              count:${pager.pageCount},
              current:${pager.pageNumber}
            });
          $('#page-size').on('change', 
                  function() {
                     console.info($('#page-size').val());
                     window.location.href = "role/all?pageSize="+$('#page-size').val()+"&pageNumber="+${pager.pageNumber}+"&keyword="+$("#keyword").val();
                  });
          function refreshWindow(){
              window.location.href = "role/all?pageSize="+$('#page-size').val()+"&pageNumber="+${pager.pageNumber}+"&keyword="+$("#keyword").val();
          }
          function removeRole(id){
              if(confirm("确定删除该角色吗？")){
                  window.location.href="role/remove?id="+id;
              }
          }
    </script>
</div>