# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  status      :integer          default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :role do
    id 1
    name "MyString"
    description "MyString"
    status 0
  end
end
