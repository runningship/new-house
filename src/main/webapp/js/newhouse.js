function addTab(id,title,url){
	var config = {
	  id: id,
      title : title,
      href : url
    };
	top.topManager.openPage(config);
}

function getImgList(estateUUID , imgType , huxingUUID , noDel){
	if(!huxingUUID){
		huxingUUID="";
	}
	YW.ajax({
        type: 'get',
        url: window.top.projectName+'/c/admin/estate/listImage?estateUUID='+estateUUID+'&imgType='+imgType+'&huxingUUID='+huxingUUID,
        dataType:'json',
        mysuccess: function(data){
        	$('#'+data.imgType+'_img_container').empty();
        	for(var i=0;i<data.images.length;i++){
        		var img = "";
        		if(!noDel){
        			img = '<span id="del_btn_'+data.images[i].id+'" style="position: absolute;margin-left: 108px;color:red;cursor:pointer" onclick="delImg('+data.images[i].id+')">╳</span>';
        		}
        		img += '<img id="image_'+data.images[i].id+'" style="width:120px;height:80px;" src="'+window.top.upload_path+'/'+estateUUID+'/'+data.images[i].path+'.t.jpg" />';
            	$('#'+data.imgType+'_img_container').append(img);
        	}
        }
    });
}

function delImg(imgId){
	YW.ajax({
        type: 'get',
        url: window.top.projectName+'/c/admin/estate/deleteImage?id='+imgId,
        dataType:'json',
        mysuccess: function(data){
        	$('#image_'+imgId).remove();
        	$('#del_btn_'+imgId).remove();
        }
    });
}

function initUploadHouseImage(id , imgType , estateUUID , huxingUUID){
  $('#'+id).uploadify({
      'swf'      : window.top.projectName+'/js/uploadify/uploadify.swf',
      'uploader' : window.top.projectName+'/file/upload?imgType='+imgType+'&estateId='+estateUUID+'&huxingUUID='+huxingUUID,
      'buttonText': '上传图片',
      'removeTimeout': 0.1,
      'fileSizeLimit' : '5MB',
      'onUploadError' : function(file, errorCode, errorMsg, errorString){
          //console.log('The file ' + file.name + ' could not be uploaded: ' + errorString);
      },
      'onUploadComplete':function(file){
          //console.log('finish:'+file);
      },
      'onUploadSuccess' : function(file, data, response) {
        var json = JSON.parse(data);
        if(json['result']!=0){
          $('#' + file.id).find('.data').html('-图片上传失败,'+json['msg']);
        }else{
           alert('图片上传成功');
           getImgList(estateUUID , imgType , huxingUUID);
        }
      },
      'onQueueComplete' : function(queueData) {
        //console.log(queueData);
      }
      // Put your options here
  });
}

function initPortrait(id , sellerId){
  $('#'+id).uploadify({
      'swf'      : '/new-house/js/uploadify/uploadify.swf',
      'uploader' : '/new-house/file/upload?imgType=touxiang&estateId='+sellerId,
      'buttonText': '更改头像',
      'removeTimeout': 0.1,
      'fileSizeLimit' : '5MB',
      'onUploadError' : function(file, errorCode, errorMsg, errorString){
          //console.log('The file ' + file.name + ' could not be uploaded: ' + errorString);
      },
      'onUploadComplete':function(file){
          //console.log('finish:'+file);
      },
      'onUploadSuccess' : function(file, data, response) {
        var json = JSON.parse(data);
        if(json['result']!=0){
          alert('头像上传失败');
        }else{
           alert('头像上传成功');
        }
      },
      'onQueueComplete' : function(queueData) {
        //console.log(queueData);
      }
      // Put your options here
  });
}

