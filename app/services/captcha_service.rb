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

  end

end