// 树配置
    var setting = {
            async: {
                enable: true,
                /*url:"http://censor.home.news.cn:8080/live-admin/getTreeData",*/
                url:"getTreeData",
                autoParam:["channelId"],
                datatype:"json",
                type: "post"
            },
            data: {
                key: {
                    name: "channelName",
                    title:"channelId"
                }
            }
        };


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
	$.fn.zTree.init($("#showTree"), setting);
	// 获取树节点value
    $("#showTree").on('click',".node_name",function(e){
        
        var $this=$(e.target);
        var nodeVal=$this.text();
        var channelId=$this.parent().attr("title");
        //设置频道的id与名称显示
        $("#modalChannel_id").val(channelId);
        $("#ztreeValText").val(nodeVal);
        var flag = $("input[type=radio][name=autoUpdateFlag]:checked").val();
        if(flag=="0"){//否
        	refreshArticleIframe();//刷新列表
        }
        
    });
    //查询按钮
    $("#articleSearch_id").on('click',function(){
      refreshArticleIframe();
    });
    //频道更改
   /*  $("#ztreeValText").change(function(){
     	alert("改变啦啦啦啦");
      refreshArticleIframe();
     });*/
     //清空频道
     $("#clearChannelBtn").on('click',function(){
       $("#modalChannel_id").val("");
       $("#ztreeValText").val("");
       var autoUpdateFlag = $("input[type=radio][name=autoUpdateFlag]:checked").val();
       if(autoUpdateFlag =="0"){
       	 refreshArticleIframe();//刷新列表
       }
      
    });
     //父页面 已选文章列表 点击
            $("#selectedArticlesWrap").on('click',".articleTitleSpan",function(e){
                 var $thisLi=$(e.target).parent();
                 var liNum = $thisLi.parent().find("li").length;
                 var liIndex = $thisLi.index();
                 var upIconHtml = $('<i class="green glyphicon glyphicon-arrow-up"></i>');
                 var downIconHtml = $('<i class="red glyphicon glyphicon-arrow-down"></i>');
                 if(liNum == 2){//总共2条 删除一条
                    if(liIndex == 0){
                      $thisLi.next().find(".glyphicon").remove();
                    } else {
                      $thisLi.prev().find(".glyphicon").remove();
                    }
                    
                 } if(liNum >= 2 && liIndex == 0){//多于两条 删除第一个
                    $thisLi.next().find(".glyphicon-arrow-up").remove();
                 } else if(liNum >= 2 && liIndex == liNum - 1){//多于两条 删除最后一个
                    $thisLi.prev().find(".glyphicon-arrow-down").remove();
                 }
                 $thisLi.remove();
                 //子页面对应条目  样式修改
                 $('#article_iframe')[0].contentWindow.setSelectedStyle();
                
            });
             $("#selectedArticlesWrap").on('click',".upDownIconWrap .glyphicon-arrow-up",function(e){
                 var $this = $(e.target);
                 var $thisLi=$(e.target).parent().parent();
                 var $prevLi = $thisLi.prev();
                 var upIconHtml = $('<i class="green glyphicon glyphicon-arrow-up"></i>');
                 var downIconHtml = $('<i class="red glyphicon glyphicon-arrow-down"></i>');
                // alert("向上哈哈");    //prev()  
               /*  if($thisLi.prev()){ // 如果存在下一个元素
                  $thisLi.after($thisLi.prev());
                } */
                 if($this.hasClass("hoverUpDown")){//颜色复原
                 	$this.removeClass("hoverUpDown");
                 }
                 if($thisLi.find(".articleTitleSpan").hasClass("hoverUpDown")){//颜色复原
                 	$thisLi.find(".articleTitleSpan").removeClass("hoverUpDown");
                 }
                var liNum = $thisLi.parent().find("li").length;
                var liIndex = $thisLi.index();
                if(liNum == 2 && liIndex == liNum - 1){//最后一个元素  总共两个
                    if($this.hasClass("glyphicon-arrow-up")){
                        $this.removeClass("glyphicon-arrow-up");
                        $this.addClass("glyphicon-arrow-down");
                    }
                    var nextLiIcon = $thisLi.prev().find("glyphicon-arrow-down");
                    if($this.hasClass("glyphicon-arrow-down")){
                        $this.removeClass("glyphicon-arrow-down");
                        $this.addClass("glyphicon-arrow-up");
                    }
                   /* if($prevLi){ // 如果存在上一个元素
                    $thisLi.after($prevLi);
                    } */
                } if(liNum >= 2 && liIndex == liNum - 1){//最后一个元素 多于两个
                    $thisLi.find(".upDownIconWrap").append(downIconHtml);
                    $prevLi.find(".glyphicon-arrow-down").remove();
                } if(liNum >= 2 && liIndex == 1){ //第二个元素 多于两个
                    $thisLi.find(".glyphicon-arrow-up").remove();
                    $prevLi.find(".upDownIconWrap").prepend(upIconHtml);
                }
                if($prevLi){ // 如果存在上一个元素
                    $thisLi.after($prevLi);
                } 
            });
              $("#selectedArticlesWrap").on('click',".upDownIconWrap .glyphicon-arrow-down",function(e){
                var $this = $(e.target);
                var $thisLi=$(e.target).parent().parent();
                var $nextLi=$thisLi.next();
                var upIconHtml = $('<i class="green glyphicon glyphicon-arrow-up"></i>');
                var downIconHtml = $('<i class="red glyphicon glyphicon-arrow-down"></i>');
                /*if($thisLi.next()){ // 如果存在下一个元素
                   $thisLi.next().after($thisLi);    // 就将此元素插到下一个元素之后，从而实现互换顺序
                }    */               
                // alert("向下哈哈"); 
                 if($this.hasClass("hoverUpDown")){//颜色复原
                    $this.removeClass("hoverUpDown");
                 }
                 if($thisLi.find(".articleTitleSpan").hasClass("hoverUpDown")){//颜色复原
                    $thisLi.find(".articleTitleSpan").removeClass("hoverUpDown");
                 }
                var liNum = $thisLi.parent().find("li").length;
                var liIndex = $thisLi.index();
                if(liNum == 2 && liIndex == 0){//第一个元素 总共两个
                    if($this.hasClass("glyphicon-arrow-down")){
                        $this.removeClass("glyphicon-arrow-down");
                        $this.addClass("glyphicon-arrow-up");
                    }
                    var nextLiIcon = $thisLi.next().find("glyphicon-arrow-up");
                    if($this.hasClass("glyphicon-arrow-up")){
                        $this.removeClass("glyphicon-arrow-up");
                        $this.addClass("glyphicon-arrow-down");
                    }
                } else if(liNum > 2 && liIndex==0){//第一个元素 多于两个
                    $thisLi.find(".upDownIconWrap").prepend(upIconHtml);
                    $nextLi.find(".glyphicon-arrow-up").remove();
                } else if(liNum > 2 && liNum-2 == liIndex){//倒数第二个元素
                    $thisLi.find(".glyphicon-arrow-down").remove();
                    $nextLi.find(".upDownIconWrap").append(downIconHtml);
                }
                if($nextLi){ 
                       $nextLi.after($thisLi);    // 就将此元素插到下一个元素之后，从而实现互换顺序
                }   
              
            });
   
    function refreshArticleIframe(){
      var keywords = $("#keywords_id").val();
      //TODO:中文逗号转换成英文逗号
      var reg=new RegExp("，","g"); 
      keywords= keywords.replace(reg,","); 
      var autoUpdateFlag = $("input[type=radio][name=autoUpdateFlag]:checked").val();
      var newSrc = 'articleList?channelId='+$("#modalChannel_id").val()+'&keywords='+keywords+'&autoUpdateFlag='+$('input[type=radio][name=autoUpdateFlag]:checked').val()+'&siteId='+siteId;
      $("#article_iframe").attr("src",newSrc);
    }
     //取消文章 信息修改
    function canselArticleUpdate(){
         //模态框 隐藏
       $("#articleSelect-modal").modal("hide");
    
    }
    //保存文章 信息修改
    function saveArticleModel(){
    	var modularId = $("#articleHiddenModularId").val();
    	var channelId = $("#modalChannel_id").val();
    	var channelName = $.trim($("#ztreeValText").val());
    	var keywords = $.trim($("#keywords_id").val());
    	var reg=new RegExp("，","g"); 
        keywords= keywords.replace(reg,","); 
        var autoUpdateFlag = $("#articleSelect-modal").find('input[type=radio][name=autoUpdateFlag]:checked').val();
        if(autoUpdateFlag=="1"){
        	if(!(channelId||keywords)){
        		alert("是否自动更新为【是】，则【所选栏目】和【关键词】不能全为空。");
        		return;
        	}
        }
        var articles = new Array(); 
        //已选列表
        var liList = $("#selectedArticlesWrap li");
        var tmpLi;
        for(var i=0;i<liList.length;i++){
        	//item = $.parse(liList[i].attr("data-value"));
        	tmpLi = $(liList[i]);
        	var tmpArticle = {};
        	tmpArticle.CONTENT_ID = tmpLi.attr("id");
        	tmpArticle.TITLE = tmpLi.attr("data-title");
        	tmpArticle.PUBURL = tmpLi.attr("data-pubUrl");
        	tmpArticle.DESCRIPTION = tmpLi.attr("data-description");
        	
        	tmpArticle.TITLE_IMG = tmpLi.attr("data-titleImg");
            tmpArticle.TITLE_IMG_MIDDLE = tmpLi.attr("data-titleImgMiddle");
            tmpArticle.TITLE_IMG_SMALL = tmpLi.attr("data-titleImgSmall");
            
            tmpArticle.TYPE_IMG = tmpLi.attr("data-typeImg");
            tmpArticle.TTYPE_IMG_MIDDLE = tmpLi.attr("data-typeImgMiddle");
            tmpArticle.TYPE_IMG_SMALL = tmpLi.attr("data-typeImgSmall");
        	
        	articles.push(tmpArticle);
        }
        if(autoUpdateFlag=="0"){
            if(articles.length==0){
                alert("是否自动更新为【否】，已选文章列表不能为空");
                return;
            }
        } else if(autoUpdateFlag=="1"){
        	articles = '';//数据存储修改
        	$("#selectedArticlesWrap li").remove();//页面显示修改
        }
      
        //模态框 隐藏
        $("#articleSelect-modal").modal("hide");
    	updateModularArticleInfo(modularId,channelId,channelName,keywords,autoUpdateFlag,articles);
        updateShowArticleWrap(modularId,channelName,keywords,autoUpdateFlag);
    }
    //更新文章模块 显示
    function updateShowArticleWrap(modularId,channelName,keywords,autoUpdateFlag){
    	var currentTmplate = $("#templateId_id").val();
    	var divWrap = $("#template_"+currentTmplate).find(".modual_"+modularId);
    	var ulWrap = divWrap.find(".showSelectedArticleWrap");
    	ulWrap.find("li").remove();
    	//ulWrap.append($("#selectedArticlesWrap li").clone());
    	var selectedList = $("#selectedArticlesWrap li");
    	$.each(selectedList,function(i,item){
    		var $this = $(item);
            var dataTitle=$this.attr("data-title");
            var id=$this.attr("id");
           /* var dataPuburl=$this.attr("data-puburl");
            var dataDescription=$this.attr("data-description");*/
            var liHtml = '<li id="'+id+'"><span class="articleTitleSpan">'+dataTitle+'</span><span class="upDownIconWrap"></span></li>';
    	    ulWrap.append($(liHtml));
    	});
    	if(channelName){
    		divWrap.find(".articleSearchChannel").text(channelName);
    	} else {
    		divWrap.find(".articleSearchChannel").text('无');
    	}
    	if(keywords){
            divWrap.find(".articleSearchKeywords").text(keywords);
        } else {
            divWrap.find(".articleSearchKeywords").text('无');
        }
        if(autoUpdateFlag == "1"){
            divWrap.find(".articleSearchUpdate").text('是');
        } else if(autoUpdateFlag == "0"){
            divWrap.find(".articleSearchUpdate").text('否');
        }
    
    }
    //更新文章模块 数据存储
    function updateModularArticleInfo(modularId,channelId,channelName,keywords,autoUpdateFlag,articles){
       $.each(templateModulars, function(i, modular) {//删除或者增加articleInfo相关信息
            if(modular.modularId == modularId){
                var channel={};
                channel.autoUpdateFlag = parseInt(autoUpdateFlag);//是否自动更新        
                channel.siteId = siteId;//保存站点
                if(channelId&&""!=channelId){//频道
                    channel.channelId = parseInt(channelId);
                    channel.channelName = channelName;
                } else{
                    if(modular.channel){
                        delete modular.channel.channelId;
                        delete modular.channel.channelName;
                    }
                }
                if(keywords&&""!=keywords){//关键词
                    channel.keywords = keywords;
                } else{
                    if(modular.channel){
                        delete modular.channel.summary;
                    }                   
                }
                if(articles&&""!=articles){//文章列表
                    channel.articles = articles;
                } else{
                    if(modular.channel){
                       delete modular.channel.articles;
                    }                    
                }              
                modular.channel = channel;
              /*console.log("modular.channel************");
                console.log(modular.channel);
                console.log(modular);
                console.log(templateModulars);
                console.log("modular.channel***********");*/
            }
        });
    }
    //鼠标经过 高亮显示
    /* $("#selectedArticlesWrap li .articleTitleSpan").hover(function () {  
            $(this).addClass("liOnhover");  
        }, function () {  
            $(this).removeClass("liOnhover");  
        }); 
      $("#selectedArticlesWrap li:even").css("background-color", "#333");   //奇数行
      $("#selectedArticlesWrap li:odd").css("background-color", "blue");//偶数行
      
      $("#selectedArticlesWrap li").on('mouseover',".articleTitleSpan",function(e){
      	alert("鼠标经过啦");
      	//$(this).css({"backgroud":blue});
    });
*/
  /* $("#selectedArticlesWrap  li").hover(function () {  
                      $(this).addClass("hoverGrey"); 
                }, function () {
                    $(this).removeClass("hoverGrey"); 
                   
             });*/
     $("#selectedArticlesWrap").on('mouseover','.articleTitleSpan',function(){//鼠标经过标题
     	$(this).parent().addClass("hoverGrey");
    });
     $("#selectedArticlesWrap").on('mouseout','.articleTitleSpan',function(){//鼠标离开标题
        $(this).parent().removeClass("hoverGrey");
    });
      $("#selectedArticlesWrap").on('mouseover','.upDownIconWrap .glyphicon-arrow-up,.upDownIconWrap .glyphicon-arrow-down',function(){//鼠标经过向上向下箭头
      	var $this = $(this);
      	$this.addClass("hoverUpDown");
        $this.parent().parent().find(".articleTitleSpan").addClass("hoverUpDown");
        if($this.hasClass("glyphicon-arrow-up")){$this.removeClass("green");}
        if($this.hasClass("glyphicon-arrow-down")){$this.removeClass("red");}
    });
     $("#selectedArticlesWrap").on('mouseout','.upDownIconWrap .glyphicon-arrow-up,.upDownIconWrap .glyphicon-arrow-down',function(){//鼠标离开向上向下箭头
        //$(this).removeClass("hoverUpDown");
     	var $this = $(this);
          $this.parent().parent().find(".articleTitleSpan").removeClass("hoverUpDown");
        
         if($this.hasClass("glyphicon-arrow-up")){ 
         	 $this.removeClass("hoverUpDown glyphicon glyphicon-arrow-up");
            $this.addClass("green glyphicon glyphicon-arrow-up");
         }
        if($this.hasClass("glyphicon-arrow-down")){
        	 $this.removeClass("hoverUpDown glyphicon glyphicon-arrow-down");
        	$this.addClass("red glyphicon glyphicon-arrow-down");
        }
    });
    //articleListWrap
    function setResultDiv(value){
       if(value==1){//是
       	$("#articleListWrap").hide();
       }
       if(value==0){//否
       	refreshArticleIframe();
   	    $("#articleListWrap").show();
   	    
       }
    	
    }
    