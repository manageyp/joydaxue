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

require 'rails_helper'

RSpec.describe SchoolPhoto, :type => :model do
end
