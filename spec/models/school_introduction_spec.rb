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

require 'rails_helper'

RSpec.describe SchoolIntroduction, :type => :model do
end
