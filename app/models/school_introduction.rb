# == Schema Information
#
# Table name: school_introductions
#
#  id            :integer          not null, primary key
#  school_id     :integer          not null
#  short_content :string(255)
#  full_content  :text
#  created_at    :datetime
#  updated_at    :datetime
#

class SchoolIntroduction < ActiveRecord::Base
  belongs_to :school

  ModelName = "学校介绍"
  ColumnNames ={
    school_id: "学校ID",
    short_content: "简单描述",
    full_content: "详细描述"
  }

end
