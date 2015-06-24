# == Schema Information
#
# Table name: school_introductions 学校介绍
#
#  id            :integer          not null, primary key
#  school_id     :integer          not null  学校ID
#  short_content :string(255)                简单描述
#  full_content  :text                       详细描述
#  created_at    :datetime
#  updated_at    :datetime
#

class SchoolIntroduction < ActiveRecord::Base
  belongs_to :school

end
