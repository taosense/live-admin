<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
    <title>用户信息</title>
    <link rel="icon" href="http://zhibo.news.cn/rlnbj/commons/favicon.ico">
    <!-- bootstrap & fontawesome -->
<link rel="stylesheet"
    href="dist/css/bootstrap.min.css" />
<link rel="stylesheet" href="fontawesome/css/font-awesome.min.css" />
   <link rel="stylesheet"
    href="http://zhibo.news.cn/rlnbj/dist/css/ace.min.css"
    class="ace-main-stylesheet" id="main-ace-style" />

    <!-- ace settings handler -->
    <script src="http://zhibo.news.cn/rlnbj/dist/js/ace-extra.min.js"></script>

	<!-- bootstrap & fontawesome -->

		<!-- page specific plugin styles -->
		<link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/jquery-ui.custom.min.css" />
		<link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/jquery.gritter.min.css" />
		<link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/select2.min.css" />
		<link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/datepicker.min.css" />
		<link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/bootstrap-editable.min.css" />

		<!-- text fonts -->

<style>
.profile-activity{
	width:25%;
	display: inline-block;
}
.profile-info-row{
	width:50%;
	display: inline-block;
}
.profileInfoName{
	background: #70a6e0;
    color: #fff;
    padding-left: 20px;
    font-size: 18px;
    height: 32px;
    line-height: 36px;
}
.profileInfoRow{
	width:100% !important;
}
.experience{
	line-height: 30px;
}
.experienceHeight{
	height: 131px;
}
.pt20{
	padding: 20px;
}
.w150{
	width: 150px;
    display: inline-block;
}
</style>
</head>

<body class="no-skin">

<div class="col-xs-2">
    <button id="searchBtn" class="right">
        <span><i>用户关系</i></span>
    </button>   
</div>


					<div class="page-content">
						<div class="ace-settings-container" id="ace-settings-container">


							<div class="ace-settings-box clearfix" id="ace-settings-box">
								<div class="pull-left width-50">
									<div class="ace-settings-item">
										<div class="pull-left">
											<select id="skin-colorpicker" class="hide">
												<option data-skin="no-skin" value="#438EB9">#438EB9</option>
												<option data-skin="skin-1" value="#222A2D">#222A2D</option>
												<option data-skin="skin-2" value="#C6487E">#C6487E</option>
												<option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
											</select>
										</div>
										<span>&nbsp; Choose Skin</span>
									</div>

									<div class="ace-settings-item">
										<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
										<label class="lbl" for="ace-settings-navbar"> Fixed Navbar</label>
									</div>

									<div class="ace-settings-item">
										<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
										<label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
									</div>

									<div class="ace-settings-item">
										<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
										<label class="lbl" for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
									</div>

									<div class="ace-settings-item">
										<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
										<label class="lbl" for="ace-settings-rtl"> Right To Left (rtl)</label>
									</div>

									<div class="ace-settings-item">
										<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
										<label class="lbl" for="ace-settings-add-container">
											Inside
											<b>.container</b>
										</label>
									</div>
								</div><!-- /.pull-left -->

								<div class="pull-left width-50">
									<div class="ace-settings-item">
										<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-hover" />
										<label class="lbl" for="ace-settings-hover"> Submenu on Hover</label>
									</div>

									<div class="ace-settings-item">
										<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-compact" />
										<label class="lbl" for="ace-settings-compact"> Compact Sidebar</label>
									</div>

									<div class="ace-settings-item">
										<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-highlight" />
										<label class="lbl" for="ace-settings-highlight"> Alt. Active Item</label>
									</div>
								</div><!-- /.pull-left -->
							</div><!-- /.ace-settings-box -->
						</div><!-- /.ace-settings-container -->


						<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>

						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="#">用户信息</a>
							</li>
						</ul><!-- /.breadcrumb -->

						<div class="nav-search" id="nav-search">
							<form class="form-search" method="post" action="/dist/userInfo">
								<span class="input-icon">
									<input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input" name="userName" autocomplete="off">
									<i class="ace-icon fa fa-search nav-search-icon"></i>
								</span>
							</form>
						</div><!-- /.nav-search -->
					</div>
						<div class="page-header">


						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">

								<div class="hr dotted"></div>

								<div>
									<div id="user-profile-1" class="user-profile row">
										<div class="col-xs-12 col-sm-3 center">
											<div>
												<span class="profile-picture">
													<a href="/dist/userInfo?userName=${userName}"><img id="avatar" class="editable img-responsive" alt="Alex's Avatar" src="http://tpic.home.news.cn/userIcon/l/${userName}"/></a>
												</span>

												<div class="space-4"></div>

												<div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
													<div class="inline position-relative">
														<a href="#" class="user-title-label dropdown-toggle" data-toggle="dropdown">
															<i class="ace-icon fa fa-circle light-green"></i>
															&nbsp;
															<span class="white">${nickName}</span>
														</a>

														<ul class="align-left dropdown-menu dropdown-caret dropdown-lighter">
															<li class="dropdown-header"> Change Status </li>

															<li>
																<a href="#">
																	<i class="ace-icon fa fa-circle green"></i>
