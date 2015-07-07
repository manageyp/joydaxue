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

FactoryGirl.define do
  factory :user_token do
    id 1
    user_id 1
    token 'token'
    expired_at (Time.now + 30.day)
  end
end
