# == Schema Information
#
# Table name: permissions
#
#  id              :integer          not null, primary key
#  role_id         :integer          not null
#  controller_name :string(255)
#  action_names    :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe Permission, :type => :model do
end
