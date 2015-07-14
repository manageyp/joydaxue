# == Schema Information
#
# Table name: follows 用户关注
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null  用户 ID
#  to_user_id  :integer          not null  关注的用户 ID
#  created_at  :datetime
#  updated_at  :datetime

FactoryGirl.define do
  factory :follow do
    id 1
    user_id 1
    to_user_id 1
  end
end
