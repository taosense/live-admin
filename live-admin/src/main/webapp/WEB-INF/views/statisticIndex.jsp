<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>发布系统实时统计</title>
<link rel="icon" href="http://zhibo.news.cn/rlnbj/commons/favicon.ico">
<link rel='stylesheet' href='fontawesome/css/font-awesome.min.css'>
<link rel="stylesheet"
	href="dist/css/bootstrap.min.css" />

<!-- ace styles -->
<link rel="stylesheet"
	href="http://zhibo.news.cn/rlnbj/dist/css/ace.min.css"
	class="ace-main-stylesheet" id="main-ace-style" />
<style>
.timeline-style2 .timeline-info {
	width: 170;
}

.timeline-style2 .timeline-indicator {
	font-size: 0;
	height: 16px;
	line-height: 12px;
	width: 16px;
	border-width: 1px !important;
	background-color: #FFF !important;
	position: absolute;
	left: 144px;
	top: 7px;
	opacity: 1;
	border-radius: 100%;
	display: inline-block;
	padding: 0;
}

.timeline-style2 .timeline-item:before {
	content: "";
	display: block;
	position: absolute;
	left: 151;
	top: 5px;
	bottom: -27px;
	border-width: 0;
	background-color: #DDD;
	width: 2px;
	max-width: 2px;
}

