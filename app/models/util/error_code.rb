module Util
  class ErrorCode

  SUCCESS = '0000'

  CODES = {
    success:                       [SUCCESS, '成功'],

    invalid_parameters:            ['1001', '参数不完整'],
    default_system_error:          ['1002', '系统内部错误'],

    invalid_user_token:            ['1003', '验证信息无效，请重新登录'],
    expired_user_token:            ['1004', '验证信息过期，请重新登录'],
    invalid_user_name:             ['1005', '用户名请使用汉字、数字、字母和下划线'],
    invalid_name_length:           ['1006', '用户名请使用2至16个字符'],
    username_is_blank:             ['1007', '用户名不能为空'],
    duplicated_username:           ['1008', '用户名不能为空'],

    user_invalid_captcha:          ['1009', '验证码错误'],
    user_expired_captcha:          ['1010', '验证码过期'],
    user_too_frequent_captcha:     ['1011', '获取手机验证码太频繁'],
    user_limit_captcha_count:      ['1012', '短信发送次数超限']
  }

  class << self

    def default_error
      CODES[:default_system_error]
    end

    def error_content(code)
      if CODES.has_key?(code)
        [false, CODES[code]]
      else
        [false, default_error]
      end
    end

    def error_words(code)
      if CODES.has_key?(code)
        [false, CODES[code].last]
      else
        [false, default_error.last]
      end
    end

    def error_value(code)
      if CODES.has_key?(code)
        CODES[code]
      else
        default_error
      end
    end

  end


  end
end