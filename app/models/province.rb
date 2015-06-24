# == Schema Information
#
# Table name: provinces 学校所属省份
#
#  id         :integer          not null, primary key
#  name       :string(255)      省份名称
#  created_at :datetime
#  updated_at :datetime
#

class Province < ActiveRecord::Base

end
