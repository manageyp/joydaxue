# == Schema Information
#
# Table name: school_photos
#
#  id         :integer          not null, primary key
#  school_id  :integer          not null
#  image      :string(255)
#  position   :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#

class SchoolPhoto < ActiveRecord::Base

  belongs_to :school

  ModelName = "学校相册"
  ColumnNames ={
    school_id: "学校ID",
    image: "图片地址",
    position: "图片排序"
  }

end
