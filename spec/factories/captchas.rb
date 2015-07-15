# == Schema Information
#
# Table name: captchas
#
#  id           :integer          not null, primary key
#  captcha_type :string(255)      not null
#  cellphone       :string(255)      not null
#  send_count   :integer          default(0)
#  code         :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :captcha do
    id 1
    captcha_type "login"
    cellphone "15033333333"
    send_count 1
    code "1234"
    created_at 5.minutes.ago
    updated_at 5.minutes.ago
  end

  factory :reset_captcha, class:Captcha do
    id 2
    captcha_type "login"
    cellphone "15000000000"
    send_count 1
    code "5678"
    created_at 5.minutes.ago
    updated_at 5.minutes.ago
  end
end
