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

class Favorite < ActiveRecord::Base
  belongs_to :user
end