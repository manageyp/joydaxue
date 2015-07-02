# == Schema Information
#
# Table name: captchas 手机验证码
#
#  id           :integer          not null, primary key
#  captcha_type :string(255)      not null   类型
#  cellphone       :string(255)      not null   手机号
#  send_count   :integer          default(0) 发送次数
#  code         :string(255)      not null   验证码
#  created_at   :datetime
#  updated_at   :datetime
#

class Captcha < ActiveRecord::Base

  EXPIRED_TIME = 600  # 验证码过期时间 60 minutes
  SEND_INTERVAL = 30  # 发送验证码间隔 30 seconds
  MAX_DAY_SENDED_COUNTER = 10 # 验证码单日发送上限 10
  CAPTCHA_TYPES = {
    login: 'login' # 登录验证码
  }

  def expired?
    Time.now.to_i > (self.updated_at + EXPIRED_TIME).to_i
  end

  def send_frequent?
    (Time.now.to_i - self.updated_at.to_i) < SEND_INTERVAL
  end

  class << self

    def fetch_captcha(cellphone, code)
      # TODO default to be login type
      where(cellphone: cellphone, code: code).first
    end

    def valid_today_count?(cellphone)
      today_count = Util::DailyCounter.get_counter(cellphone)
      today_count <= MAX_DAY_SENDED_COUNTER
    end

    def increase_today_counter(cellphone)
      Util::DailyCounter.increase_counter(cellphone)
    end

    def build_captcha(cellphone)
      return unless valid_today_count?(cellphone)

      code = numeric_code
      captcha = Captcha.find_by_cellphone(cellphone)
      if captcha
        captcha.update_attributes(code: code)
      else
        captcha = Captcha.create(cellphone: cellphone, code: code,
          captcha_type: CAPTCHA_TYPES[:login])
      end

      increase_today_counter(cellphone)
      captcha
    end

    private

      def numeric_code(length = 4)
        Array.new(length){|i| rand(10) }.join
      end

  end

end
