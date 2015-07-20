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

FactoryGirl.define do
  factory :school_photo do
    id 1
    school_id 1
    image "url"
    position 0
  end
end
