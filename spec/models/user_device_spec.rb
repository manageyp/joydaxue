# == Schema Information
#
# Table name: user_devices
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  client_type  :string(255)      not null
#  device_id    :integer          not null
#  device_name  :string(255)
#  device_agent :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe UserDevice, :type => :model do
end
