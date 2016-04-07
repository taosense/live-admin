<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<ul class="nav nav-list">

	<li class="" id="menu-dashboard"><a href=""> <i
			class="menu-icon fa fa-tachometer"></i> <span class="menu-text">首页</span>
	</a> <b class="arrow"></b></li>
		<li class="" id="menu-liveManage"><a href="liveManage/listLiveModel"> <i
				class="menu-icon fa fa-video-camera"></i> <span class="menu-text">直播管理</span>
		</a> <b class="arrow"></b></li>
		<li class="" id="menu-content"><a href="liveManage/listLiveModel?menuType=content"> <i
				class="menu-icon fa fa-list"></i> <span class="menu-text">内容管理</span>
		</a> <b class="arrow"></b></li>
		<li class="" id="menu-censor"><a href="liveManage/listLiveModel?menuType=censor"> <i
				class="menu-icon fa fa-calendar-check-o"></i> <span class="menu-text">审核管理</span>
		</a> <b class="arrow"></b></li>
		<li class="" id="menu-classify"><a href="#" class="dropdown-toggle"> <i
				class="menu-icon fa fa-cubes"></i> <span class="menu-text">
					分类管理 </span><b class="arrow fa fa-angle-down"></b>
		</a> <b class="arrow"></b>
		<ul class="submenu">
		  <li class="" id="menu-liveClassify"><a href="classify/list"> <i
                            class="menu-icon fa fa-sitemap"></i> 直播分类
                    </a> <b class="arrow"></b></li>
           <li class="" id="menu-liveUserClassify"><a href="userClassify/list"> <i
                            class="menu-icon fa fa-user"></i> 用户分类
                    </a> <b class="arrow"></b></li>
		</ul>
		</li>

		<li class="" id="menu-sys"><a href="#" class="dropdown-toggle">
				<i class="menu-icon fa fa-wrench"></i> <span class="menu-text">
					系统管理 </span> <b class="arrow fa fa-angle-down"></b>

		</a> <b class="arrow"></b>
			<ul class="submenu">
					<li class="" id="menu-sysconfig"><a href="sysconfig"> <i
							class="menu-icon fa fa-gear"></i> 参数配置
					</a> <b class="arrow"></b></li>

					<li class="" id="menu-account"><a href="#"
						class="dropdown-toggle"> <i class="menu-icon fa fa-users"></i>
							<span class="menu-text"> 账户及权限管理 </span> <b
							class="arrow fa fa-angle-down"></b>
					</a> <b class="arrow"></b>
						<ul class="submenu">
								<li class="" id="menu-sysman-account"><a
									href="account/listAccount"> <i class="menu-icon fa fa-user"></i>
										账户管理
								</a> <b class="arrow"></b></li>
								<li class="" id="menu-sysman-role"><a href="role/all">
										<i class="menu-icon fa fa-users"></i> 角色管理
								</a> <b class="arrow"></b></li>
								<li class="" id="menu-sysman-permission"><a
									href="permission/all"> <i class="menu-icon fa fa-key"></i>
										权限管理
								</a> <b class="arrow"></b></li>
						</ul></li>
			</ul></li>
</ul>
<script type="text/javascript">
	$("#menu-allchannel")
			.click(
					function() {
						var url = "channel/queryAllforMenu";
						console.log(url);
						$
								.ajax({
									url : url,
									type : 'POST',
									datatype : "json",
									contentType : "application/json; charset=utf-8",
									success : function(result) {
										console.log(result);
										$("#channelsName").children().remove();
										for (var i = 0; i < result.length; i++) {
											$("#channelsName")
													.append(
															"<li class=\"\" id=\"menu-"+result[i].id+"\"><a href=\"msg/queryAll?channelId="
																	+ result[i].id
																	+ "\">"
																	+ "<i class=\"menu-icon fa fa-file-text\"></i>"
																	+ result[i].name
																	+ "</a> <b class=\"arrow\"></b></li>");
										}
									},
									error : function() {
										overLayer('fail', '请求异常', null,
												dataType);
										console.log("请求所以频道失败")
									}
								});
					});
</script>
