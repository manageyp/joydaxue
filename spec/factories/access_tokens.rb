# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_token do
    user_id 1
    token "MyString"
    expired_at "2014-11-06 09:12:58"
  end
end
