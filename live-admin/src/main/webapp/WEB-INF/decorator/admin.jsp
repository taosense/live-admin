<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + request.getContextPath() + "/";

%>
<base href="<%=basePath%>" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>直播管理系统-<sitemesh:write property='title' /></title>
<link rel="icon" href="http://zhibo.news.cn/rlnbj/commons/favicon.ico">
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="dist/css/bootstrap.min.css" />
<link rel="stylesheet" href="fontawesome/css/font-awesome.min.css" />

<!-- text fonts -->
<link rel='stylesheet' href='http://zhibo.news.cn/rlnbj/dist/css/fonts.useso.com.css'>

<!-- ace styles -->
<link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
<link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/common.css" />

<!--[if lte IE 9]>
    <link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/ace-part2.min.css" class="ace-main-stylesheet" />
<![endif]-->

<!--[if lte IE 9]>
    <link rel="stylesheet" href="http://zhibo.news.cn/rlnbj/dist/css/ace-ie.min.css" />
<![endif]-->

<!-- ace settings handler -->
<script src="http://zhibo.news.cn/rlnbj/dist/js/ace-extra.min.js"></script>

<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
<!--[if lte IE 8]>
    <script src="http://zhibo.news.cn/rlnbj/dist/js/html5shiv.min.js"></script>
    <script src="http://zhibo.news.cn/rlnbj/dist/js/respond.min.js"></script>
<![endif]-->

<!-- page specific plugin styles -->
<sitemesh:write property='head' />
</head>

<body class="no-skin">
    <div id="navbar" class="navbar navbar-default">
        <script type="text/javascript">
            try {
                ace.settings.check('navbar', 'fixed')
            } catch (e) {
            }
        </script>

        <div class="navbar-container" id="navbar-container">
            <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
                <span class="sr-only">Toggle sidebar</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
            </button>

            <div class="navbar-header pull-left">
                <a href="" class="navbar-brand"> <small> <i class="fa fa-file-video-o"></i> 直播管理系统
                </small>
                </a>
            </div>

            <!-- 登录账户信息 -->
            <%@ include file="/WEB-INF/decorator/nav-right.jsp"%>
        </div>
        <!-- /.navbar-container -->
    </div>

    <div class="main-container" id="main-container">
        <script type="text/javascript">
            try {
                ace.settings.check('main-container', 'fixed')
            } catch (e) {
            }
        </script>

        <div id="sidebar" class="sidebar responsive">
            <script type="text/javascript">
                try {
                    ace.settings.check('sidebar', 'fixed')
                } catch (e) {
                }
            </script>

            <!-- 主导航 -->
            <%@ include file="/WEB-INF/decorator/nav-menu.jsp"%>

            <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
                <i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
            </div>

            <script type="text/javascript">
                try {
                    ace.settings.check('sidebar', 'collapsed')
                } catch (e) {
                }
            </script>
        </div>

        <div class="main-content">
            <div class="main-content-inner">
                <div class="breadcrumbs" id="breadcrumbs">
                    <script type="text/javascript">
                        try {
                            ace.settings.check('breadcrumbs', 'fixed')
                        } catch (e) {
                        }
                    </script>

                    <!-- 面包屑导航 -->
                    <%@ include file="/WEB-INF/decorator/breadcrumb.jsp"%>

                </div>

                <div class="page-content">
<!--                    <div class="ace-settings-container" id="ace-settings-container"> -->
<!--                        <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn"> -->
<!--                            <i class="ace-icon fa fa-cog bigger-130"></i> -->
<!--                        </div> -->

<!--                        <div class="ace-settings-box clearfix" id="ace-settings-box"> -->
<!--                            <div class="pull-left width-50"> -->
<!--                                <div class="ace-settings-item"> -->
<!--                                    <div class="pull-left"> -->
<!--                                        <select id="skin-colorpicker" class="hide"> -->
<!--                                            <option data-skin="no-skin" value="#438EB9">#438EB9</option> -->
<!--                                            <option data-skin="skin-1" value="#222A2D">#222A2D</option> -->
<!--                                            <option data-skin="skin-2" value="#C6487E">#C6487E</option> -->
<!--                                            <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option> -->
<!--                                        </select> -->
<!--                                    </div> -->
<!--                                    <span>&nbsp; 换肤</span> -->
<!--                                </div> -->

<!--                                <div class="ace-settings-item"> -->
<!--                                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" /> <label class="lbl" for="ace-settings-navbar"> 锁定导航栏</label> -->
<!--                                </div> -->

<!--                                <div class="ace-settings-item"> -->
<!--                                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" /> <label class="lbl" for="ace-settings-sidebar"> 锁定侧边栏</label> -->
<!--                                </div> -->

<!--                                <div class="ace-settings-item"> -->
<!--                                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" /> <label class="lbl" for="ace-settings-breadcrumbs"> 锁定面包屑</label> -->
<!--                                </div> -->

<!--                                <div class="ace-settings-item"> -->
<!--                                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" /> <label class="lbl" for="ace-settings-rtl">左右置换</label> -->
<!--                                </div> -->

<!--                                <div class="ace-settings-item"> -->
<!--                                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" /> <label class="lbl" for="ace-settings-add-container"> 布局居中</b> -->
<!--                                    </label> -->
<!--                                </div> -->
<!--                            </div> -->
<!--                        </div> -->
<!--                    </div> -->
                    <!-- /.ace-settings-container -->

                    <div class="row">
                        <div class="col-xs-12">
                            <!-- PAGE CONTENT BEGINS -->
                            <sitemesh:write property='body' />
                            <!-- PAGE CONTENT ENDS -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.page-content -->
            </div>
        </div>
        <!-- /.main-content -->

        <div class="footer">
            <div class="footer-inner">
                <div class="footer-content">
                    <span class="bigger-120"> Copyright &copy; 2000-2016 <span class="blue bolder">XINHUANET.com</span>
                    </span>
                </div>
            </div>
        </div>

        <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
        </a>
    </div>
    <!-- /.main-container -->

    <!-- basic scripts -->

    <!--[if !IE]> -->
    <script src="http://zhibo.news.cn/rlnbj/commons/js/jquery-2.1.3.min.js"></script>
    <!-- <![endif]-->

    <!--[if IE]>
    <script src="http://zhibo.news.cn/rlnbj/commons/js/jquery-1.11.2.min.js"></script>
    <![endif]-->

    <!--[if IE]>
    <script type="text/javascript">
        window.jQuery || document.write("<script src='http://zhibo.news.cn/rlnbj/dist/js/jquery1x.min.js'>"+"<"+"/script>");
    </script>
    <![endif]-->

    <script src="http://zhibo.news.cn/rlnbj/dist/js/bootstrap.min.js"></script>

    <!-- ace scripts -->
    <script src="http://zhibo.news.cn/rlnbj/dist/js/ace-elements.min.js"></script>
    <script src="http://zhibo.news.cn/rlnbj/dist/js/ace.min.js"></script>

    <script type="text/javascript">
    if ('ontouchstart' in document.documentElement)
        document.write("<script src='http://zhibo.news.cn/rlnbj/dist/js/jquery.mobile.custom.min.js'>"    + "<"+"/script>");
    $(document).ready(
            function() {
                $("#${menuId}").addClass("active").parents("ul.nav-list li").addClass('active open');
            });
    </script>

    <sitemesh:write property='div.botton_javascript' />
</body>
</html>