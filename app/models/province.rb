# == Schema Information
#
# Table name: provinces
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Province < ActiveRecord::Base

  ModelName = "学校所属省份"
  ColumnNames = {
    name: "省份名称"
  }

end
