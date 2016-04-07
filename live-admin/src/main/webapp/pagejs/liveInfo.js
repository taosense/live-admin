$(function(){
	if($(".liveVideoWrap").length>1){
		if(!$("#delVideobtn").is(":visible")){
                $("#delVideobtn").show();
        }
	}
	// 删除banner图
            $("#configInfoId").on('click',".initImgDelBtn",function(e){
                var $this=$(e.target).parent(".initImgDelBtn");
                var modularId=$this.attr("data-modualId");
              $this.parent().remove();
               // $this.parent().empty();
                var tempId = $("#templateId_id").val();
                var $currentTemplate = $("#template_"+tempId);
                var currentModular = $currentTemplate.find(".modual_"+modularId);
                currentModular.find(".bannerUploadBtnId_"+modularId).show();
                currentModular.find(".bannerUrlInput_"+modularId).val("");//设置input
              //设置数据存储
              updateModularBanner(modularId,"");
            });
    // 添加直播视频
    $("#addVideobtn").on('click',function(){

    	var num=$(".liveVideoWrap").length;
    
    	if($("#videoName_id_"+num).val()&&$("#videoList_id_"+num).val()){
    		num+=1;
            var $delVideobtn=$("#delVideobtn");
            var videoHtml='<div class="liveVideoWrap"><div class="infoWrap"><label for="videoName_id_'+num+'" class="col-xs-4">直播视频名称和地址：</label><input type="text" id="videoName_id_'+num+'" class="col-xs-6 videoName" placeholder="请输入直播视频名称（最多50字）"></div><div class="infoWrap"><label for="videoList_id_'+num+'" class="col-xs-4"></label><textarea placeholder="请输入直播视频地址" id="videoList_id_'+num+'" name="videoUrl" class="col-xs-6 descp" rows="3"></textarea></div></div>';
            //$(".addPhotoWrap").before($(videoHtml));
            $(".addPhotoWrap").prev().find(".liveVideoWrap").last().after($(videoHtml));
            if(!$delVideobtn.is(":visible")){
                $delVideobtn.show();
            }
    	} else {
    		alert("【直播视频名称】或【直播视频地址】存在空值！");
    	}
    });
    // 删除直播视频
    $("#delVideobtn").on("click",function(){
        var $delVideobtn=$("#delVideobtn");
        //$(this).parent().prev().remove();
        $(this).parent().prev().find(".liveVideoWrap").last().remove();
        
        if($(".liveVideoWrap").length==1){
            $delVideobtn.hide();
        }
    });
    
    
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

        
      
            // 点击添加节点，生成树
            $("#configInfoId").on('click','.tempAddNodes',function(){
            	var $ztreeNodeWrap=$("#ztreeNodesWrap");
                $.fn.zTree.init($ztreeNodeWrap, setting);
            });
            //【推送到】，点击添加节点，生成树
            $("#pushToChannelTreeLink").on('click',function(){
                var $ztreeNodeWrap=$("#ztreeNodesWrap");
                $.fn.zTree.init($ztreeNodeWrap, setting);
            });

            // 获取树节点value
            $("#ztreeNodesWrap").on('click',".node_name",function(e){
                $("#pushToChannelBtn").removeClass("hidden");
            	$("#pushToChannelDel").removeAttr("hidden");
            	var $this=$(e.target);
            	var nodeVal=$this.text();
            	var modularId=$("#modalHidden_id").val();
            	var channelId=$this.parent().attr("title");
            	if(modularId == 'pushToChannel'){//【推送到】，获取树节点
            		$("#pushToChannelBtn").text(nodeVal);
            		$("#channelName_id").val(nodeVal);
            		$("#channelId_id").val(channelId);
            		$(".pushToChannelClass").show();
            	} else {
                var $modual=$("#modual_"+modularId);
                $modual.find(".tempCon").text(nodeVal);
                
                $modual.find(".tempConBox").show();
                $modual.find(".tempCon-closeBtn").attr("data-modularId",modularId);
                updateModularChannel(modularId,channelId,nodeVal);
            	}            	
            });
             //【推送到】，删除树节点
            $("#pushToChannelDel").on('click',function(e){
               $("#pushToChannelBtn").text("");
               $("#channelName_id").val("");
               $("#channelId_id").val("");
               $(".pushToChannelClass").hide();
               /*$("#pushToChannelBtn").addClass("hidden");
           	   $("#pushToChannelDel").attr("hidden","hidden");*/
            });
            // 删除树节点
            $("#configInfoId").on('click',".tempCon-closeBtn",function(e){
            	var $this=$(e.target).parent(".tempCon-closeBtn");
            	var modularId=$this.attr("data-modularId");
                var $modual=$("#modual_"+modularId);
                $modual.find(".tempCon").text("");
                $modual.find(".tempConBox").hide();
                updateModularChannel(modularId,"","");
            });
            //TODO:添加 用户组
           // var liveUserGroupExist = null;//用来标记添加的用户组 是否已经存在
            $("#configInfoId").on('click',".selectAdd",function(e){
            	//获取选中的值
            	var modularId = $(e.target).attr("data-modularId");
            	var $addBtnWap = $(e.target).parent();
            	var $addValWap = $addBtnWap.prev().find(".tempGroupConBox");//此处添加html显示选中的组
            	//var $liverUserGroupSelect = $addValWap.find(".liverUserGroupSelect");
            	var $liverUserGroupSelect = $(e.target).prev();
            	var selectVal = $liverUserGroupSelect.val();
            	if(selectVal == -1){
            		alert("不能添加【无】");
            	} else{
            		var selectText = $liverUserGroupSelect.find("option:selected").text();
                var returnFlag = updateModularLiveUserGroup(modularId,selectVal,true);//验证是否该值已经存储 若不存在则添加数据
                //if(liveUserGroupExist != null){
                if(returnFlag == false){
                    alert("【"+selectText+"】已添加，请选择其他项。");
                    //liveUserGroupExist = null;
                }else{//页面元素显示
                    var addHtml = '<div class="tempConWrap" data-conId="'+selectVal+'"><button class="tempGroupCon btn btn-primary btn-xs">'+selectText+'</button><a href="javascript:void(0)" class="tempGroupCon-closeBtn" data-modularid="'+modularId +'"> <i class="ace-icon fa fa-times"></i></a></div>';
                    $addValWap.append(addHtml);
                    if(!$addValWap.is(":visible")){
                      $addValWap.show();
                    }
                }
            	}
            	
            });
            //TODO: 删除 用户组  
            $("#configInfoId").on('click',".tempGroupCon-closeBtn",function(e){
                var $this=$(e.target).parent(".tempGroupCon-closeBtn");
                var delValId = $this.parent().attr("data-conId");
                var modularId=$this.attr("data-modularId");
                updateModularLiveUserGroup(modularId,delValId,false);//在存储对象中删除 delValId
                //页面元素隐藏
                $this.parent().hide();
            });
          

      /*       $("#selectedArticlesWrap li").click(function(e){
             	 alert("dian ji");
                 var $this=$(e.target);
                 $this.remove();
                 //TODO:子页面对应条目  样式修改
             });*/
         /*   //保存模块中"稿件类型"信息
             $("#newsinfos-modal").on('click','.saveNewsInfo',function(){
             	//更新到模块页面显示
             	saveNewsInfo();
             	//更新数据存储
                 updateModularNewsInfo(modularId,title,summary,url,picUrl);
            });
             //取消模块中"稿件类型"信息修改
             $("#newsinfos-modal").on('click','.cancelNewsInfo',function(){
             	//清空数据 关闭模态框
                
            });*/
     
})

