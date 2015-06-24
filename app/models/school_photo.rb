# == Schema Information
#
# Table name: school_photos 学校相册
#
#  id         :integer          not null, primary key
#  school_id  :integer          not null   学校 ID
#  image      :string(255)                 图片地址
#  position   :integer          default(0) 图片排序
#  created_at :datetime
#  updated_at :datetime
#

class SchoolPhoto < ActiveRecord::Base
  belongs_to :school

end
