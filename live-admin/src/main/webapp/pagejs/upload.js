 function uploadImg(opts){
  this.opts=$.extend({},uploadImg.DEFAULTS,opts);
  var opts=this.opts;
  // 展示确认上传的图片容器
  this.showEl=opts.showEl;
  // 上传图片的按钮
  this.uploadBtnEl=opts.uploadBtnEl;
  // 上传容器
  this.uploadWrapEl=opts.uploadWrapEl;
  // 确定上传后是否隐藏上传按钮
  this.hideUploadBtn=opts.hideUploadBtn;
  // 弹出层容器
  this.modalWrapEl=opts.modalWrapEl;
  //模板id
  this.modularId =opts.modularId;
}

// 初始化
uploadImg.prototype.init=function(){
  var _t=this;
  _t.appendUploadDom();
  _t.uploadImg();
  _t.delUploadImg();
}
//banner图上传初始化
uploadImg.prototype.modualInit=function(){
  var _t=this;
  _t.modualAppendHtml();
  _t.modularUploadImg();
  _t.modularDelUploadImg();
}
//稿件类型模块 图片上传初始化
uploadImg.prototype.modualNewsInfoInit=function(){
  var _t=this;
  _t.modualAppendHtml();
  _t.modularNewsInfoUploadImg();
}

// 生成上传图片模块html
uploadImg.prototype.appendUploadDom=function(){
  var _t=this;
  _t.uploadBtnEl.on('click',function(){
    var uploadHtml='<div class="mediaChoose">'+
    '<div class="uploadPicFile">'+
    '<div class="uploadPicFile_fileWrap">'+
    '<span class="uploadPicFile_fileImg"></span>'+
    '<input class="filename uploadPicFile_fileBtn" type="file" name="file" size="56">'+
    '</div>'+
    '<div class="uploadedPicWrap">'+
    '<img class="uploadedPic" name="uploadedPic" src="">'+
    '<a href="javascript:void(0);" class="imgDelBtn"><i class="ace-icon fa fa-trash-o bigger-150"></i></a>'+
    '</div>'+
    '<div class="uploadPicFile_btnWrap">'+
    '<a class="upload_btn_confirm" href="javascript:void(0);">确定上传</a>'+
    '<a class="upload_btn_cancel" href="javascript:void(0);">取消</a>'+
    '</div>'+
    '</div>'+
    '</div>';

    /*$(".mediaChoose").length>0 && ($(".mediaChoose").remove())*/
    _t.uploadWrapEl.find(".mediaChoose").length>0&&_t.uploadWrapEl.find(".mediaChoose").remove();
    _t.uploadWrapEl.append($(uploadHtml));
  });
}

uploadImg.prototype.modualAppendHtml = function (){
	var _t=this;
    var uploadHtml='<div class="mediaChoose">'+
    '<div class="uploadPicFile">'+
    '<div class="uploadPicFile_fileWrap">'+
    '<span class="uploadPicFile_fileImg"></span>'+
    '<input class="filename uploadPicFile_fileBtn" type="file" name="file" size="56">'+
    '</div>'+
    '<div class="uploadedPicWrap">'+
    '<img class="uploadedPic" name="uploadedPic" src="">'+
    '<a href="javascript:void(0);" class="imgDelBtn"><i class="ace-icon fa fa-trash-o bigger-150"></i></a>'+
    '</div>'+
    '<div class="uploadPicFile_btnWrap">'+
    '<a class="upload_btn_confirm" href="javascript:void(0);">确定上传</a>'+
    '<a class="upload_btn_cancel" href="javascript:void(0);">取消</a>'+
    '</div>'+
    '</div>'+
    '</div>';

    /*$(".mediaChoose").length>0 && ($(".mediaChoose").remove())*/
    _t.uploadWrapEl.find(".mediaChoose").length>0&&_t.uploadWrapEl.find(".mediaChoose").remove();
    _t.uploadWrapEl.append($(uploadHtml));
}

