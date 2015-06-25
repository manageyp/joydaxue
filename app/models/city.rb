# == Schema Information
#
# Table name: cities 学校所属城市
#
#  id          :integer          not null, primary key
#  province_id :integer          not null  所在省份
#  name        :string(255)                城市名称
#  created_at  :datetime
#  updated_at  :datetime
#

class City < ActiveRecord::Base
  belongs_to :province

end
