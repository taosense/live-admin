<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>${title}参数配置</title>
</head>
<body>

	<div class="row">

		<div class="col-xs-12">

			<div>
				<div id="dynamic-table_wrapper"
					class="dataTables_wrapper form-inline no-footer">
					<div class="row">
						<div class="col-xs-10">
							<lable class="pink"> <i class="ace-icon fa fa-plus green"></i>
							<a href="#roleadd-modal" role="button" class="blue"
								data-toggle="modal" data-target="#roleadd-modal">新增参数配置</a> </lable>
						</div>
						<div class="col-xs-2">
							<div id="dynamic-table_filter" class="dataTables_filter">
								<div class="hidden-sm hidden-xs action-buttons">
									<a class="red" href="javascript:delbatchOper()" title="批量删除">
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
								<th>key</th>
								<th width="30%">值</th>
								<th class="hidden-480">描述</th>
								<th class="hidden-480">操作人</th>
								<th width="10%" class="hidden-480">操作时间</th>


								<th>操作</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${pager.results}" var="row" varStatus="xh">
								<tr>
									<td class="center"><label class="pos-rel"> <input
											type="checkbox" id="<c:out value="${row.id }"/>" rel="check"
											class="ace" /> <span class="lbl"></span>
									</label></td>

									<td>${row.key}</td>
									<td style="word-break: break-all;"><c:out
											value="${row.value}" escapeXml="true" />
										<div style="word-break: break-all; display: none;"
											id="value-${row.id }">${row.value}</div></td>
									<td class="hidden-480" style="word-break: break-all;">${row.description}</td>
									<td class="hidden-480">${row.operatorId}</td>
									<td><span name="dateForm" data-date="${row.createdAt}"
										class="label label-sm label-warning"></span></td>


									<td>
										<div class="">

											<a class="green pointer"
												onclick="editSysConfig('${row.id}','${row.key}','${row.description}')"
												role="button" data-toggle="modal"
												data-target="#roleadd-modal-modify"> <i
												class="ace-icon fa fa-pencil bigger-150"></i>
											</a> <a class="red" href="javascript:singleOper('${row.id}')">
												<i class="ace-icon fa fa-trash-o bigger-150"></i>
											</a>


										</div>

									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>


			</div>
			<!-- /.row -->
		</div>
	</div>
	<!-- 遮罩层start -->
	<div id="roleadd-modal" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="smaller lighter blue no-margin">新增参数配置</h3>
				</div>
				<form id="addForm" method="post">
					<div class="modal-body">

						<table id="info"
							class="table table-striped table-bordered table-hover dataTable no-footer DTTT_selectable">
							<tr>
								<td class="left">key:</td>
								<td><input type="text" name="key" id="akey" /></td>
							</tr>
							<tr>
								<td class="left">值:</td>
								<td><textarea rows="5" cols="50" name="value" id="aval"></textarea></td>
							</tr>
							<tr>
								<td class="left">描述:</td>
								<td><input type="text" name="description" id="adesc"
									style="width: 380px" /></td>
							</tr>
						</table>
					</div>

					<div class="modal-footer">
						<button class="btn btn-sm pull-right"
							onclick="addConfig('sysconfig/sysconfigadd');return false;">保存</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="roleadd-modal-modify" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="smaller lighter blue no-margin">编辑参数配置</h3>
				</div>
				<form action="" id="modForm" method="post">
					<input type="hidden" name="id" id="sysEdit_id" value="" />
					<div class="modal-body">

						<table id="info"
							class="table table-striped table-bordered table-hover dataTable no-footer DTTT_selectable">
							<tr>
								<td class="left">key:</td>
								<td><input type="text" name="key" id="sysEdit_key" value="" /></td>
							</tr>
							<tr>
								<td class="left">值:</td>
								<td><textarea rows="5" cols="50" id="sysEdit_value"
										name="value"></textarea></td>
							</tr>
							<tr>
								<td class="left">描述:</td>
								<td><input type="text" name="description"
									id="sysEdit_descp" value="" style="width: 380px" /></td>
							</tr>
						</table>
					</div>

					<div class="modal-footer">
						<button class="btn btn-sm pull-right"
							onclick="modifyConfig('sysconfig/sysconfigupdate');return false;">
							保存</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 遮罩层end -->
	<!-- basic scripts -->

	<!--[if !IE]> -->
	<script
		src="http://zhibo.news.cn/rlnbj/dist/js/jquery/jquery.min-2.1.1.js"></script>

	<!-- <![endif]-->

	<!--[if IE]>
