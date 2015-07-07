# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  email        :string(255)      not null
#  cellphone    :string(255)      not null
#  sex          :integer
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
    cellphone "18888888888"
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
    cellphone "18899999999"
    sex 0
    status 0
    memo "enjoy shoopping"
    password '116763115b3fbf99b12cc38b388fc825' # 123456
    password_salt 'MfneSBCopBcjR4rxHuxxRQhh'
  end
end
