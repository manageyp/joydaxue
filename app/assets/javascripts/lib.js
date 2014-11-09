function doLogin(){
  var name = $("#login-name").val();
  var captcha = $("#login-captcha").val();
  $.ajax({
      url:"/users/signin",
      dataType:'text',
      type:'POST',
      data:{"name":name, "captcha":captcha},
      success: function(text){
        window.location = "/admin/schools";
      },
      error:function(response){
        var error_message = (response.status == 403) ? response.responseText : "程序处理异常，请稍后重试";
        alert(error_message);
      }
  });
}