// 图片上传
uploadImg.prototype.uploadImg=function(){
	var _t=this;
   _t.modalWrapEl.on('change','.filename',function (e) {
    $("#formContent").remove();
    var $e = $(e.target),
    $uploadWrap = $(".mediaChoose"),
    $fileWrap=$uploadWrap.find(".uploadPicFile_fileWrap"),
    $fileImg=$fileWrap.find(".uploadPicFile_fileImg"),
    $uploadedPicWrap=$uploadWrap.find(".uploadedPicWrap"),
    $uploadedPic=$uploadedPicWrap.find(".uploadedPic"),
    $picBtnWrap=$uploadWrap.find(".uploadPicFile_btnWrap"),
    $confirmBtn=$uploadWrap.find(".upload_btn_confirm"),
    $delImgBtn=$uploadWrap.find(".imgDelBtn"),
    uploadImgUrl = '',
    fileVal = $e.val(),
    fileType = '',
    fileArr = fileVal.split('.');
    fileArr.length > 1 && (fileType = fileArr[1]);

    if (fileType != 'jpeg' && fileType != 'jpg' && fileType != 'bmp' && fileType != 'gif' && fileType != 'png' && fileType != 'JPG' && fileType != 'BMP' && fileType != 'GIF' && fileType != 'PNG') {
      alert('图片格式不正确！');
    }else{
     $fileImg.addClass('uploadPicFile_loading');
     uploadImgUrl = 'http://xuan.news.cn/photo1/service/upload.do';
     var c=window.location.origin;
     var formHtml = '<div id="formContent" style="display:none">'+
     '<form id="uploadForm" action="' + uploadImgUrl + '" target="uploadResponse" method="post" enctype="multipart/form-data">'+
     '<input type="hidden" name="title" value="图片上传">'+
     '<input type="hidden" name="o" value=1>'+
     '<input type="hidden" name="tagWords" value="直播">'+
     '<input type="hidden" name="appType" value=400>'+
     '<input type="hidden" name="c" value="'+c+'">'+
     '<input type="hidden" name="categoryCode" value=1>'+
     '<input type="hidden" name="r" value="R">'+
     '</form>'+
     '</div>';
     $uploadWrap.append($(formHtml));
     var uploadForm = $("#uploadForm");
     uploadForm.append($e);

     var formdata = new FormData( uploadForm[0] );
     $.ajax({
      url: "http://xuan.news.cn/photo1/service/upload.do",
      // url: "http://192.168.85.73:8001/photo1/service/upload.do",
       type: "post",
       data: formdata,    
       dataType: 'json',
       processData: false,
       contentType: false,
       success: function(data){
        var content=data.content;
        var imgUrl=content.originalUrl;
        $fileWrap.hide();
        //$uploadedPic.attr("src","http://tpic.home.news.cn/xhCloudNewsPic/"+imgUrl);//初始版本
        $uploadedPic.attr("src","http://tpic.home.news.cn/photogallery/"+imgUrl);//刘洋版本
        //  $uploadedPic.attr("src","http://192.168.83.150/"+imgUrl);
        $uploadedPicWrap.show();
        $picBtnWrap.show();

      },
      error: function(data){
        $fileImg.removeClass('uploadPicFile_loading');
        var inputHtml = '<input class="filename uploadPicFile_fileBtn" type="file" name="file" size="56">';
        $fileWrap.append($(inputHtml));

      }
    });

     // 取消上传
     $(".upload_btn_cancel").on('click',function(){
      $fileImg.removeClass('uploadPicFile_loading');
      var inputHtml = '<input class="filename uploadPicFile_fileBtn" type="file" name="file" size="56">';
      $fileWrap.append($(inputHtml)).show();
      $uploadedPicWrap.hide();
      $picBtnWrap.hide();
    });

     // 确定上传
     $confirmBtn.on('click',function(){
      $uploadedPicWrap.find(".imgDelBtn").show();
      _t.showEl.append($uploadedPicWrap);
      _t.modalWrapEl.modal("hide");
      if(_t.hideUploadBtn){
      	_t.uploadBtnEl.hide();
      }
    });

   
   }

 });
}

