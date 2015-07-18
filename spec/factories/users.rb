# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  email        :string(255)      not null
#  cellphone    :string(255)      not null
#  sex          :integer
#  follows_count    :integer(11)  default(0) 用户关注人数
#  fans_count       :integer(11)  default(0) 用户粉丝人数
#  status       :integer          default(0)
#  memo         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

FactoryGirl.define do
  factory :user do
    id 1
    name "henry"
    email "manageyp@gmail.com"
    cellphone "15000000000"
    sex 1
    status 0
    memo "enjoy coding"
    password '116763115b3fbf99b12cc38b388fc825' # 123456
    password_salt 'MfneSBCopBcjR4rxHuxxRQhh'
  end

  factory :user_alice, class:User do
    id 2
    name "alice"
    email "alice@qq.com"
    cellphone "15022222222"
    sex 0
    status 0
    memo "enjoy shoopping"
    password '116763115b3fbf99b12cc38b388fc825' # 123456
    password_salt 'MfneSBCopBcjR4rxHuxxRQhh'
  end
end
