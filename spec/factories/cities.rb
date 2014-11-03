# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    id 1
    province_id 1
    name "MyString"
  end
end
