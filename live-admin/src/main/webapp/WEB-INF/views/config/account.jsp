<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/bootstrap-duallistbox.min.css" />
<title>账户管理</title>
</head>
<body>

	<!-- 页面内容  start-->
	<div class="row">
		<div class="col-xs-12">
			<div>
				<div id="dynamic-table_wrapper"
					class="dataTables_wrapper form-inline no-footer">

					<div class="row">
						<div class="col-xs-2">
							<lable class="pink"> <i class="ace-icon fa fa-plus green"></i>
							<a href="#accountadd-modal" role="button" class="blue"
								data-toggle="modal" data-target="#accountadd-modal">新增账户</a> </lable>
						</div>
						<div class="col-xs-8">
							<div class="dataTables_length">
								<label> <input type="search"
									class="form-control input-sm" placeholder="登录名或昵称" id="keyword"
									aria-controls="dynamic-table" value="${keyword }">
								</label> <label style="padding-left: 10px;">
									<button id="searchBtn" class="">
										<span><i class="fa fa-search"></i></span>
									</button>
								</label>
							</div>
						</div>
						<div class="col-xs-2">
							<div id="dynamic-table_filter" class="dataTables_filter">
								<div class="hidden-sm hidden-xs action-buttons">
									<a class="red" href="javascript:batchOper()" title="批量删除">
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
								<th>账户ID</th>
								<th>登录名</th>
								<th>昵称</th>
								<th width="80">是否允许<br/>外网登录</th>
								<th>用户角色</th>

								<th><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>
									创建时间</th>
								<th><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>
									更新时间</th>
								<th>操作人</th>

								<th width="100">操作</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="account" items="${pager.results}">
								<tr>
									<td class="center"><label class="pos-rel"> <input
											type="checkbox" id="<c:out value="${account.id }"/>"
											name="${account.loginName}" rel="check" class="ace" /> <span
											class="lbl"></span>
									</label></td>

									<td>${account.userId}</td>
									<td>${account.loginName}</td>
									<td>${account.nickName}</td>
									<td>${account.allowInternet}</td>
									<td style="word-break: break-all;"><c:forEach var="role" items="${account.roles}">
									   ${role.description}&nbsp;&nbsp;
									   </c:forEach></td>
									<td class="hidden-480"><span name="dateForm"
										data-date="${account.createdAt}"
										class="label label-sm label-warning"></span></td>
									<td class="hidden-480"><span name="dateForm"
										data-date="${account.updatedAt}"
										class="label label-sm label-warning"></span></td>
                                    <td>${account.operatorId}</td>
									<td>
										<div class="hidden-sm hidden-xs action-buttons">
											<a class="green pointer"
												onclick="editAccount('${account.id}','${account.allowInternet}')"
												data-toggle="modal" data-target="#accountEdit-modal"
												title="修改账户"> <i
												class="ace-icon fa fa-pencil bigger-150"></i>
											</a> <a class="blue pointer"
												onclick="assignRoles('${account.id}')" data-toggle="modal"
												data-target="#assignRoles-modal" title="分配角色"> <i
												class="ace-icon fa fa-plus-circle bigger-150"></i>
											</a> <a class="red pointer"
												onclick="removeAccount('${account.id}','${account.loginName}')"
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
			</div>
		</div>
		<!-- 遮罩层  start-->
		<div id="accountadd-modal" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h3 class="smaller lighter blue no-margin">新增账户</h3>
					</div>
					<form id="addForm" action="account/addAccount" mathed="post">
						<div class="modal-body">

							<table id="info"
								class="table table-striped table-bordered table-hover dataTable no-footer DTTT_selectable">
								<tr>
									<td class="left">登录名:</td>
									<td><input class="col-xs-12 col-sm-10" type="text"
										name="loginName" id="addAccountName" /></td>
								</tr>
								<tr>
									<td class="left">是否允许外网登录:</td>
									<td><select name="allowInternet" id="allowInternet">
											<option value="true">允许</option>
											<option selected="selected" value="false">不允许</option>
									</select></td>
								</tr>
							</table>
						</div>

						<div class="modal-footer">
							<button class="btn btn-white btn-default btn-round"
								onclick="addAccountF();return false;">
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

		<div id="accountEdit-modal" class="modal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h3 class="smaller lighter blue no-margin">修改账户</h3>
					</div>
					<form action="account/editAccount" method="post">
						<div class="modal-body">

							<table id="info"
								class="table table-striped table-bordered table-hover dataTable no-footer DTTT_selectable">
								<input type="hidden" name="objId" id="accountEdit_objId" />
								<tr>
									<td class="left">是否允许外网登录: <select name="allowInternet"
										id="accountEdit_allowInternet">
											<option value="true">允许</option>
											<option value="false">不允许</option>
									</select>
									</td>
								</tr>
							</table>
						</div>

						<div class="modal-footer">
							<button class="btn btn-white btn-default btn-round" type="submit">
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

		<div id="assignRoles-modal" class="modal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h3 class="smaller lighter blue no-margin">分配角色</h3>
					</div>
					<div class="modal-body">
						<input type="hidden" name="id" id="assignR_id" /> <select
							multiple="multiple" size="10" name="duallistbox_roles"
							id="duallistbox_roles">
						</select>
					</div>

					<div class="modal-footer">
						<button class="btn btn-white btn-default btn-round"
							onclick="assignRole()">
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
		<!-- 遮罩层  end-->
	</div>
	<!-- 页面内容  end-->
	<input type="hidden" name="errorInfo" id="errorInfo"
		value="${errorInfo}" />
