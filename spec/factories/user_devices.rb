# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_device do
    id 1
    user_id 1
    client_type "ios"
    device_id 1
    device_name "iphone"
    device_agent "MyString"
  end
end
