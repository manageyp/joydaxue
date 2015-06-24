# == Schema Information
#
# Table name: cities
#
#  id          :integer          not null, primary key
#  province_id :integer          not null
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class City < ActiveRecord::Base

  ModelName = "学校所属城市"
  ColumnNames = {
    province_id: "所在省份",
    name: "城市名称"
  }

end
