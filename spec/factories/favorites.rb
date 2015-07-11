# == Schema Information
#
# Table name: favorites 用户收藏
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null  用户 ID
#  detail_type :string(191)                收藏数据的类型
#  detail_id   :integer          not null  收藏数据的 ID
#  created_at  :datetime
#  updated_at  :datetime

FactoryGirl.define do
  factory :favorite do
    user_id 1
    detail_type "School"
    detail_id 1
  end
end
