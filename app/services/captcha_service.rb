class CaptchaService

  class << self

    def verify_captcha(mobile, code)
      captcha = Captcha.fetch_captcha(mobile, code)
      if captcha
        if captcha.expired?
          ErrorCode.error_words(:captcha_is_expired)
        else
          captcha.destroy
          [captcha]
        end
      else
        ErrorCode.error_words(:captcha_is_invalid)
      end
    end

    def send_captcha(mobile)
      user = User.where(cellphone: mobile).first
      if user
        captcha = Captcha.build_captcha(user.cellphone)
        if captcha
          [captcha]
        else
          ErrorCode.error_words(:captcha_limit_count)
        end
      else
        ErrorCode.error_words(:cellphone_not_existed)
      end
    end

  end

end