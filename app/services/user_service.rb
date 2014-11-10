class UserService

  class << self

    def authenticate(mobile, code)
      user = User.where(cellphone: mobile).first
      if user
        captcha, content = CaptchaService.verify_captcha(user.cellphone, code)
        if captcha
          [user]
        else
          [captcha, content]
        end
      else
        Util::ErrorCode.error_words(:username_not_existed)
      end
    end

  end

end