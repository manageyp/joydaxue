// 点击获取验证码
function sendCaptcha(){
  var cellphone = $("#login-cellphone").val();
  $.ajax({
      url:"/users/send_captcha",
      dataType:'text',
      type:'POST',
      data:{"cellphone":cellphone},
      success: function(text){
        $("#login-captcha").val(text);
        $("#sendCaptchaBtn").addClass('disabled');
        setTimeout(function(){$("#doLoginBtn").click();}, 1000);
      },
      error:function(response){
        var error_message = (response.status == 403) ? response.responseText : "程序处理异常，请稍后重试";
        alert(error_message);
      }
  });
}


// 点击登录
function doLogin(){
  var cellphone = $("#login-cellphone").val();
  var captcha = $("#login-captcha").val();
  $.ajax({
      url:"/users/signin",
      dataType:'text',
      type:'POST',
      data:{"cellphone":cellphone, "captcha":captcha},
      success: function(text){
        window.location = "/admin/schools";
      },
      error:function(response){
        var error_message = (response.status == 403) ? response.responseText : "程序处理异常，请稍后重试";
        alert(error_message);
      }
  });
}