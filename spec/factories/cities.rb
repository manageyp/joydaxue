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

FactoryGirl.define do
  factory :city do
    id 1
    province_id 1
    name "南通市"
  end
end
