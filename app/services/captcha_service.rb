class CaptchaService

  class << self

    def verify_captcha(mobile, code)
      captcha = Captcha.fetch_captcha(mobile, code)
      if captcha
        if captcha.expired?
          Util::ErrorCode.error_words(:user_expired_captcha)
        else
          captcha.destroy
          [captcha]
        end
      else
        Util::ErrorCode.error_words(:user_invalid_captcha)
      end
    end

    def send_captcha(mobile)
      user = User.where(cellphone: mobile).first
      if user
        captcha = Captcha.build_captcha(user.cellphone)
        if captcha
          [captcha]
        else
          Util::ErrorCode.error_words(:user_limit_captcha_count)
        end
      else
        Util::ErrorCode.error_words(:username_not_existed)
      end
    end

  end

end