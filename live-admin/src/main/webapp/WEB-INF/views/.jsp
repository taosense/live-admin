<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>权限管理</title>
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
							<a href="#permissionadd-modal" role="button" class="blue"
								data-toggle="modal" data-target="#permissionadd-modal">新增权限</a>
							</lable>
						</div>
						<div class="col-xs-8">
							<div class="dataTables_length">
								<label> <input type="search"
									class="form-control input-sm" placeholder="名称" id="keyword"
									aria-controls="dynamic-table" value="${keyword}">
								</label> <label style="padding-left: 10px;">
									<button id="searchBtn" class="right">
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
							<c:forEach var="permission" items="${pager.results}">
								<tr>
									<td class="center"><label class="pos-rel"> <input
											type="checkbox" id="${permission.id}" rel="check" class="ace" />
											<span class="lbl"></span>
									</label></td>

									<td>${permission.name}</td>
									<td>${permission.description}</td>
									<td class="hidden-480"><span name="dateForm"
										data-date="${permission.createdAt}"
										class="label label-sm label-warning"></span></td>
									<td class="hidden-480"><span name="dateForm"
										data-date="${permission.updatedAt}"
										class="label label-sm label-warning"></span></td>
									<td>
										<div class="hidden-sm hidden-xs action-buttons">
											<a class="green pointer"
												onclick="editPermission('${permission.id}','${permission.name}','${permission.description}')"
												data-toggle="modal" data-target="#permissionEdit-modal"
												title="修改权限"> <i
												class="ace-icon fa fa-pencil bigger-150"></i>
											</a> <a class="red pointer"
												onclick="location.href='permission/remove?id=${permission.id}'"
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
	<!-- 遮罩层start -->
	<div id="permissionadd-modal" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="smaller lighter blue no-margin">新增权限</h3>
				</div>
				<form id="addForm" action="permission/add" method="post">
					<div class="modal-body">

						<table id="info"
							class="table table-striped table-bordered table-hover dataTable no-footer DTTT_selectable">
							<tr>
								<td class="left">权限名:</td>
								<td><input class="col-xs-12 col-sm-10" type="text"
									name="name" id="addPermissionName" /></td>
							</tr>
							<tr>
								<td class="left">中文描述:</td>
								<td><input class="col-xs-12 col-sm-10" type="text"
									name="description" id="addPermissionDes" /></td>
							</tr>
						</table>
					</div>

					<div class="modal-footer">
						<button class="btn btn-white  btn-default btn-round"
							onclick="addPermissionF();return false;">
							<i class="ace-icon fa fa-check red2"></i> 保存
						</button>
						<button class="btn btn-white btn-default btn-round"
							data-dismiss="modal">
							<i class="ace-icon fa fa-times red2"></i> 取消
						</button>
						</ul>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="permissionEdit-modal" class="modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="smaller lighter blue no-margin">修改权限</h3>
				</div>
				<form id="editForm" action="permission/edit" method="post">
					<div class="modal-body">

						<table id="info"
							class="table table-striped table-bordered table-hover dataTable no-footer DTTT_selectable">
							<tr>
								<td class="left">权限名:</td>
								<td><input type="hidden" name="id" id="permissionEdit_id" /><input
									class="col-xs-12 col-sm-10" type="text" name="name"
									id="editPermissionName" /></td>
							</tr>
							<tr>
								<td class="left">中文描述:</td>
								<td><input class="col-xs-12 col-sm-10" type="text"
									name="description" id="editPermissionDes" /></td>
							</tr>
						</table>
					</div>

					<div class="modal-footer">
						<button class="btn btn-white btn-default btn-round"
							onclick="editPermissionF();return false;">
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
	<script src="http://zhibo.news.cn/rlnbj/commons/js/bootstrap-pagination.js"></script>
	<script src="http://zhibo.news.cn/rlnbj/dist/js/bootbox.min.js"></script>
	<script src="http://zhibo.news.cn/rlnbj/commons/js/moment-with-locales.js"></script>
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
	 function addPermissionF(){
		 var name =$("input[id='addPermissionName']").val();
		 var description =$("input[id='addPermissionDes']").val();
		 
		 if(name==null||""==name){
			 alert("权限名不能为空!");
		 }else if(description==null||""==description){
			 alert("权限中文描述不能为空!");
		 }else{
			 $('#addForm').submit();
		 }
		 
	 }
	 
	 function editPermissionF(){
         var name =$("input[id='editPermissionName']").val();
         var description =$("input[id='editPermissionDes']").val();
         
         if(name==null||""==name){
             alert("权限名不能为空!");
         }else if(description==null||""==description){
             alert("权限中文描述不能为空!");
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
        window.location.href = "permission/removeList?ids="+ids;
     }
	
	 $("#searchBtn").on(ace.click_event, function() {
         window.location.href = "permission/all?pageSize=${pager.pageSize}&pageNumber=1&keyword="+$("#keyword").val();
     });
	 
  
	
	  function editPermission(id,name,description){
	        $("#permissionEdit_id").val(id);
	        $("#editPermissionName").val(name);
	        $("#editPermissionDes").val(description);
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
	        link:'permission/all?pageSize=${pager.pageSize}&pageNumber={p}&keyword=${keyword}',
	        count:${pager.pageCount},
	        current:${pager.pageNumber}
	      });
	    $('#page-size').on('change', 
	            function() {
	               console.info($('#page-size').val());
	               window.location.href = "permission/all?pageSize="+$('#page-size').val()+"&pageNumber="+${pager.pageNumber}+"&keyword="+$("#keyword").val();
	            });
	    function refreshWindow(){
	        window.location.href = "permission/all?pageSize="+$('#page-size').val()+"&pageNumber="+${pager.pageNumber}+"&keyword="+$("#keyword").val();
	    }
	</script>
</div>