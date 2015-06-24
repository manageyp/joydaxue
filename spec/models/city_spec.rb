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

require 'rails_helper'

RSpec.describe City, :type => :model do
end
