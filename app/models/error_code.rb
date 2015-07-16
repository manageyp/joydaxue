# -*- coding: utf-8 -*-

class ErrorCode

  CODES = {
    success:                       ['0000', '成功'],

    default_system_error:          ['1001', '系统内部错误'],
    request_parameter_invalid:     ['1002', '请求参数不完整'],

    user_token_invalid:            ['1003', '用户验证信息无效，请重新登录'],
    user_token_expired:            ['1004', '用户验证信息过期，请重新登录'],

    username_invalid:              ['1005', '用户名请使用汉字、数字、字母和下划线'],
    username_invalid_length:       ['1006', '用户名请使用2至16个字符'],
    username_is_blank:             ['1007', '用户名不能为空'],

    email_is_blank:                ['1008', '邮箱不能为空'],
    email_format_invalid:          ['1009', '邮箱格式有误，请输入正确的邮箱'],
    email_is_existed:              ['1010', '邮箱已存在，请更换其他邮箱'],
    email_not_existed:             ['1011', '邮箱不存在，请检查您输入的邮箱'],

    captcha_is_expired:            ['1012', '验证码已过期'],
    captcha_is_invalid:            ['1013', '验证码不正确'],

    password_is_blank:             ['1014', '密码不能为空'],
    password_is_invalid:           ['1015', '密码请使用数字、字母和下划线'],
    password_length_invalid:       ['1016', '密码请使用6至16个字符'],
    confirm_password_invalid:      ['1017', '确认密码有误'],

    user_password_error:           ['1018', '用户名或密码有误，请重新输入'],
    user_not_existed:              ['1019', '用户不存在'],

    captcha_limit_count:           ['1020', '短信发送次数超限'],
    cellphone_is_blank:            ['1021', '手机号码不能为空'],
    cellphone_is_existed:          ['1022', '手机号码已存在，请更换其他手机号码'],
    cellphone_format_invalid:      ['1023', '手机号码格式有误，请输入正确的手机号码'],
    cellphone_not_existed:         ['1024', '手机号码不存在'],

    username_existed:              ['1025', '用户名已存在'],
    user_update_error:             ['1026', '用户信息保存失败，请稍后重试'],
    user_cannot_follow_self:       ['1027', '用户不能关注自己'],

    school_not_existed:            ['2001', '学校不存在']
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
        CODES[code].last
      else
        default_error.last
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