&nbsp;
																	<span class="green">Available</span>
																</a>
															</li>

															<li>
																<a href="#">
																	<i class="ace-icon fa fa-circle red"></i>
&nbsp;
																	<span class="red">Busy</span>
																</a>
															</li>

															<li>
																<a href="#">
																	<i class="ace-icon fa fa-circle grey"></i>
&nbsp;
																	<span class="grey">Invisible</span>
																</a>
															</li>
														</ul>
													</div>
												</div>
											</div>

											<div class="space-6"></div>

											<div class="profile-contact-info">


												<div class="space-6"></div>

											</div>

										</div>

										<div class="col-xs-12 col-sm-9">


												<div class="center">

														<span class="btn btn-app btn-sm btn-success no-hover" onclick="javascript:getRelations(1);return false; ">
															<span class="line-height-1 bigger-170 blue">${friendsNum}</span>

															<br />
															<span class="line-height-1  smaller-90"> 好友 </span>
														</span>

														<span class="btn btn-app btn-sm btn-yellow no-hover" onclick="javascript:getRelations(2);return false;">
															<span class="line-height-1 bigger-170">${funsNum}</span>

															<br />
															<span class="line-height-1 smaller-90"> 粉丝 </span>
														</span>

														<span class="btn btn-app btn-sm btn-pink no-hover" onclick="javascript:getRelations(3);return false;">
															<span class="line-height-1 bigger-170">${followsNum} </span>

															<br />
															<span class="line-height-1 smaller-90"> 关注 </span>
														</span>
												</div>
												<div class="space-12"></div>

												<c:if test="${result ==0}">
														<div id="div_userinfo" class="profile-info-value">
															<span class="editable" >用户不存在</span>
														</div>
												</c:if>

												<c:if test="${result ==1}">
													<div id="div_userinfo1" class="profile-user-info profile-user-info-striped">
														<div class="profile-info-row profileInfoRow">
															<div class="profileInfoName"> 采集录入</div>
														</div>
														
														<div class="profile-info-row">
															<div class="profile-info-name"> 用户名 </div>
															<div class="profile-info-value">
																<span class="editable" id="username">88850813</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 新华炫 </div>
															<div class="profile-info-value">
																<span class="editable" id="xinhuaXuan">${userId}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 姓名 </div>
															<div class="profile-info-value">
																<span class="editable" id="realName">${realName}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 民族</div>
															<div class="profile-info-value">
																<span class="editable" id="minzu">${minzu}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 政治面貌</div>
															<div class="profile-info-value">
																<span class="editable" id="politicalStatus">${politicalStatus}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 证件类型</div>
															<div class="profile-info-value">
																<span class="editable" id="credentialType">${credentialType}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 证件号</div>
															<div class="profile-info-value">
																<span class="editable" id="credentialNO">${credentialNO}</span>
															</div>
														</div>
														
														
														<div class="profile-info-row">
															<div class="profile-info-name"> 生日 </div>
															<div class="profile-info-value">
																<span class="editable" id="birthday">${birthday}</span>
															</div>
														</div>
														
														<div class="profile-info-row">
															<div class="profile-info-name"> 最高学历 </div>
															<div class="profile-info-value">
																<span class="editable" id="highestEducation">${highestEducation}</span>
															</div>
														</div>
														
														<div class="profile-info-row">
															<div class="profile-info-name"> 学位</div>
															<div class="profile-info-value">
																<span class="editable" id="universityDegree">${universityDegree}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 所属行业 </div>
															<div class="profile-info-value">
																<span class="editable" id="industry">${industry}</span>
															</div>
														</div>
														
														<div class="profile-info-row">
															<div class="profile-info-name"> 籍贯 </div>
															<div class="profile-info-value">
																 <c:if test="${nativePlaceCountry != null  && fn:length(nativePlaceCountry)!=0}">
																  <span class="editable" id="nativePlaceCountry">${nativePlaceCountry}</span>
																</c:if>
																<c:if test="${nativePlaceProvince != null && fn:length(nativePlaceProvince)!=0}">
																	<span class="editable" id="nativePlaceProvince">${nativePlaceProvince}</span>
																</c:if>
																<c:if test="${nativePlaceCity != null && fn:length(nativePlaceCity)!=0}">
																	<span class="editable" id="nativePlaceCity">${nativePlaceCity}</span>
																</c:if>
																<c:if test="${nativePlaceDistrict != null && fn:length(nativePlaceDistrict)!=0}">
																	<span class="editable" id="nativePlaceDistrict">${nativePlaceDistrict}</span>
																</c:if>
															</div>
														</div>
														
														<div class="profile-info-row">
															<div class="profile-info-name"> 电子邮箱 </div>
															<div class="profile-info-value">
																<span class="editable" id="email">${email}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 手机号 </div>
															<div class="profile-info-value">
																<span class="editable" id="mobile">${mobile}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 微信 </div>
															<div class="profile-info-value">
																<span class="editable" id="weixin">${weixin}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> qq</div>
															<div class="profile-info-value">
																<span class="editable" id="qq">${qq}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 家庭电话 </div>
															<div class="profile-info-value">
																<span class="editable" id="homePhone">${homePhone}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 家庭邮编 </div>
															<div class="profile-info-value">
																<span class="editable" id="homeZip">${homeZip}</span>
															</div>
														</div>
														
														
														  <div class="profile-info-row">
                                                            <div class="profile-info-name"> 工作单位 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="company">${company}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 单位地址 </div>
                                                            <div class="profile-info-value">
                                                                 <c:if test="${nativePlaceCountry != null  && fn:length(nativePlaceCountry)!=0}">
                                                                  <span class="editable" id="companyCountry">${companyCountry}</span>
                                                                </c:if>
                                                                <c:if test="${nativePlaceProvince != null && fn:length(companyProvince)!=0}">
                                                                    <span class="editable" id="companyProvince">${companyProvince}</span>
                                                                </c:if>
                                                                <c:if test="${nativePlaceCity != null && fn:length(nativePlaceCity)!=0}">
                                                                    <span class="editable" id="companyCity">${companyCity}</span>
                                                                </c:if>
                                                                <c:if test="${nativePlaceDistrict != null && fn:length(nativePlaceDistrict)!=0}">
                                                                    <span class="editable" id="companyDistrict">${companyDistrict}</span>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 单位电话 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="companyPhone">${companyPhone}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 单位邮编 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="companyZip">${companyZip}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 单位传真 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="fax">${fax}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 职务</div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="duty">${duty}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row experienceHeight">
                                                            <div class="profile-info-name"> 工作经历</div>
                                                            <div class="profile-info-value">
                                                                <c:forEach items="${experiences}" var="exp">
		                                                           <span class="editable experience" id="experiences">${exp.company}-${exp.department} &nbsp;&nbsp;&nbsp;&nbsp;${exp.startDate}～${exp.endDate}</span><br/>
		                                                        </c:forEach>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="profile-info-row experienceHeight">
                                                            <div class="profile-info-name experienceHeight"> 教育经历</div>
                                                            <div class="profile-info-value experienceHeight pt20">
                                                                <c:forEach items="${education}" var="exp">
		                                                           <span class="editable experience" id="education"><span class="w150">${exp.school} ${exp.clazz}</span></span>${exp.major} ${exp.institute} ${exp.startDate}～${exp.endDate}-${exp.schoolType}</span><br/>
		                                                        </c:forEach>
                                                            </div>
                                                        </div>
                                                         <div class="profile-info-row">
															<div class="profile-info-name"> 职称</div>
															<div class="profile-info-value">
																<span class="editable" id="title">${title}</span>
															</div>
														 </div>

														<div class="profile-info-row">
															<div class="profile-info-name"> 特长 </div>
															<div class="profile-info-value">
																<span class="editable" id="speciality">${speciality}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 签名</div>
															<div class="profile-info-value">
																<span class="editable" id="sign">${sign}</span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 自我介绍 </div>
															<div class="profile-info-value">
																<span class="editable" id="selfDesc">${selfDesc}</span>
															</div>
														</div>

													</div>
												</c:if>
												<div id="div_userinfo2" class="profile-user-info profile-user-info-striped">
														<div class="profile-info-row profileInfoRow">
                                                            <div class="profileInfoName"> 分析推测 </div>
                                                        </div>
                                                      
														<div class="profile-info-row">
                                                            <div class="profile-info-name"> 性别 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="gender">${gender}</span>
                                                            </div>
                                                        </div>
														<div class="profile-info-row">
                                                            <div class="profile-info-name"> 国籍 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="nationality">${nationality}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 血型 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="bloodType">${bloodType}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 职业 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="job">${job}</span>
                                                            </div>
                                                        </div>
                                                         <div class="profile-info-row">
                                                            <div class="profile-info-name"> 目前薪资</div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="salary">${salary}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 婚姻状况 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="maritalStatus">${maritalStatus}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 所在地 </div>
                                                            <div class="profile-info-value">
                                                                <c:if test="${homeLocationCountry != null  && fn:length(homeLocationCountry)!=0}">
                                                                    <span class="editable" id="homeLocationCountry">${homeLocationCountry}</span>
                                                                </c:if>
                                                                <c:if test="${homeLocationProvince != null  && fn:length(homeLocationProvince)!=0}">
                                                                    <span class="editable" id="homeLocationProvince">${homeLocationProvince}</span>
                                                                </c:if>
                                                                <c:if test="${homeLocationCity != null  && fn:length(homeLocationCity)!=0}">
                                                                    <span class="editable" id="homeLocationCity">${homeLocationCity}</span>
                                                                </c:if>
                                                                <c:if test="${homeLocationDistrict != null  && fn:length(homeLocationDistrict)!=0}">
                                                                    <span class="editable" id="homeLocationDistrict">${homeLocationDistrict}</span>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 标签 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="newsTag">${newsTag}</span>
                                                            </div>
                                                        </div>
                                                        <div class="profile-info-row">
                                                            <div class="profile-info-name"> 兴趣/爱好 </div>
                                                            <div class="profile-info-value">
                                                                <span class="editable" id="interest">${interest}</span>
                                                            </div>
                                                        </div>
                                                        
												
									</div>
									<div class="widget-box transparent" >
																		<div class="widget-header widget-header-small">
																		</div>
																		<div class="widget-body">
																			<div  class="widget-main padding-8" style="display:block">
																				<div class="profile-feed-l">
																					<div  id="relation"  class="scroll-content"></div>
																				</div>
																			</div>
																		</div>
									</div>
								</div>
								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
					</div><!-- /.page-content -->



			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>


		<!-- basic scripts -->

		<!--[if !IE]> -->
		<script src="http://zhibo.news.cn/rlnbj/dist/js/jquery/jquery.min-2.1.1.js"></script>
		<!-- <![endif]-->
		<!--[if IE]>
			<script src="http://zhibo.news.cn/rlnbj/dist/js/jquery//jquery.min-1.11.1.js"></script>
		<![endif]-->

		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='http://zhibo.news.cn/rlnbj/dist/js/jquery.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='http://zhibo.news.cn/rlnbj/dist/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='http://zhibo.news.cn/rlnbj/dist/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