.timeline-style2 .timeline-date {
	display: inline-block;
	width: 122px;
	text-align: right;
	margin-right: 25px;
	color: #777;
}
</style>
</head>
<body>





	<!-- 	<div class="alert alert-block alert-success"> -->
	<!-- 		<button type="button" class="close" data-dismiss="alert"> -->
	<!-- 			<i class="ace-icon fa fa-times"></i> -->
	<!-- 		</button> -->
	<!-- 		<h1> -->
	<!-- 			<i class="ace-icon fa fa-check green"></i> 欢迎罗总莅临指导新华网文件管理平台！ -->
	<!-- 		</h1> -->
	<!-- 	</div> -->
	<div class="row">
		<div class="col-xs-12">
			<div id="dynamic-table_wrapper"
				class="dataTables_wrapper form-inline no-footer">
				<div class="row">
					<div class="col-xs-12">

						统计间隔： <select class="chosen-select form-control" id="timeStatis">
							<option value="1000">1秒</option>
							<option value="2000">2秒</option>
							<option value="5000" selected="selected">5秒</option>
							<option value="10000">10秒</option>
							<option value="20000">20秒</option>
							<option value="30000">30秒</option>
							<option value="60000">60秒</option>
						</select> 统计分类：<select name="statisticType" id="statisticType"
							onchange="changeSelect(this.value)"
							class="chosen-select form-control"
							data-placeholder="Choose a companyId...">
							<option
								<c:if test="${statisticType==0}">selected="selected"</c:if>
								value="0">应用分类</option>
							<option
								<c:if test="${statisticType==1}">selected="selected"</c:if>
								value="1">发布模式</option>
						</select> <select name="selectedId" id="selectedId"
							class="chosen-select form-control" data-levelNum="1"
							id="firLevel">
							<option value="-1">全部</option>
							<c:forEach items="${statisTypeList}" var="row">
								<option
									<c:if test="${selectedId==row.id}">selected="selected"</c:if>
									value="${row.id }">${row.name }</option>
							</c:forEach>
						</select>统计结果类型：<select id="resultTypeInterval"
							class="chosen-select form-control">
							<option value="-1">全部</option>
							<option value="0">失败</option>
							<option value="1" selected="selected">成功</option>
							<option value="2">重复</option>
							<option value="3">警告</option>
						</select>
						<button id="refreshBtn" class="" type="button">
							<span>刷新并开启实时统计</span>
						</button>

						<span style="float: right;"><button id="openStatis"
								disabled="disabled" rel="statisFlag" class="" type="button">
								<span>开启实时统计</span>
							</button>
							<button id="closeStatis" class="" type="button" rel="statisFlag">
								<span>关闭实时统计</span>
							</button> </span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="background-color: #ffffff">
		<div id="container1" style="height: 400px" class="col-xs-8"></div>

		<div class="col-xs-4">
			<h2 class="purple bolder">
				总发布条数- <span id="totalType"></span>：
			</h2>

			<div id="timeline-2">
				<div class="row">
					<div class="col-xs-12 col-sm-10">
						<div class="timeline-container timeline-style2">
							<span class="timeline-label"> </span>

							<div
								style="background-color: #EFF3F8; height: 300px; overflow: hidden;">
								<div class="timeline-items" rel="totalDiv">
									<div class="timeline-item clearfix" rel="data">

										<div class="timeline-info">
											<span class="timeline-date bigger-150 red bolder" rel="time">00:00:00</span>
											<i class="timeline-indicator btn btn-info no-hover"></i>
										</div>

										<div class="widget-box transparent">
											<div class="widget-body">
												<div class="widget-main no-padding">
													<span class="bigger-150 blue bolder" rel="count">0</span>条
													<span class="bigger-100 pink bolder" rel="countInfo"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="timeline-item clearfix" rel="data">

										<div class="timeline-info">
											<span class="timeline-date bigger-150 red bolder" rel="time">00:00:00</span>
											<i class="timeline-indicator btn btn-info no-hover"></i>
										</div>

										<div class="widget-box transparent">
											<div class="widget-body">
												<div class="widget-main no-padding">
													<span class="bigger-150 blue bolder" rel="count">0</span>条
													<span class="bigger-100 pink bolder" rel="countInfo"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="timeline-item clearfix" rel="data">

										<div class="timeline-info">
											<span class="timeline-date bigger-150 red bolder" rel="time">00:00:00</span>
											<i class="timeline-indicator btn btn-info no-hover"></i>
										</div>

										<div class="widget-box transparent">
											<div class="widget-body">
												<div class="widget-main no-padding">
													<span class="bigger-150 blue bolder" rel="count">0</span>条
													<span class="bigger-100 pink bolder" rel="countInfo"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="timeline-item clearfix" rel="data">

										<div class="timeline-info">
											<span class="timeline-date bigger-150 red bolder" rel="time">00:00:00</span>
											<i class="timeline-indicator btn btn-info no-hover"></i>
										</div>

										<div class="widget-box transparent">
											<div class="widget-body">
												<div class="widget-main no-padding">
													<span class="bigger-150 blue bolder" rel="count">0</span>条
													<span class="bigger-100 pink bolder" rel="countInfo"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="timeline-item clearfix" rel="data">

										<div class="timeline-info">
											<span class="timeline-date bigger-150 red bolder" rel="time">00:00:00</span>
											<i class="timeline-indicator btn btn-info no-hover"></i>
										</div>

										<div class="widget-box transparent">
											<div class="widget-body">
												<div class="widget-main no-padding">
													<span class="bigger-150 blue bolder" rel="count">0</span>条
													<span class="bigger-100 pink bolder" rel="countInfo"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="timeline-item clearfix" rel="data">

										<div class="timeline-info">
											<span class="timeline-date bigger-150 red bolder" rel="time"><i
												rel="hand"
												class="ace-icon fa fa-hand-o-right red bigger-130"></i>00:00:00</span>
											<i class="timeline-indicator btn btn-info no-hover"></i>
										</div>

										<div class="widget-box transparent">
											<div class="widget-body">
												<div class="widget-main no-padding">
													<span class="bigger-150 blue bolder" rel="count">0</span>条
													<span class="bigger-100 pink bolder" rel="countInfo"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="timeline-item clearfix" rel="data">

										<div class="timeline-info">
											<span class="timeline-date bigger-150 red bolder" rel="time">00:00:00</span>
											<i class="timeline-indicator btn btn-info no-hover"></i>
										</div>

										<div class="widget-box transparent">
											<div class="widget-body">
												<div class="widget-main no-padding">
													<span class="bigger-150 blue bolder" rel="count">0</span>条
													<span class="bigger-100 pink bolder" rel="countInfo"></span>
												</div>
											</div>
										</div>
									</div>

								</div>
							</div>

							<!-- /.timeline-items -->
						</div>
						<!-- /.timeline-container -->

						<!-- /.timeline-container -->

						<!-- /.timeline-container -->
					</div>
				</div>
			</div>

		</div>
	</div>

	<div class="row">
		<div class="col-xs-4">
			<div id="containerPie1"></div>
		</div>
		<div class="col-xs-4">
			<div id="containerPie2"></div>
		</div>
		<div class="col-xs-4">
			<div id="containerPie3"></div>
		</div>

	</div>
