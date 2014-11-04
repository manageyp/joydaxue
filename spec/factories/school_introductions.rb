# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school_introduction do
    id 1
    school_id 1
    short_content "MyString"
    full_content "MyText"
  end
end
