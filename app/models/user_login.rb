# == Schema Information
#
# Table name: user_logins  用户登录日志
#
#  id          :integer          not null, primary key
#  user_id     :integer(11)      用户 ID
#  login_type  :string(255)      登录方式，为 email，qq，sina，wechat
#  login_ip    :string(255)      用户登录 IP
#  location    :string(255)      IP 所在地区
#  login_at    :string(255)      用户登录时间
#  created_at  :datetime
#  updated_at  :datetime

class UserLogin < ActiveRecord::Base
  belongs_to :user

  CELLPHONE_LOGIN = "cellphone"
  EMAIL_LOGIN = "email"
  QQ_LOGIN = "qq"
  SINA_LOGIN = "sina"
  WECHAT_LOGIN = "wechat"

  class << self

    def get_login_type(provider)
      type = provider.to_s.downcase
      valid_type?(type) ? type : EMAIL_LOGIN
    end

    def build_user_login(user_id, login_ip, login_at, login_type)
      location = QqwryIp.fetch_ip_location(login_ip)
      create(user_id: user_id, login_ip: login_ip,
        login_at: login_at, login_type: login_type,
        location: location.join(' '))
    end

    private

      def valid_type?(type)
        [CELLPHONE_LOGIN, EMAIL_LOGIN, QQ_LOGIN,
          SINA_LOGIN, WECHAT_LOGIN].include?(type)
      end

  end

end