<script src="http://zhibo.news.cn/rlnbj/dist/js/jquery/jquery.min-1.11.1.js"></script>
<![endif]-->


	<!-- page specific plugin scripts -->
	<script
		src="http://zhibo.news.cn/rlnbj/dist/js/dataTables/jquery.dataTables.min.js"></script>
	<script
		src="http://zhibo.news.cn/rlnbj/dist/js/dataTables/jquery.dataTables.bootstrap.min.js"></script>
	<script
		src="http://zhibo.news.cn/rlnbj/commons/js/bootstrap-pagination.js"></script>
	<script
		src="http://zhibo.news.cn/rlnbj/commons/js/moment-with-locales.js"></script>
	<script type="text/javascript">
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

            //select/deselect a row when the checkbox is checked/unchecked
            $('#simple-table').on('click', 'td input[type=checkbox]',
                    function() {
                        var $row = $(this).closest('tr');
                        if (this.checked)
                            $row.addClass(active_class);
                        else
                            $row.removeClass(active_class);
                    });

        });
        $(document).ready(function() {
            $(".widget-body").hide();
            $('#page-size').val(${pager.pageSize});
        });
        $('#pagination').pagination({
            link : 'sysconfig?pageNumber={p}&pageSize=${pager.pageSize}',
            count : ${pager.pageCount},
            current : ${pager.pageNumber}
        });

        $('#page-size').on(
                'change',
                function() {
                    console.info($('#page-size').val());
                    $("#t-page-size").val($('#page-size').val());
                    // $(".form-inline").submit();
                    window.location.href = "sysconfig?pageSize="
                            + $('#page-size').val() + "&pageNumber="
                            + ${pager.pageNumber};
                });
        function singleOper(id) {
            if (id.length>0){
            	if(confirm("确认进行删除配置操作吗？")){
            	   ajaxSubmit(id);
            	}
            }else{
                alert("请选择符合条件的数据");
            }
            
        }
        function editSysConfig(id,key,descp){
            $("#sysEdit_id").val(id);
            $("#sysEdit_key").val(key);
            $("#sysEdit_descp").val(descp);
            $("#sysEdit_value").val($("#value-"+id).html());
        }
        function delbatchOper() {
            var checkboxValue = '';
            $("input[type=checkbox][rel=check]:checked")
                    .each(
                            function() {
                                checkboxValue += $(this).attr("id") + ',';
                            });
            if (checkboxValue.length > 0) {
                checkboxValue = checkboxValue.substring(0, checkboxValue.length - 1);
                singleOper(checkboxValue);
            } else {
                alert("请选择符合条件的数据");
                return;
            }
        }
        function ajaxSubmit(ids) {
            var data = '{mongoIds:\"' + ids + '\"}';
            var url = "sysconfig/delsysconfig";
            jQuery.ajax({
                url : url,
                type : 'POST',
                data : data,
                datatype : "json",
                contentType : "application/json; charset=utf-8",
                success : function(result) {
                    var obj = $.parseJSON(result);
                     if(obj.result == 1){
                         window.location.href = "sysconfig";
                     }else{
                         alert("删除失败！");
                     }
                   
                },
                error : function() {
                }
            });
        }
        function modifyConfig(goUrl){
        	  
            if($('#sysEdit_key').val()==''){
                alert("请填写key");
            }else if($('#sysEdit_value').val() == ''){           
                alert("请填写值");
            }else if($('#sysEdit_descp').val() == ''){
            	alert("请填写描述");
            }else{
                 $('#modForm').attr("action", goUrl);
                 $('#modForm').submit();
            }

       }
        function addConfig(goUrl){
            
            if($('#akey').val()==''){
                alert("请填写key");
            }else if($('#aval').val() == ''){           
                alert("请填写值");
            }else if($('#adesc').val() == ''){
                alert("请填写描述");
            }else{
                 $('#addForm').attr("action", goUrl);
                 $('#addForm').submit();
            }

       }
    </script>

</body>

</html>