</body>
</html>
<div id="botton_javascript">
	<script
		src="http://zhibo.news.cn/rlnbj/commons/js/jquery-2.1.3.min.js"></script>
	<script src="http://zhibo.news.cn/rlnbj/dist/js/bootstrap.min.js"></script>

	<script src="http://zhibo.news.cn/rlnbj/commons/js/common.js"></script>
	<script src="http://zhibo.news.cn/rlnbj/commons/js/dateformat.js"></script>
	<script type="text/javascript" src="http://zhibo.news.cn/rlnbj/commons/js/highcharts.js"></script>
	<script type="text/javascript" src="http://zhibo.news.cn/rlnbj/commons/js/highcharts-3d.js"></script>
	<script type="text/javascript" src="http://zhibo.news.cn/rlnbj/commons/js/exporting.js"></script>

	<script type="text/javascript">
		$("#totalType").html(
				$("#resultTypeInterval").find("option:selected").text());
		var statisInterval;

		var events = {
			load : function() {

				// set up the updating of the chart each second             
				var series = this.series[0];
				statisInterval = setInterval(function() {
					getIntervalData(series);
				}, parseInt($("#timeStatis").val()));
			}
		};
		var options1 = {
			chart : {
				type : 'spline',
				animation : Highcharts.svg, // don't animate in old IE               
				marginRight : 10,
				events : events
			},
			credits : {
				enabled : false
			},
			title : {
				text : '实时间隔发布量'
			},
			xAxis : {
				type : 'datetime',
				tickPixelInterval : 150
			},
			yAxis : {
				title : {
					text : '发布量(条)'
				},
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ]
			},
			tooltip : {
				formatter : function() {
					return '<b>'
							+ this.series.name
							+ '</b><br/>'
							+ Highcharts
									.dateFormat('%Y-%m-%d %H:%M:%S', this.x)
							+ '<br/>' + Highcharts.numberFormat(this.y, 2);
				}
			},
			legend : {
				enabled : false
			},
			exporting : {
				enabled : false
			},
			plotOptions : {
				line : {
					dataLabels : {
						enabled : true
					},
					enableMouseTracking : true
				}
			},
			series : [ {
				name : '发布量',
				dataLabels : {
					enabled : true
				},
				allowPointSelect : true,
				data : (function() {
					// generate an array of random data                             
					var data = [], time = (new Date()).getTime(), i;

					for (i = -19; i <= 0; i++) {
						data.push({
							x : time + i * 1000,
							y : 0
						});
					}
					return data;
				})()
			} ]
		};
		var pieData = {
			name : '发布量',
			data : [],
			dataLabels : {
				enabled : true,
				format : '<b>{point.name}</b><br/> {point.percentage:.1f} %|{point.y}条'
			}
		};
		var optionPie = {
			chart : {
				type : 'pie',
				options3d : {
					enabled : true,
					alpha : 45
				}
			},
			credits : {
				enabled : false
			},
			exporting : {
				enabled : false
			},
			title : {
				text : '应用发布比例分布-' + $("#totalType").html()
			},
			subtitle : {
				text : ''
			},
			plotOptions : {
				pie : {
					allowPointSelect : true,
					cursor : 'pointer',
					innerSize : 100,
					depth : 45
				}
			},

			series : [ pieData ]
		};

		$(document).ready(
				function() {
					var $this = $("#news");
					var scrollTimer;
					$this.hover(function() {
						clearInterval(scrollTimer);
					}, function() {
						scrollTimer = setInterval(function() {
							scrollNews($this);
						}, 2000);
					}).trigger("mouseleave");

					//自动刷新start

					Highcharts.setOptions({
						global : {
							useUTC : false
						}
					});

					var chart;
					$('#container1').highcharts(options1);

					//自动刷新end

					$("#menu-dashboard").addClass("active");

					$("button[rel=statisFlag]").click(function() {
						if ($(this).attr("id") == "closeStatis") {
							clearInterval(statisInterval);
						} else {
							$('#container1').highcharts(options1);
						}
						$("button[rel=statisFlag]").removeAttr("disabled");
						$(this).attr("disabled", "disabled");
					});
					$("#refreshBtn").click(
							function() {
								clearInterval(statisInterval);
								$('#container1').highcharts(options1);

								$("#totalType").html(
										$("#resultTypeInterval").find(
												"option:selected").text());

								$("button[rel=statisFlag]").removeAttr(
										"disabled");
								$("#openStatis").attr("disabled", "disabled");
							});

					renderPie(pieData, pieData, pieData, true);

				});

		function renderPie(data1, data2, data3, initFlag) {
			//pie1
			optionPie.title = {
				text : '应用发布比例分布-' + $("#totalType").html()
			};
			if (!initFlag) {
				pieData.data = data1;
			}

			optionPie.series = [ pieData ];
			$('#containerPie1').highcharts(optionPie);
			optionPie.title = {
				text : '发布模式比例分布-' + $("#totalType").html()
			};
			if (!initFlag) {
				pieData.data = data2;
			}

			optionPie.series = [ pieData ];
			$('#containerPie2').highcharts(optionPie);
			optionPie.title = {
				text : '发布结果比例分布'
			};
			if (!initFlag) {
				pieData.data = data3;
			}

			optionPie.series = [ pieData ];
			$('#containerPie3').highcharts(optionPie);
		}
		function renderTotalCount(operTypeData, date) {

			var totalData = '';
			var totalCount = 0;
			for (var i = 0; i < operTypeData.length; i++) {
				totalCount += operTypeData[i].y;
				totalData += operTypeData[i].name + operTypeData[i].y + "|"
			}
			totalData = "[" + totalData.substring(0, totalData.length - 1)
					+ "]";
			var currentTime = dateFormat(date, "HH:MM:ss");

			var timelineDiv = $(".timeline-items");
			var child = timelineDiv.children(":first").clone(true);

			child.find("span[rel=time]").html("");
			$("i[rel=hand]").appendTo(child.find("span[rel=time]"));
			child.find("span[rel=time]").html(
					child.find("span[rel=time]").html() + "" + currentTime);
			child.find("span[rel=count]").html(totalCount);
			child.find("span[rel=countInfo]").html(totalData);
			var childCount = timelineDiv.children().size();
			if (childCount >= 6) {
				timelineDiv.children(":last").remove();
			}

			$("i[rel=hand]").remove();
			timelineDiv.prepend(child);
		}
		function renderTotalCount2(operTypeData, date) {

			var totalData = '';
			var totalCount = 0;
			for (var i = 0; i < operTypeData.length; i++) {
				totalCount += operTypeData[i].y;
				totalData += operTypeData[i].name + operTypeData[i].y + "|"
			}
			totalData = "[" + totalData.substring(0, totalData.length - 1)
					+ "]";
			var currentTime = dateFormat(date, "HH:MM:ss");

			var timelineDiv = $(".timeline-items");
			var child = timelineDiv.children(":first").clone(true);

			child.find("span[rel=time]").html("");
			$("i[rel=hand]").appendTo(child.find("span[rel=time]"));
			child.find("span[rel=time]").html(
					child.find("span[rel=time]").html() + "" + currentTime);
			child.find("span[rel=count]").html(totalCount);
			child.find("span[rel=countInfo]").html(totalData);
			var childCount = timelineDiv.children().size();
			if (childCount >= 6) {
				timelineDiv.children(":last").remove();
			}

			$("i[rel=hand]").hide(5000);
            
			timelineDiv.append(child);
		}
		function getIntervalData(series) {

			var d = new Date();
			var x = d.getTime();
			var interval = $("#timeStatis").val();
			var resultType = $("#resultTypeInterval").val();
			var selectedId = $("#selectedId").val();
			var statisticType = $("#statisticType").val();
			//获取数据
			$.getJSON("countInterval?indexFlag=1&resultType=" + resultType
					+ "&interval=" + interval + "&endTime=" + x
					+ "&selectedId=" + selectedId + "&statisticType="
					+ statisticType, {}, function(json) {

				if (json != null) {
					var data = json.intervalCount;
					series.addPoint([ x, data ], true, true);
				} else {
					series.addPoint([ x, 0 ], true, true);
				}
				//应用饼图
				//发布模式饼图
				renderPie(json.appData, json.publishTypeData,
						json.operResultData, false);
				//发布总量
				// 				renderTotalCount(json.operTypeData, d);
				renderTotalCount2(json.operTypeData, d);
				scrollTotal();
			});
		}
		function scrollTotal() {
			var $self = $("div[rel=totalDiv]");
			var lineHeight = $self.find("div[rel=data]:first").height();
			$self.animate({
				"marginTop" : -lineHeight + "px"
			}, 1000, function() {
				$self.css({
					marginTop : 0
				}).find(".timeline-item:first").appendTo($self);
			});
		}
	</script>
</div>
