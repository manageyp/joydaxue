class UserService

  class << self

    def authenticate(name, code)
      user = User.where(name: name).first
      if user
        captcha, content = CaptchaService.verify_captcha(user.cellphone, code)
        if captcha
          [user]
        else
          [captcha, content]
        end
      else
        Util::ErrorCode.error_words(:duplicated_username)
      end
    end

  end

end