# == Schema Information
#
# Table name: schools
#
#  id               :integer          not null, primary key
#  province_id      :integer          not null
#  city_id          :integer          not null
#  name             :string(255)      not null
#  address          :string(255)
#  college_type     :string(255)
#  telephone        :string(255)
#  avatar           :string(255)
#  website          :string(255)
#  found_year       :string(255)
#  zipcode          :string(255)
#  affiliate        :string(255)
#  latitude         :decimal(10, 6)   default(0.0)
#  longitude        :decimal(10, 6)   default(0.0)
#  is_211           :boolean          default(FALSE)
#  is_985           :boolean          default(FALSE)
#  is_edu_affiliate :boolean          default(FALSE)
#  has_bachelor     :boolean          default(FALSE)
#  is_independent   :boolean          default(FALSE)
#  is_civilian_run  :boolean          default(FALSE)
#  key_disciplines  :integer          default(0)
#  master_num       :integer          default(0)
#  phd_num          :integer          default(0)
#  academician_num  :integer          default(0)
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe School, :type => :model do
end
