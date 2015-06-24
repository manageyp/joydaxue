# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  email        :string(255)      not null
#  cellphone    :string(255)      not null
#  display_name :string(255)
#  sex          :integer
#  status       :integer          default(0)
#  memo         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

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