// banner图片上传
uploadImg.prototype.modularUploadImg=function(){
    var _t=this;
   _t.modalWrapEl.on('change','.filename',function (e) {
    $("#formContent").remove();
    var $e = $(e.target),
    $uploadWrap = $(".mediaChoose"),
    $fileWrap=$uploadWrap.find(".uploadPicFile_fileWrap"),
    $fileImg=$fileWrap.find(".uploadPicFile_fileImg"),
    $uploadedPicWrap=$uploadWrap.find(".uploadedPicWrap"),
    $uploadedPic=$uploadedPicWrap.find(".uploadedPic"),
    $picBtnWrap=$uploadWrap.find(".uploadPicFile_btnWrap"),
    $confirmBtn=$uploadWrap.find(".upload_btn_confirm"),
    $delImgBtn=$uploadWrap.find(".imgDelBtn"),
    uploadImgUrl = '',
    fileVal = $e.val(),
    fileType = '',
    fileArr = fileVal.split('.');
    fileArr.length > 1 && (fileType = fileArr[1]);

    if (fileType != 'jpeg' && fileType != 'jpg' && fileType != 'bmp' && fileType != 'gif' && fileType != 'png' && fileType != 'JPG' && fileType != 'BMP' && fileType != 'GIF' && fileType != 'PNG') {
      alert('图片格式不正确！');
    }else{
     $fileImg.addClass('uploadPicFile_loading');
     uploadImgUrl = 'http://xuan.news.cn/photo1/service/upload.do';
     var c=window.location.origin;
     var formHtml = '<div id="formContent" style="display:none">'+
     '<form id="uploadForm" action="' + uploadImgUrl + '" target="uploadResponse" method="post" enctype="multipart/form-data">'+
     '<input type="hidden" name="title" value="图片上传">'+
     '<input type="hidden" name="o" value=1>'+
     '<input type="hidden" name="tagWords" value="直播">'+
     '<input type="hidden" name="appType" value=400>'+
     '<input type="hidden" name="c" value="'+c+'">'+
     '<input type="hidden" name="categoryCode" value=1>'+
     '<input type="hidden" name="r" value="S">'+
     '</form>'+
     '</div>';
     $uploadWrap.append($(formHtml));
     var uploadForm = $("#uploadForm");
     uploadForm.append($e);

     var formdata = new FormData( uploadForm[0] );
     $.ajax({
      url: "http://xuan.news.cn/photo1/service/upload.do",
      // url: "http://192.168.85.73:8001/photo1/service/upload.do",
       type: "post",
       data: formdata,    
       dataType: 'json',
       processData: false,
       contentType: false,
       success: function(data){
        var content=data.content;
        var imgUrl=content.originalUrl;
        $fileWrap.hide();
        //$uploadedPic.attr("src","http://tpic.home.news.cn/xhCloudNewsPic/"+imgUrl);//初始版本
        $uploadedPic.attr("src","http://tpic.home.news.cn/photogallery/"+imgUrl);//刘洋版本
        //  $uploadedPic.attr("src","http://192.168.83.150/"+imgUrl);
        $uploadedPicWrap.show();
        $picBtnWrap.show();

      },
      error: function(data){
        $fileImg.removeClass('uploadPicFile_loading');
        var inputHtml = '<input class="filename uploadPicFile_fileBtn" type="file" name="file" size="56">';
        $fileWrap.append($(inputHtml));

      }
    });

     // 取消上传
     $(".upload_btn_cancel").on('click',function(){
      $fileImg.removeClass('uploadPicFile_loading');
      var inputHtml = '<input class="filename uploadPicFile_fileBtn" type="file" name="file" size="56">';
      $fileWrap.append($(inputHtml)).show();
      $uploadedPicWrap.hide();
      $picBtnWrap.hide();
    });

     // 确定上传
     $confirmBtn.on('click',function(){
      $uploadedPicWrap.find(".imgDelBtn").show();
      _t.showEl.append($uploadedPicWrap);
      _t.modalWrapEl.modal("hide");
      if(_t.hideUploadBtn){
        _t.uploadBtnEl.hide();
      }
      //获取pic url地址 填充input输入框  
      //$("#bannerUrlInput_"+_t.modularId).val($uploadedPic.attr("src"));
       var tmplateId = $("#templateId_id").val();
       var currentModular = $("#template_"+tmplateId).find(".modual_"+_t.modularId);
      currentModular.find(".hiddenUrlInput").val($uploadedPic.attr("src"));
      //设置数据存储
      updateModularBanner(_t.modularId,$uploadedPic.attr("src"));
    });

   
   }

 });
}
//banner图片删除
uploadImg.prototype.modularDelUploadImg=function(){
    var _t=this;
      // 删除已上传的图片
     _t.showEl.on('click','.imgDelBtn',function(){
       $(this).parents(".uploadedPicWrap").remove();
       if(_t.hideUploadBtn){
      /*    if(_t.showEl.hasClass("titlePicShow")){
            $("#hiddenTitleImage").val("");
            $("#titleImageUrl_id").val("");
        }
         if(_t.showEl.hasClass("carousePicShow")){
            $("#carouselImage").val("");
            $("#carouselImageUrl_id").val("");
        }*/
        
        _t.uploadBtnEl.show();
        //$("#bannerUrlInput_"+_t.modularId).val("");//设置input
        $("#modual_"+_t.modularId).find(".hiddenUrlInput").val("");
        //设置数据存储
        updateModularBanner(_t.modularId,"");
      }
     });    
}
// newInfos图片上传
uploadImg.prototype.modularNewsInfoUploadImg=function(){
    var _t=this;
   _t.modalWrapEl.on('change','.filename',function (e) {
    $("#formContent").remove();
    var $e = $(e.target),
    $uploadWrap = $(".mediaChoose"),
    $fileWrap=$uploadWrap.find(".uploadPicFile_fileWrap"),
    $fileImg=$fileWrap.find(".uploadPicFile_fileImg"),
    $uploadedPicWrap=$uploadWrap.find(".uploadedPicWrap"),
    $uploadedPic=$uploadedPicWrap.find(".uploadedPic"),
    $picBtnWrap=$uploadWrap.find(".uploadPicFile_btnWrap"),
    $confirmBtn=$uploadWrap.find(".upload_btn_confirm"),
    $delImgBtn=$uploadWrap.find(".imgDelBtn"),
    uploadImgUrl = '',
    fileVal = $e.val(),
    fileType = '',
    fileArr = fileVal.split('.');
    fileArr.length > 1 && (fileType = fileArr[1]);

    if (fileType != 'jpeg' && fileType != 'jpg' && fileType != 'bmp' && fileType != 'gif' && fileType != 'png' && fileType != 'JPG' && fileType != 'BMP' && fileType != 'GIF' && fileType != 'PNG') {
      alert('图片格式不正确！');
    }else{
     $fileImg.addClass('uploadPicFile_loading');
     uploadImgUrl = 'http://xuan.news.cn/photo1/service/upload.do';
     var c=window.location.origin;
     var formHtml = '<div id="formContent" style="display:none">'+
     '<form id="uploadForm" action="' + uploadImgUrl + '" target="uploadResponse" method="post" enctype="multipart/form-data">'+
     '<input type="hidden" name="title" value="图片上传">'+
     '<input type="hidden" name="o" value=1>'+
     '<input type="hidden" name="tagWords" value="直播">'+
     '<input type="hidden" name="appType" value=400>'+
     '<input type="hidden" name="c" value="'+c+'">'+
     '<input type="hidden" name="categoryCode" value=1>'+
     '<input type="hidden" name="r" value="S">'+
     '</form>'+
     '</div>';
     $uploadWrap.append($(formHtml));
     var uploadForm = $("#uploadForm");
     uploadForm.append($e);

     var formdata = new FormData( uploadForm[0] );
     $.ajax({
      url: "http://xuan.news.cn/photo1/service/upload.do",
      // url: "http://192.168.85.73:8001/photo1/service/upload.do",
       type: "post",
       data: formdata,    
       dataType: 'json',
       processData: false,
       contentType: false,
       success: function(data){
        var content=data.content;
        var imgUrl=content.originalUrl;
        $fileWrap.hide();
        //$uploadedPic.attr("src","http://tpic.home.news.cn/xhCloudNewsPic/"+imgUrl);//初始版本
        $uploadedPic.attr("src","http://tpic.home.news.cn/photogallery/"+imgUrl);//刘洋版本
        //  $uploadedPic.attr("src","http://192.168.83.150/"+imgUrl);
        $uploadedPicWrap.show();
        $picBtnWrap.show();
        //获取pic url地址 填充modal框中的input输入框  
       $("#newsInfoPicUrl").val($uploadedPic.attr("src"));
       $confirmBtn.css("display","none");//隐藏确定上传按钮

      },
      error: function(data){
        $fileImg.removeClass('uploadPicFile_loading');
        var inputHtml = '<input class="filename uploadPicFile_fileBtn" type="file" name="file" size="56">';
        $fileWrap.append($(inputHtml));

      }
    });

     // 取消上传
     $(".upload_btn_cancel").on('click',function(){
      $fileImg.removeClass('uploadPicFile_loading');
      var inputHtml = '<input class="filename uploadPicFile_fileBtn" type="file" name="file" size="56">';
      $fileWrap.append($(inputHtml)).show();
      $uploadedPicWrap.hide();
      $picBtnWrap.hide();
      $("#newsInfoPicUrl").val("");
    });

     // 确定上传
 /*    $confirmBtn.on('click',function(){

      //获取pic url地址 填充modal框中的input输入框  
      //$("#newsInfoPicUrl").val($uploadedPic.attr("src"));
     
    });*/

   
   }

 });
}

uploadImg.prototype.delUploadImg=function(){
    var _t=this;
      // 删除已上传的图片
     _t.showEl.on('click','.imgDelBtn',function(){
       $(this).parents(".uploadedPicWrap").remove();
       if(_t.hideUploadBtn){
        if(_t.showEl.hasClass("titlePicShow")){
            $("#hiddenTitleImage").val("");
            $("#titleImageUrl_id").val("");
        }
         if(_t.showEl.hasClass("carousePicShow")){
            $("#carouselImage").val("");
            $("#carouselImageUrl_id").val("");
        }
        
        
        _t.uploadBtnEl.show();
      }
     });    
}

// 默认参数
uploadImg.DEFAULTS={
  showEl:$(".uploadPicShow"),
  uploadBtnEl:$(".uploadImgBtn"),
  uploadWrapEl:$(".uploadImgBox"),
  modalWrapEl:$("#roleadd-modal"),
  hideUploadBtn:false
}



