# == Schema Information
#
# Table name: user_tokens  用户 Token
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null  用户 ID
#  token      :string(191)      Token 值，32 位 Base64 字符
#  expired_at :datetime         Token 过期时间
#  created_at :datetime
#  updated_at :datetime


class UserToken < ActiveRecord::Base
  belongs_to :user

  TOKEN_VALID_DAYS = 90

  def valid_token?
    self.token.present? && self.expired_at > Time.current
  end

  def need_refresh?
    self.expired_at > Time.current &&
    self.expired_at <= (Time.current + 12.hours)
  end

  def refresh_expired_at
    self.update_attributes(expired_at: TOKEN_VALID_DAYS.days.from_now)
  end

  class << self

    def fetch_token(user_id, force_refresh = false)
      user_token = where(user_id: user_id).first
      if user_token && force_refresh
        user_token.token = generate_token
        user_token.expired_at = TOKEN_VALID_DAYS.days.from_now
        user_token.save!
      end
      user_token || create_token(user_id)
    end

    def create_token(user_id)
      user_token = UserToken.new
      user_token.user_id = user_id
      user_token.token = generate_token
      user_token.expired_at = TOKEN_VALID_DAYS.days.from_now
      user_token if user_token.save
    end

    def verify_token(token)
      user_token = where(token: token).first
      if user_token.present? && user_token.valid_token?
        user_token.refresh_expired_at if user_token.need_refresh?
        user_token
      end
    end

    private

    def generate_token
      loop do
        auth_token = Util::TokenUtil.friendly_token(32)
        break auth_token unless where(token: auth_token).exists?
      end
    end

  end

end
