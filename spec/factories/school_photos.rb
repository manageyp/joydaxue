# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school_photo do
    id 1
    school_id 1
    image "MyString"
    position 0
  end
end
