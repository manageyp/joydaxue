# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :permission do
    id 1
    role_id 1
    controller_name "MyString"
    action_name "MyString"
  end
end
