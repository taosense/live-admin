 function uploadImg(opts){
  this.opts=$.extend({},uploadImg.DEFAULTS,opts);
  var opts=this.opts;

  // 父容器
  this.modalWrapEl=opts.modalWrapEl;
}

// 初始化
uploadImg.prototype.init=function(){
  var _t=this;
  _t.uploadImg();
  _t.delUploadImg();
}

// 图片上传
uploadImg.prototype.uploadImg=function(){
	var _t=this;
 _t.modalWrapEl.on('change','.filename',function (e) {
  $("#formContent").remove();
  var $e = $(e.target),
  $uploadWrap = $e.parents(".mediaChoose"),
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
   '<input type="hidden" name="thumbnailSizes" value="50x50xf">'+
   '<input type="hidden" name="thumbnailSizes" value="100x100xf">'+
   '<input type="hidden" name="thumbnailSizes" value="120x120xf">'+
   '<input type="hidden" name="thumbnailSizes" value="180x180xf">'+
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
        var imgUrl=content.thumbnailURLs;
        $fileWrap.hide();
        //$uploadedPic.attr("src","http://tpic.home.news.cn/xhCloudNewsPic/"+imgUrl);//初始版本
        $uploadedPic.attr("src","http://tpic.home.news.cn/photogallery/"+imgUrl["120x120xf"]);//刘洋版本
        //  $uploadedPic.attr("src","http://192.168.83.150/"+imgUrl);
        $uploadedPicWrap.show();
        $picBtnWrap.show();
        
        $("#"+formId+"-orgInfo-avatar50Url").val("http://tpic.home.news.cn/photogallery/"+imgUrl["50x50xf"]);
        $("#"+formId+"-orgInfo-avatar100Url").val("http://tpic.home.news.cn/photogallery/"+imgUrl["100x100xf"]);
        $("#"+formId+"-orgInfo-avatar120Url").val("http://tpic.home.news.cn/photogallery/"+imgUrl["120x120xf"]);
        $("#"+formId+"-orgInfo-avatar180Url").val("http://tpic.home.news.cn/photogallery/"+imgUrl["180x180xf"]);

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
      var $this=$(this);
      var $showEl=$this.parents(".mediaChooseWrap").siblings();
     
      $uploadedPicWrap.find(".imgDelBtn").show();
      $showEl.empty().append($uploadedPicWrap);
      if($showEl.hasClass("edituserIcoShowWrap")){
    	  $showEl.find(".uploadedPic").attr("id","editORGForm-avatar");
      }else{
    	  $showEl.find(".uploadedPic").attr("id","addORGForm-avatar");
      }
      $this.parents(".mediaChoose").remove();

    });
   }

 });
}

uploadImg.prototype.delUploadImg=function(){
	var _t=this;
	  // 删除已上传的图片
    $(".userIcoShowWrap").on('click','.imgDelBtn',function(){
      $userIcoShowWrap=$(this).parents(".userIcoShowWrap");
      $mediaChooseWrap=$userIcoShowWrap.siblings(".mediaChooseWrap");
      $userIcoShowWrap.empty();
      var uploadHtml='<div class="mediaChoose"><div class="uploadPicFile"><div class="uploadPicFile_fileWrap"><span class="uploadPicFile_fileImg"></span><input class="filename uploadPicFile_fileBtn" type="file" name="file" size="56"></div><div class="uploadedPicWrap"><img class="uploadedPic" name="uploadedPic" src=""><a href="javascript:void(0);" class="imgDelBtn"><i class="ace-icon fa fa-trash-o bigger-150"></i></a></div><div class="uploadPicFile_btnWrap"><a class="upload_btn_confirm" href="javascript:void(0);">确定上传</a><a class="upload_btn_cancel" href="javascript:void(0);">取消</a></div></div></div>';
      $mediaChooseWrap.empty().append($(uploadHtml));
    });	
  }

// 默认参数
uploadImg.DEFAULTS={
  modalWrapEl:$(".mediaChooseWrap")
}



