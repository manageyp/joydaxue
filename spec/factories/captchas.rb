# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :captcha do
    id 1
    captcha_type "signin"
    mobile "15026612137"
    send_count 1
    code "1234"
  end
end