<script type="text/javascript">

</script>
	</body>
</html>

<div id="botton_javascript">
    <script
        src="http://zhibo.news.cn/rlnbj/dist/js/jquery.inputlimiter.1.3.1.min.js"></script>
    <script
        src="http://zhibo.news.cn/rlnbj/dist/js/jquery.maskedinput.min.js"></script>
    <script type="text/javascript">
    
   /*  var nowTemp = new Date();
    var maxT = new Date(nowTemp.getFullYear(), nowTemp.getMonth()-3, nowTemp.getDate()-1, 0); */
    function getRelations(type){
    //	console.log(type)
   // 	type.show();
        var divs = $('#relation');
     	var data = '{isAjax:\"' + true + '\",userId:\"'+${userId}+'\",type:\"'+type+'\"}';
    	var url = "/dist/userRel";
    	var scrollTop=$(document).scrollTop();
    	
    	jQuery.ajax({
            url : url,
            type : 'POST',
            data : data,
            datatype : "json",
            contentType : "application/json; charset=utf-8",
            success : function(result) {
            	$("#div_userinfo1").hide();
            	$("#div_userinfo2").hide();
                divs.hide()

            	var dataJson  = JSON.parse(result); 
                var users = dataJson.users;
                var html = "";
                for(var i=0;i<users.length;i++){
                	html = html+"<div class='profile-activity clearfix'>";
                    html = html+"<div>";
                    html = html+"<img class='pull-left' src='http://tpic.home.news.cn/userIcon/l/"+users[i].loginName+"'\/>";
                    html = html+"<a class='user'>"+users[i].nickName+"<\/a>";
                    html = html+"<\/div><\/div>";  
                }
                divs.html("")
                divs.append(html);
                divs.show(500)
                /*alert(scrollTop)
                $(document).scrollTop(scrollTop);*/
                $('html, body').animate({scrollTop:scrollTop}, 'fast'); 
            },
            error : function() {
            	console.log("没有数据！")
            }
        });
    	
    }
          

   function showUserInfo(){
    	$('#relation').hide();
   		$("#div_userinfo1").show(500);
   		$("#div_userinfo2").show(500);
    }
    </script>
</div>

