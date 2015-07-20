# == Schema Information
#
# Table name: user_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  role_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :user_role do
    id 1
    user_id 1
    role_id 1
  end
end
