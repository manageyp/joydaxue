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

FactoryGirl.define do
  factory :school_introduction do
    id 1
    school_id 1
    short_content "南通大学"
    full_content "南通大学"
  end
end
