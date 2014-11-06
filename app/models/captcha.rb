class Captcha < ActiveRecord::Base

  ModelName = "手机验证码"
  ColumnNames = {
    captcha_type: "类型",
    mobile: "手机号",
    send_count: "发送次数",
    code: "验证码"
  }

end
