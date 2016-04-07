$(function(){
	/*
	 * @author 
	 * @version 1.0.0
	 * @date 2016.01.12
	 * @description 图片上传  
	 */


	 var upload = function(){   

	 	var _this = this , $this = $(this) ; 

		//渲染图片
		this.renderPic = function(e){
			var fileList = e.target.files;
			var imgLength=fileList.length;
			
			if(imgLength>0 && imgLength<11){
				for( var i = 0 ; i < imgLength ; i++ ){  
					
					var file=fileList[i],					
					fileVal =file.name,
					fileType = '',
					fileArr = fileVal.split('.');

					fileArr.length > 1 && (fileType = fileArr[1]);

					if (fileType != 'jpeg' && fileType != 'jpg' && fileType != 'bmp' && fileType != 'gif' && fileType != 'png' && fileType != 'JPG' && fileType != 'BMP' && fileType != 'GIF' && fileType != 'PNG') {
						alert('第'+parseInt(i+1)+'图片格式不正确！');
						return false;
					}else{

						$(".uploadPicFile_fileWrap").hide();
						$(".uploadPicFile_btnWrap").show();
							  //创建FileReader对象
							  var reader = new FileReader();

							  reader.onload = function ( event ) {
							  	var txt = event.target.result;
							  	$(".uploadedPicWrap-mutiWrap").append('<div class="uploadedPicWrap-muti"><img class="uploadedPic" name="uploadedPic" src="'+txt+'"><a href="javascript:void(0);" class="imgDelBtn"><i class="ace-icon fa fa-trash-o bigger-150"></i></a></div>');
							  	return txt;
							  };

							  reader.readAsDataURL( file );
							}
						}
					}else{
						alert("最多选择10张图片！");
						return false;
					}
				}

		//上传图片
		this.uploadImg = function(){

			var fileList =$("#uploadPicFile_fileBtn").get(0).files;
			var imgLength=fileList.length;
			if(imgLength){
				for( var i = 0 ; i < imgLength ; i++ ){  
					var file=fileList[i],					
					fileVal =file.name,
					fileType = '',
					fileArr = fileVal.split('.');

					fileArr.length > 1 && (fileType = fileArr[1]);
					if (fileType != 'jpeg' && fileType != 'jpg' && fileType != 'bmp' && fileType != 'gif' && fileType != 'png' && fileType != 'JPG' && fileType != 'BMP' && fileType != 'GIF' && fileType != 'PNG') {
						return false;
					}else{
						var uploadForm = $("#fileForm");
						var formdata = new FormData( uploadForm[0] );

						formdata.append('file',file);
						formdata.append("c",window.location.origin);
						$.ajax({
						url: "http://xuan.news.cn/photo1/service/upload.do",
						//url: "http://192.168.85.73:8001/photo1/service/upload.do",
						type: "post",
						data: formdata,    
						dataType: 'json',
						processData: false,
						contentType: false,
						success: function(data){
							var imgSrc=data.content.originalUrl;
							var uploadHtml='<div class="uploadedPicWrap-muti"><img class="uploadedPic" name="uploadedPic" src="http://tpic.home.news.cn/photogallery/'+imgSrc+'"><a style="display:block;" href="javascript:void(0);" class="imgDelBtn"><i class="ace-icon fa fa-trash-o bigger-150"></i></a></div>';
							//var uploadHtml='<div class="uploadedPicWrap-muti"><img class="uploadedPic" name="uploadedPic" src="http://192.168.83.150/'+imgSrc+'"><a style="display:block;" href="javascript:void(0);" class="imgDelBtn"><i class="ace-icon fa fa-trash-o bigger-150"></i></a></div>';
							$("#roleadd-modal").modal("hide");	
							$(".uploadPicShow").append($(uploadHtml));
						},
						error: function(data){
							alert("上传失败！");
						}
					});
					}
				}
			}
		}

		this.init = function(){

			// 生成上传图片的html
			$(".uploadImgBtn").on('click',function(){
				var uploadHtml=' <form action="" id="fileForm" class="hidden"><input type="file" name="files" class="uploadPicFile_fileBtn hidden" id="uploadPicFile_fileBtn" multiple="multiple"><input type="hidden" name="title" value="图片上传"><input type="hidden" name="o" value=1><input type="hidden" name="tagWords" value="直播"><input type="hidden" name="appType" value=400><input type="hidden" name="categoryCode" value=1><input type="hidden" name="r" value="S"></form><div class="mediaChoose"><div class="uploadPicFile_fileWrap"><img src="dist/css/images/uploadImgFile.png" alt="" class="uploadBtn_img"></div><div class="uploadedPicWrap-mutiWrap"></div><div class="uploadPicFile_btnWrap"><a class="upload_btn_confirm" href="javascript:void(0);">确定上传</a><a class="upload_btn_cancel" href="javascript:void(0);">取消</a></div></div>';
				$(".uploadImgBox").empty().append($(uploadHtml));
			});

			//点击图片的时候 触发点击真正的上传按钮	
			$(".uploadImgBox").on("click",'.uploadBtn_img',function(){
				$("#uploadPicFile_fileBtn").click();
			});

			//当上传按钮change的时候 触发base64渲染图片
			$(".uploadImgBox").on("change",'#uploadPicFile_fileBtn',function(e){
				_this.renderPic(e);
			});

			//提交表单
			$(".uploadImgBox").on("click",".upload_btn_confirm",function(e){
				$(e.currentTarget).hide();
				_this.uploadImg();	
			});
			
			// 取消上传
			$(".uploadImgBox").on("click",".upload_btn_cancel",function(){				
				$(".uploadPicFile_fileWrap").show();
				$(".uploadedPicWrap-mutiWrap").empty();
				var inputHtml='<input type="file" name="files" class="uploadPicFile_fileBtn hidden" id="uploadPicFile_fileBtn" multiple="multiple">';
				$("#uploadPicFile_fileBtn").remove();
				$("#fileForm").append($(inputHtml));
			});
			
			// 删除已上传的图片
			$(".uploadPicShow").on("click",".imgDelBtn",function(e){
				var $e=$(e.currentTarget);		
				$e.parent().remove();
			});
		}
	}

	var u = new upload();
	u.init();

})