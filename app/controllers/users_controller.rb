class UsersController < ApplicationController
  layout false

  def signin
    user, content = UserService.authenticate(params[:cellphone], params[:captcha])
    if user
      session[:user_id] = user.id
      session[:user_name] = user.name
      render text: '登录成功'
    else
      render text: content, status: 403 and return
    end
  end

  def signout
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to root_path
  end

  def send_captcha
    captcha, content = CaptchaService.send_captcha(params[:cellphone])
    if captcha
      render text: captcha.code
    else
      render text: content, status: 403 and return
    end
  end

  def reset
    # TODO reset user password
    render text: '重置密码成功'
  end
end