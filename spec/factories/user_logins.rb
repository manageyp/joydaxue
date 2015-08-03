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

FactoryGirl.define do
  factory :user_login do
    id 1
    user_id 1
    login_type "email"
    login_ip "MyString"
    location "MyString"
    login_at "2015-07-30 18:01:15"
  end
end