</body>

<!-- js 和 css -->
<div id="botton_javascript">
	<script src="http://zhibo.news.cn/rlnbj/dist/js/jquery.bootstrap-duallistbox.min.js"></script>
	<script src="http://zhibo.news.cn/rlnbj/commons/js/moment-with-locales.js"></script>
	<script src="http://zhibo.news.cn/rlnbj/dist/js/jquery.raty.min.js"></script>

	<script src="http://zhibo.news.cn/rlnbj/commons/js/bootstrap-pagination.js"></script>
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
	function removeAccount(id,loginName){
		var src = $('img[id="imgIcon"]').attr('src');
		var name = src.substring(src.lastIndexOf("/")+1,src.length);
		if(name == loginName){
			alert("不能删除自己！");
		}else{
			if(confirm("确定删除该账户吗？")){
				window.location.href="account/removeAccount?id="+id;
			}
		}
	}
    function addAccountF(){
        var name =$("input[id='addAccountName']").val();
        if(name==null||""==name){
            alert("登录名不能为空!");
        }else{
            $('#addForm').submit();
        }
        
    }
    
    $("#searchBtn").on(ace.click_event, function() {
        window.location.href = "account/getAccountByLoginNameOrNickName?pageSize=${pager.pageSize}&pageNumber=1&keyWord="+$("#keyword").val();
    });
    
    function editAccount(id,allowInternet){
        $("#accountEdit_objId").val(id);
        
        if(allowInternet == ''){
            $("#accountEdit_allowInternet option[value=false]").attr("selected", true);
        }else{
            $("#accountEdit_allowInternet option[value="+allowInternet+"]").attr("selected", true);
        }
    }
    
    function assignRole(){
        var ids=new Array();
        $("select[name='duallistbox_roles_helper2'] > option").each(
                function(){
                    ids.push($(this).val());
                });
        window.location.href="account/assignRoles?accountId="+$('#assignR_id').val()+"&ids="+ids;
    }
    
    function assignRoles(id){
        $("#assignR_id").val(id);
        $('select[name="duallistbox_roles"]').empty();
        $.getJSON("account/roles?id="+id, function(data){
               $.each(data.all, function(name, id){
                   var nade = new Array();
                   nade = id.split(",");
                   $('select[name="duallistbox_roles"]').append("<option value="+name+" title="+nade[1]+">"+nade[0]+"</option>");
               });
               $('select[name="duallistbox_roles"]').val(data.selected);
               $('select[name="duallistbox_roles"]').bootstrapDualListbox('refresh');
                // 效果
                var demo1 = $('select[name="duallistbox_roles"]').bootstrapDualListbox({infoTextFiltered: '<span class="label label-purple label-lg">Filtered</span>'});
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
          link:'account/listAccount?pageSize=${pager.pageSize}&pageNumber={p}&keyword=${keyword}',
          count:${pager.pageCount},
          current:${pager.pageNumber}
        });
      $('#page-size').on('change', 
              function() {
                 console.info($('#page-size').val());
                 window.location.href = "account/listAccount?pageSize="+$('#page-size').val()+"&pageNumber="+${pager.pageNumber}+"&keyword="+$("#keyword").val();
              });
      function refreshWindow(){
          window.location.href = "account/listAccount?pageSize="+$('#page-size').val()+"&pageNumber="+${pager.pageNumber}+"&keyword="+$("#keyword").val();
      }
      
      function batchOper() {
    	  var src = $('img[id="imgIcon"]').attr('src');
          var loginName = src.substring(src.lastIndexOf("/")+1,src.length);
          var ids=new Array();
          $("input[type=checkbox][rel=check]:checked").each(
                    function() {
                    	if($(this).attr("name")==loginName){
                    		alert("不能删除自己！");
                    		return;
                    	}
                        ids.push($(this).attr("id"));
                    });
          if(confirm("确定进行批量删除操作吗？")){
        	   window.location.href = "account/removeList?ids="+ids;
          }
      }
      
    </script>
</div>