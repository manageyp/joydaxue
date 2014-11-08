// 显示提醒信息
function showNotice(content){
  $("#noticeContent").html(content);
  $("#noticeDialog").show();
}

// 点击查看修改历史
function showChangeLog(url){
  $.ajax({
    url: url,
    type: 'GET',
    success: function(result) {
      $("#changeLogPanel").html(result).show();
    },
    error:function(response){
      var error_message = (response.status == 403) ? response.responseText : "程序处理异常，请稍后重试";
      alert(error_message);
    }
  });
  return false;
}


// 点击删除按钮，直接删除
function deleteResourceBtn(url, id){
  if(confirm("确定删除吗?")){
    $.ajax({
      url: url,
      type: 'DELETE',
      success: function(result) {
        $("#record_"+id).hide('slow');
      },
      error:function(response){
        var error_message = (response.status == 403) ? response.responseText : "程序处理异常，请稍后重试";
        alert(error_message);
      }
    });
  }
  return false;
}


// 景区管理，添加运营平台的景区
function addLandscape(id){

 $.ajax({
      url:"/admin/landscapes",
      dataType:'text',
      type:'POST',
      data:{"poi_id":id},
      success: function(text){
        btn_html = "<button type='button' class='btn btn-info btn-sm' disabled='disabled'>已添加</button>"
        $("#btn_record_"+id).html(btn_html);
        alert("添加成功");
      },
      error:function(response){
        var error_message = (response.status == 403) ? response.responseText : "程序处理异常，请稍后重试";
        alert(error_message);
      }
 });

}


// 全景管理，添加运营平台的全景
function addLandscapePano(pano_id){

 $.ajax({
      url:"/admin/landscape_panoramas",
      dataType:'text',
      type:'POST',
      data:{"pano_id":pano_id},
      success: function(text){
        btn_html = "<button type='button' class='btn btn-info btn-sm' disabled='disabled'>已添加</button>"
        $("#btn_record_"+pano_id).html(btn_html);
        alert("添加成功");
      },
      error:function(response){
        var error_message = (response.status == 403) ? response.responseText : "程序处理异常，请稍后重试";
        alert(error_message);
      }
 });

}

// 路段全景管理，添加运营平台的全景
function addTravelPano(pano_id){

 $.ajax({
      url:"/admin/travel_panoramas",
      dataType:'text',
      type:'POST',
      data:{"pano_id":pano_id},
      success: function(text){
        btn_html = "<button type='button' class='btn btn-info btn-sm' disabled='disabled'>已添加</button>"
        $("#btn_record_"+pano_id).html(btn_html);
        alert("添加成功");
      },
      error:function(response){
        var error_message = (response.status == 403) ? response.responseText : "程序处理异常，请稍后重试";
        alert(error_message);
      }
 });

}

var validFilesTypes = ["jpg"];

// File check extension
function CheckExtension(e) {
    var file = e;
    var path = file.value;

    var ext = path.substring(path.lastIndexOf(".") + 1, path.length).toLowerCase();
    var isValidFile = false;
    for (var i = 0; i < validFilesTypes.length; i++) {
        if (ext == validFilesTypes[i]) {
            isValidFile = true;
            break;
        }
    }
    if (!isValidFile) {
        e.value = null;
        alert("合法的文件格式为：" + validFilesTypes.join(", "));
    }
    return isValidFile;
}

// File check size
function validateFileSize(e) {
    var file = e;
    var fileSize = file.files[0].size;
    var isValidFile = false;
    if (fileSize !== 0 && fileSize <= 1214400) {
        isValidFile = true;
    }
    if (!isValidFile) {
        e.value = null;
        alert("文件大小要小于 1MB");
    }
    return isValidFile;
}

// for Ajax auto-add csrf-token
$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});

// to init js
$(document).ready(function () {
  // photo gallery
  $('a[rel^="prettyPhoto"]').prettyPhoto({
      slideshow: 5000,
      autoplay_slideshow: false
  });

  // validate input file
  $('input[type="file"]').change(function () {
    var isValidFile = CheckExtension(this);
    if(isValidFile){
      isValidFile = validateFileSize(this);
    }
    if(isValidFile){
      $('button[type="submit"]').removeAttr('disabled');
    }else{
      $('button[type="submit"]').attr('disabled','disabled');
    }
  });

});