function saveLiveInfo(){
	var liveInfoFrom = document.getElementById("infoForm");
	if(check(liveInfoFrom)== true){
    document.getElementById("infoForm").submit();
	}
}
function manualReset(){
        //window.location.reload();
        document.getElementById("infoForm").reset();
        $("#configInfoId").html(modualsHtml);
        //$("#configInfoId").append(modualsHtml);
        
        setModular();//模板模块初始化 
        setVideoDiv();
        setTrialDiv();
        //图片初始化
        var $titlePicShow=$(".titlePicShow");
        var $titlePicWrap=$titlePicShow.find(".uploadedPicWrap");
        var $carousePicShow=$(".carousePicShow");
        var $carousePicWrap=$carousePicShow.find(".uploadedPicWrap");
        
        if(hiddenTitleImageInit){       
            if($titlePicWrap.length==0){
                var titlePicHtml='<div class="uploadedPicWrap" style="display:block"><img class="uploadedPic" name="uploadedPic" src="'+hiddenTitleImageInit+'"><a href="javascript:void(0);" class="imgDelBtn" style="display:block"><i class="ace-icon fa fa-trash-o bigger-150"></i></a></div>';                
                $titlePicShow.append($(titlePicHtml));
            }else{
                $titlePicShow.find(".uploadedPic").attr("src",hiddenTitleImageInit);
            }
            $(".titleUploadBtn").hide();        
        }else{
            $titlePicWrap.remove();
            $(".titleUploadBtn").show(); 
        }
        if(carouselImageInit){
            
           if($carousePicWrap.length==0){
                var carousePicHtml='<div class="uploadedPicWrap" style="display:block"><img class="uploadedPic" name="uploadedPic" src="'+carouselImageInit+'"><a href="javascript:void(0);" class="imgDelBtn" style="display:block"><i class="ace-icon fa fa-trash-o bigger-150"></i></a></div>'; 
                $carousePicShow.append($(carousePicHtml));
            }else{
                $carousePicShow.find(".uploadedPic").attr("src",carouselImageInit);
            }
            $(".carouseUploadBtn").hide();
        }else{
            $carousePicWrap.remove();
            $(".carouseUploadBtn").show();
        }
        //推送到 初始化
        //alert($("#channelName_id_Init").val());
        var channelNameInit= $("#channelName_id_Init").val();
        var channelIdInit = $("#channelId_id_Init").val();
        $("#pushToChannelBtn").text(channelNameInit);
        $("#channelName_id").val(channelNameInit);
        $("#channelId_id").val(channelIdInit);
        if(channelNameInit&&channelIdInit){
        	$(".pushToChannelClass").show();
        } else{
        	$(".pushToChannelClass").hide();
        }  
        //视频名称和url重置****start****
        $(".liveNameUrlWrap").html("");
        $(".liveNameUrlWrap").append(liveVideoInit);
        if($(".liveVideoWrap").length>1){//删除按钮的显示
        if(!$("#delVideobtn").is(":visible")){
                $("#delVideobtn").show();
        }
        }
        var currentTemplateId = $("#templateId_id").val();
        var currentTemplateType = null;
         $.each(templateArr, function(i, template) {//获取选中的模板类型
            if(template.templateId == currentTemplateId){
                currentTemplateType = template.contentType;
            }
        }); 
        if(currentTemplateType == 3){
            $(".liveVideoDivWrap").show();
        }else{
            $(".liveVideoDivWrap").hide();
        }
     
        //视频名称和url重置****end****
    }

    function setModalValue(modalId){
        $("#modalHidden_id").val(modalId);
    }
    function check(form) {
        if($.trim(form.name.value).length==0) {
              alert("请输入【直播名称】!");
              form.name.focus();
              return false;
         } else if($.trim(form.name.value).length>50){
         	  alert("【直播名称】的字数不能超过50！");
              form.name.focus();
              return false;
         } else{
             form.name.value = $.trim(form.name.value);
         }
        if($.trim(form.descp.value).length==0) {
            alert("请输入【直播简介】!");
            form.descp.focus();
             return false;
        } else if ($.trim(form.descp.value.length)>500){
        	alert("【直播简介】的字数不能超过500！");
            form.descp.focus();
            return false;
        } else{
            form.descp.value = $.trim(form.descp.value);
        }
        if($.trim(form.channelName.value).length==0||$.trim(form.channelId.value).length==0){
        	alert("【推送到】未添加内容！");
        	//$("#pushToChannelTreeLink").focus();
        	return false;
        }
//        $("#channelName_id").val(channelNameInit);
//        $("#channelId_id").val(channelIdInit);
      
        if($.trim(form.classify.value)==0) {
            alert("请选择【直播分类】!");
            form.classify.focus();
            return false;
        }
        if($.trim(form.startTime.value).length==0) {
            alert("请输入【开始时间】!");
            $("#showStartTime_id").focus();
            return false;
        }
        if(form.endTime.value!='') {
            var start = form.startTime.value.replace(/-/g,"/");
            var end = form.endTime.value.replace(/-/g,"/")
            if(new Date(start)>=new Date(end)){
                alert("结束时间必须大于开始时间！");
                $("#showEndTime_id").focus();
                return false;
            }
        }
        var reg=new RegExp("，","g"); //创建正则RegExp对象  
        var tags = form.tag.value;
        var newTags= tags.replace(reg,",");  
        form.tag.value = newTags;
        if(newTags.split(",").length>5 ) {
            alert("标签最多5个，以逗号分隔！");
            form.tag.focus();
            return false;
        } else {
            form.tag.value = $.trim(newTags);
        }
        form.titleImageUrl.value = $.trim(form.titleImageUrl.value);
        form.carouselImageUrl.value = $.trim(form.carouselImageUrl.value);
        //开启状态下 频道必填  start
       /* var channelCheckFlag = null;
        $.each(templateModulars, function(i, modular) {//开启状态下 频道必填
                if(modular.open == true&& modular.modularType==1){
                  if(!!!modular.channels||!!!modular.channels[0].channelId||!!!modular.channels[0].channelName){
                    alert("【"+modular.modularRealName+"】模块在开启状态下，必须添加【内容来源】！");
                    channelCheckFlag = false;
                    return false;
                  }
                }
        });
        if(channelCheckFlag == false){
        	$('#myTab li:eq(1) a').tab('show');//第二个标签页显示
        	return false;
        }*/
        //开启状态下 频道必填  end
        setWyhdTwzbOpenFlag();//设置网友互动和图文直播状态
        //选择文章模块 若存在自动更新 则liveModel设置自动更新 start  autoUpdateFlag_id
        setLiveModelAutoUpdateFlag();
         //$("#autoUpdateFlag_id").val("1");
        //选择文章模块 若存在自动更新 则liveModel设置自动更新 end
        $("#moduals_id").val(JSON.stringify(templateModulars));//设置模板模块隐藏域
        //设置视频名称和列表隐藏域****start****
        var currentTemplateId = $("#templateId_id").val();
        var currentTemplateType = null;
         $.each(templateArr, function(i, template) {//获取选中的模板类型
            if(template.templateId == currentTemplateId){
                currentTemplateType = template.contentType;
            }
        }); 
        if(currentTemplateType == 3){
        var videoNum = $(".liveVideoWrap").length//设置视频名称和列表隐藏域 
        var videoNameUrlArr = new Array();
        var videoTmp,videoNameTmp,videoUrlTmp;
        for(var i = 1;i <= videoNum; i++) {
            videoNameTmp = $.trim($("#videoName_id_"+i).val());
            videoUrlTmp = $.trim($("#videoList_id_"+i).val());
           if(videoNameTmp&&videoUrlTmp){
               if(videoNameTmp.length>50){
                 alert("【直播视频名称】的字数不能超过50！");
                $("#videoName_id_"+i).focus();
                return false;
               }
               videoUrlTmp = Base64.encode(videoUrlTmp);
               videoTmp = "{'name':'"+videoNameTmp+"','url':'"+videoUrlTmp+"'}";
              //  videoTmp = '{"name":"'+videoNameTmp+'","url":"'+videoUrlTmp+'"}';
               videoNameUrlArr.push(videoTmp);
           } else if(videoNameTmp){
               alert("【直播视频地址】为空！");
               $("#videoList_id_"+i).focus();
               return false;               
           } else if(videoUrlTmp){
               alert("【直播视频名称】为空！");
               $("#videoName_id_"+i).focus();
               return false;
           }
        }
        $("#videoNameUrl_id").val(JSON.stringify(videoNameUrlArr));
        } else {
        	$("#videoNameUrl_id").val("");
        }
        //设置视频名称和列表隐藏域****end****
        //代码统计： Base64.encode(videoUrlTmp);
         $("#statisCode_id").val(Base64.encode($.trim($("#statisCode_id").val())));
  
        var $titleImgEl=$(".titlePicShow").find(".uploadedPic");//设置图片上传隐藏域
        var $carouseImgEl=$(".carousePicShow").find(".uploadedPic");
        if($titleImgEl.length>0){
            $("#hiddenTitleImage").val($titleImgEl.attr("src"));
        }
        
        if($carouseImgEl.length>0){
            $("#carouselImage").val($carouseImgEl.attr("src"));
        }  
       return true;
       }
    //TODO:
    function setWyhdTwzbOpenFlag(){
        if(twzbId||wyhdId){
        	$.each(templateModulars, function(i, modular) {//从当前模板中选择图文直播模块 
            if(modular.modularId==twzbId){
               if(modular.open==true){
                $("#wyhdOpenFlag_id").val("1");
               }else if(modular.open==false){
               	$("#wyhdOpenFlag_id").val("0");
               }
            }
            if(modular.modularId==wyhdId){
               if(modular.open==true){
                $("#twzbOpenFlag_id").val("1");
               } else if(modular.open==false){
               	$("#twzbOpenFlag_id").val("0");
               }
            }
            });
        	
        }
    }
    function setLiveModelAutoUpdateFlag(){
    	   $.each(templateModulars, function(i, modular) {//从当前模板中选择类型为1的模块 选择文章模块
            if(modular.modularType==1){
               if(modular.channel){
               	if(modular.channel.autoUpdateFlag=="1"){
               		$("#autoUpdateFlag_id").val("1");
               		return false;
               	}
               }
            }
            });
    	   
    }
    function setModular(){
        selectedTemplateId = $("#templateId_id").val();
        $(".templateBox").each(function(){//设置要显示的模块
            if($(this).attr("id")=="template_"+selectedTemplateId){
                 $(this).css('display','block');
            } else{
                $(this).css('display','none'); 
            }
        });
        $.each(templateArr, function(i, template) {//模块数组
            if(template.templateId==selectedTemplateId){
                templateModulars = template.modularArr;
                //console.log(templateModulars);
                if(moduleListInit!=''&&selectedTemplateId ==selectedTemplateIdInit){
                    templateModulars = $.parseJSON(moduleListInit);
                     //console.log(templateModulars);
                }
            }
        });
       
    }  
    function changeModular(){
        if($("#templateId_id").val()==selectedTemplateId){
            return;
        }
        setModular();
        setVideoDiv();
        setTrialDiv();
    }
    function setVideoDiv(){
        //视频列表******start******
        var currentTemplateId = $("#templateId_id").val();
        var currentTemplateType = null;
         $.each(templateArr, function(i, template) {//获取选中的模板类型
            if(template.templateId == currentTemplateId){
                currentTemplateType = template.contentType;
            }
        }); 
        if(currentTemplateType == 3){
            $(".liveVideoDivWrap").show();
        }else{
            $(".liveVideoDivWrap").hide();
        }
        //视频列表******end******
    }
    //TODO:
    function setTrialDiv(){
    	var selectedText = $("#templateId_id").find("option:selected").text();
    	if(selectedText.indexOf("庭审")!=-1){
    	//if(selectedText.indexOf("直播")!=-1){
    		$(".trialInfo").css("display","block");
    	} else{
    		$(".trialInfo").css("display","none");
    	}
    	
    }
    function updateModular(modularId,key,value,btnId,otherBtnId){
        $.each(templateModulars, function(i, modular) {//开启或者关闭
            if(modular.modularId == modularId){
                modular[key] = value;
                var tempId = $("#templateId_id").val();
                var $currentTemplate = $("#template_"+tempId);
                var currentModular = $currentTemplate.find(".modual_"+modularId);
                if(value==true){
                    currentModular.find(".tempConFrom").removeClass("semitransparent");
                    currentModular.find(".addNodesWrap").removeClass("semitransparent");
                    currentModular.find(".bannerImgWrap").removeClass("semitransparent");
                } else if(value==false){
                    currentModular.find(".tempConFrom").removeClass("semitransparent");
                    currentModular.find(".tempConFrom").addClass("semitransparent");
                    currentModular.find(".addNodesWrap").removeClass("semitransparent");
                    currentModular.find(".addNodesWrap").addClass("semitransparent");
                    currentModular.find(".bannerImgWrap").removeClass("semitransparent");
                    currentModular.find(".bannerImgWrap").addClass("semitransparent");
                }
                 currentModular.find("."+btnId).attr("disabled","disabled");
                 currentModular.find("."+otherBtnId).removeAttr("disabled");
            }
        });
       
       
    }
    //更新频道
    function updateModularChannel(modularId,value,name){
        $.each(templateModulars, function(i, modular) {//删除或者增加频道 
            if(modular.modularId == modularId){
                var channelArr= new Array();
                var channel = {"channelId":value,"channelName":name};
                channelArr[0] = channel;
                modular.channels = channelArr;
            }
        });
    }
    //更新banner图
    function updateModularBanner(modularId,value){
       $.each(templateModulars, function(i, modular) {//删除或者增加bannerUrl
            if(modular.modularId == modularId){
            	if(value&&""!=value){
            		modular.bgUrl = value;
            	} else{
            		delete modular.bgUrl;//删除bgUrl属性
            	}
                
            }
        });
    }
    //更新“稿件类型”模块 相关信息
       function updateModularNewsInfo(modularId,title,summary,url,picUrl){
       $.each(templateModulars, function(i, modular) {//删除或者增加newsInfo相关信息
            if(modular.modularId == modularId){
            	var newsInfos={};
                if(title&&""!=title){//标题
                    newsInfos.title = title;
                } else{
                	if(modular.newsInfos){
                		delete modular.newsInfos.title;
                	}
                }
                if(summary&&""!=summary){//简介
                    newsInfos.summary = summary;
                } else{
                	if(modular.newsInfos){
                        delete modular.newsInfos.summary;
                    }                   
                }
                if(url&&""!=url){//链接地址
                    newsInfos.url = url;
                } else{
                	if(modular.newsInfos){
                       delete modular.newsInfos.url;
                    }                    
                }
                if(picUrl&&""!=picUrl){//上传图片地址
                    newsInfos.picUrl = picUrl;
                } else{
                	if(modular.newsInfos){
                       delete modular.newsInfos.picUrl;
                    }                  
                }
                modular.newsInfos = newsInfos;
          /*      console.log("modular.newsInfos************");
                console.log(modular.newsInfos);
                console.log(modular);
                console.log(templateModulars);
                console.log("modular.newsInfos***********");*/
            }
        });
    }
    
    //更新直播用户组
    function updateModularLiveUserGroup(modularId,value,isAdd){
       if(isAdd==true){//添加直播用户分组
//       	console.log("templateModulars start***");
//       	console.log(templateModulars);
//       	console.log("templateModulars end***");
       	var returnFlag;
       	 $.each(templateModulars, function(i, modular) {
            if(modular.modularId == modularId){
            	var tmpLiveUserGroup = modular.modularLiveUserGroup;
            	if(tmpLiveUserGroup){
            		if($.inArray(value,tmpLiveUserGroup)==-1){//添加的值不存在时候 才会添加
            			tmpLiveUserGroup.push(value);
            		} else{
            			//liveUserGroupExist = true;
            			returnFlag = false;
            			return false;//break;
            		}
            		
            	} else{
            		var tmpArr= new Array();
                    tmpArr[0] = value;
                	modular.modularLiveUserGroup = tmpArr;
            	}
            }
        });
        return returnFlag;
       } else if(isAdd==false){//删除直播用户分组
       	 $.each(templateModulars, function(i, modular) {
            if(modular.modularId == modularId){
            	var mluArr = modular.modularLiveUserGroup;
                if(mluArr){
                	var valoc = jQuery.inArray(value,mluArr);
                	if(valoc!=-1){
                		 mluArr.splice(valoc,1);//数组中删除value
                	}
                }
            }
        });
       }
       
    	//modularLiveUserGroup
    }
    function setPreview(){
    	//templateReview_${templateReview.templateId}
    	var templateId = $("#templateId_id").val();
    	$("#templateReviewWrap").find(".templateReview").hide();
    	$("#templateReview_"+templateId).show();
    }
    //banner图上传预处理
    function preUploadBannerPic(obj){
    	var $this = $(obj);
    	var modularId = $this.attr("data-modualId");
    	var $bannerUploadBtn = $this;
        var tmplateId = $("#templateId_id").val();
        var currentModular = $("#template_"+tmplateId).find(".modual_"+modularId);
    	var $bannerPicShow = currentModular.find(".bannerPicShow_"+modularId);
    	
    	var bannerUploadPic = new uploadImg({
            /*showEl : $(".bannerPicShow"),
            uploadBtnEl : $(".bannerUploadBtn"),*/
    		showEl : $bannerPicShow,
            uploadBtnEl : $bannerUploadBtn,
            uploadWrapEl : $(".uploadBannerBox"),
            hideUploadBtn : true,
            modalWrapEl : $("#bannerImg-modal"),
            modularId:modularId
        });
        bannerUploadPic.modualInit();
    }
    //TODO:稿件类型 模块信息修改预处理
    function preUploadNewsInfoPic(obj){
        var $this = $(obj);
        var modularId = $this.attr("data-modualId");
        var $bannerUploadBtn = $this;
         var tmplateId = $("#templateId_id").val();
         var currentModular = $("#template_"+tmplateId).find(".modual_"+modularId);
        var $bannerPicShow = currentModular.find(".bannerPicShow_"+modularId);// 无用
        //var $bannerPicShow = currentModular.find(".bannerPicShow_"+modularId);
        
        var bannerUploadPic = new uploadImg({
            showEl : $bannerPicShow,
            uploadBtnEl : $bannerUploadBtn,
            uploadWrapEl : $(".uploadNewsPicBox"),
            hideUploadBtn : true,
            modalWrapEl : $("#newsinfos-modal"),
            modularId:modularId
        });
        bannerUploadPic.modualNewsInfoInit();
        //模态框中模块信息 数据显示 newsInfos
       $("#newsInfoTitle").val($.trim(currentModular.find(".newsInfoTitleInput_"+modularId).val()));//标题
       $("#newsInfoDescp").val($.trim(currentModular.find(".newsDescp_"+modularId).val()));//简介
       $("#newsInfoLinkUrl").val($.trim(currentModular.find(".picLinkUrlInput_"+modularId).val()));//url
       var picUrl = $.trim(currentModular.find(".picUrlInput_"+modularId).val());
       $("#newsInfoPicUrl").val(picUrl);//picurl
       $("#newsInfoModualId").val(modularId);//模块ID
       
       if(picUrl){
       	//显示图片和删除按钮 div
       	$("#modalPicShow_id").attr("src",picUrl);
       	if(!$(".modalPicShow").is(":visible")){
       		$(".modalPicShow").show();
       	}
       /*	if($(".uploadNewsPicBox").is(":visible")){
            $(".uploadNewsPicBox").hide();
             $(".uploadNewsPicBox").css("display","none");
        }*/
         $("#uploadNewsPicBox").css("display","none");
       } else{
       	//显示上传图片 div
       	$("#modalPicShow_id").attr("src","");
       	/*if($(".modalPicShow").is(":visible")){
            $(".modalPicShow").hide();
        }*/
       	$(".modalPicShow").css("display","none");
       }               
    }
    //模态框中删除图片
    function modalPicDel(){
    	if($(".modalPicShow").is(":visible")){
            $(".modalPicShow").hide();
        }
        if(!$(".uploadNewsPicBox").is(":visible")){
            $(".uploadNewsPicBox").show();
        }
        $("#newsInfoPicUrl").val("");
    	
    }
    //TODO:稿件类型 模块信息修改后显示与保存
    function saveNewsInfo(){
       var moduleId = $("#newsInfoModualId").val();
      // var $modual = $("#modual_"+moduleId);
       var title = $.trim($("#newsInfoTitle").val());
       var summary = $.trim($("#newsInfoDescp").val());
       var url = $.trim($("#newsInfoLinkUrl").val());
       var picUrl = $.trim($("#newsInfoPicUrl").val());
       
        var tmplateId = $("#templateId_id").val();
        var currentModular = $("#template_"+tmplateId).find(".modual_"+moduleId);
       currentModular.find(".newsInfoTitleInput_"+moduleId).val(title);//标题
       currentModular.find(".newsDescp_"+moduleId).val(summary);//简介
       currentModular.find(".picLinkUrlInput_"+moduleId).val(url);//url
       currentModular.find(".picUrlInput_"+moduleId).val(picUrl);//picurl
       
       if(picUrl.length>0){//上传图片存在
       /*	if(!$modual.find(".uploadedPicWrap").is(":visible")){
       		 $modual.find(".uploadedPicWrap").find(".uploadedModularPic").attr("src",picUrl);
             $modual.find(".uploadedPicWrap").show();
             
        }*/
        currentModular.find(".uploadedPicWrap").find(".uploadedModularPic").attr("src",picUrl);
        currentModular.find(".uploadedPicWrap").css("display","block");
        if(currentModular.find(".bannerUploadBtn").is(":visible")){
             currentModular.find(".bannerUploadBtn").hide();
        }
       }
       if(picUrl.length==0){//上传图片不存在
        if(currentModular.find(".uploadedPicWrap").is(":visible")){
        	currentModular.find(".uploadedPicWrap").find(".uploadedModularPic").attr("src","");
            currentModular.find(".uploadedPicWrap").hide();
        }
        if(!currentModular.find(".bannerUploadBtn").is(":visible")){
                currentModular.find(".bannerUploadBtn").show();
        }
       }
       //模态框 隐藏
       $("#newsinfos-modal").modal("hide");
        //更新数据存储
       updateModularNewsInfo(moduleId,title,summary,url,picUrl);
    }
    //取消稿件模块 信息修改
    function cancelNewsInfo(){
    	 //模态框 隐藏
       $("#newsinfos-modal").modal("hide");
    
    }
    //选择文章模态框 数据预设
    function setArticleSelectModalValue(modularId){
    	   $("#articleHiddenModularId").val(modularId);
    	    var channelId,channelName,keywords,autoUpdateFlag,articles;
    	    var updateFlag = false;
    	    $.each(templateModulars, function(i, modular) {//从当前选中模板中获取模块信息
            if(modular.modularId == modularId){
              if(modular.channel){
              	updateFlag = true;
              	channelId = modular.channel.channelId;
              	channelName = modular.channel.channelName;
              	keywords = modular.channel.keywords;
              	autoUpdateFlag = modular.channel.autoUpdateFlag;
              	articles = modular.channel.articles;
              	
              	$("#modalChannel_id").val(channelId);
              	$("#ztreeValText").val(channelName);
                $("#keywords_id").val(keywords);
              
              if(autoUpdateFlag ==1){
                $("#articleSelect-modal").find("input[type=radio][name=autoUpdateFlag][value="+1+"]").click();
                } else {
                $("#articleSelect-modal").find("input[type=radio][name=autoUpdateFlag][value="+0+"]").click();
                }
                
               
                var liHtml = null;
                var ulDom = $("#selectedArticlesWrap");
                ulDom.find("li").remove();
               
                if(articles){
                 var articleNum = articles.length;
                
                $.each(articles, function(i, tmp) {
                	if(i==0&&articleNum==1){
                        liHtml = "<li id='"+tmp.CONTENT_ID+"' data-title='"+tmp.TITLE+"' data-pubUrl='"+tmp.PUBURL+"' data-description='"+tmp.DESCRIPTION+"' data-titleImg='"+tmp.TITLE_IMG+"' data-titleImgMiddle='"+tmp.TITLE_IMG_MIDDLE+"' data-titleImgSmall='"+tmp.TITLE_IMG_SMALL+"' data-typeImg='"+tmp.TYPE_IMG+"' data-typeImgMiddle='"+tmp.TYPE_IMG_MIDDLE+"' data-typeImgSmall='"+tmp.TYPE_IMG_SMALL+"'> <span class='articleTitleSpan'>"+tmp.TITLE+"</span><span class='upDownIconWrap pull-right'></span></li>";

                	} else if(i==0&&articleNum!=1){
                        liHtml = "<li id='"+tmp.CONTENT_ID+"' data-title='"+tmp.TITLE+"' data-pubUrl='"+tmp.PUBURL+"' data-description='"+tmp.DESCRIPTION+"' data-titleImg='"+tmp.TITLE_IMG+"' data-titleImgMiddle='"+tmp.TITLE_IMG_MIDDLE+"' data-titleImgSmall='"+tmp.TITLE_IMG_SMALL+"' data-typeImg='"+tmp.TYPE_IMG+"' data-typeImgMiddle='"+tmp.TYPE_IMG_MIDDLE+"' data-typeImgSmall='"+tmp.TYPE_IMG_SMALL+"'> <span class='articleTitleSpan'>"+tmp.TITLE+"</span><span class='upDownIconWrap pull-right'><i class='red glyphicon glyphicon-arrow-down'></i></span></li>";
                		
                	}else if(i==articleNum-1){
                        liHtml = "<li id='"+tmp.CONTENT_ID+"' data-title='"+tmp.TITLE+"' data-pubUrl='"+tmp.PUBURL+"' data-description='"+tmp.DESCRIPTION+"' data-titleImg='"+tmp.TITLE_IMG+"' data-titleImgMiddle='"+tmp.TITLE_IMG_MIDDLE+"' data-titleImgSmall='"+tmp.TITLE_IMG_SMALL+"' data-typeImg='"+tmp.TYPE_IMG+"' data-typeImgMiddle='"+tmp.TYPE_IMG_MIDDLE+"' data-typeImgSmall='"+tmp.TYPE_IMG_SMALL+"'> <span class='articleTitleSpan'>"+tmp.TITLE+"</span><span class='upDownIconWrap pull-right'><i class='green glyphicon glyphicon-arrow-up'></i></span></li>";

                	} else {
                		liHtml = "<li id='"+tmp.CONTENT_ID+"' data-title='"+tmp.TITLE+"' data-pubUrl='"+tmp.PUBURL+"' data-description='"+tmp.DESCRIPTION+"' data-titleImg='"+tmp.TITLE_IMG+"' data-titleImgMiddle='"+tmp.TITLE_IMG_MIDDLE+"' data-titleImgSmall='"+tmp.TITLE_IMG_SMALL+"' data-typeImg='"+tmp.TYPE_IMG+"' data-typeImgMiddle='"+tmp.TYPE_IMG_MIDDLE+"' data-typeImgSmall='"+tmp.TYPE_IMG_SMALL+"'> <span class='articleTitleSpan'>"+tmp.TITLE+"</span><span class='upDownIconWrap pull-right'><i class='green glyphicon glyphicon-arrow-up'></i><i class='red glyphicon glyphicon-arrow-down'></i></span></li>";
                	}
                	//liHtml = '<li id="'+tmp.CONTENT_ID+'" data-title="'+tmp.TITLE+'" data-pubUrl="'+tmp.PUBURL+'" data-description="'+tmp.DESCRIPTION+'" >'+tmp.TITLE+'</li>';
                    ulDom.append(liHtml);
                });
                }
                //搜索
                //setArticleSelectIframe(channelId,keywords,autoUpdateFlag);
                //setResultDiv(parseInt(autoUpdateFlag));
                if(autoUpdateFlag == "0"){
                refreshArticleIframe();
                }
                
                }
              }
             });
                if(!updateFlag){
                    $("#modalChannel_id").val("");
                    $("#ztreeValText").val("");
                    $("#keywords_id").val("");
                   
                $("#articleSelect-modal").find("input[type=radio][name=autoUpdateFlag][value="+0+"]").click();//设置radio被选中
                    var liListNum =  $("#selectedArticlesWrap li").length;
                    if(liListNum>0){
                    	$("#selectedArticlesWrap li").remove();
                    }
                   // setResultDiv(0);
                    refreshArticleIframe();
                }
               

    }
  function iFrameHeight() {//<iframe>标签自适应高度和宽度    
var ifm= document.getElementById("article_iframe");   
//var subWeb = document.frames ? document.frames["article_iframe"].document : ifm.contentDocument;  
var subDiv = $("#subList", $('#article_iframe')[0].contentWindow.document);
if(ifm != null && subWeb != null) {
   /*ifm.height = subWeb.body.scrollHeight;
   ifm.width = subWeb.body.scrollWidth;*/
	/*ifm.height = subDiv.height();;
   ifm.width = subDiv.width();*/
   ifm.height = subDiv.outerHeight();;
   ifm.width = subDiv.outerWidth();
}   
}   
