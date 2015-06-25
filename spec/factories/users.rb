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

FactoryGirl.define do
  factory :user do
    id 1
    name "henry"
    email "manageyp@gmail.com"
    cellphone "18888888888"
    display_name "henry lee"
    sex 1
    status 0
    memo "enjoy coding"
  end
end
