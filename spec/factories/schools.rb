# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    id 1
    province_id 1
    city_id 1
    name "MyString"
    website "MyString"
    found_year "MyString"
    address "MyString"
  end
end
