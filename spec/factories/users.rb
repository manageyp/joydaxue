# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    id 1
    name "MyString"
    email "MyString"
    cellphone "MyString"
    display_name "MyString"
    sex 1
    status 0
    memo "MyString"
  end
end
