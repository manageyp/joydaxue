module Util
  module CommonFields

    SEX_TYPES = {
      0 => "女",
      1 => "男"
    }

    def sex_word
      SEX_TYPES[self.sex]
    end

    STATUS_CODES = {
      0 => '正常',
      1 => '锁定'
    }

    def status_word
      STATUS_CODES[self.status]
    end

  end
end