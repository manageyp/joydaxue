# == Schema Information
#
# Table name: permissions
#
#  id              :integer          not null, primary key
#  role_id         :integer          not null
#  controller_name :string(255)
#  action_names    :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

FactoryGirl.define do
  factory :permission do
    id 1
    role_id 1
    controller_name "MyString"
    action_names "MyString"
  end
end
