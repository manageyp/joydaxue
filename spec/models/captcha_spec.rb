# == Schema Information
#
# Table name: captchas
#
#  id           :integer          not null, primary key
#  captcha_type :string(255)      not null
#  mobile       :string(255)      not null
#  send_count   :integer          default(0)
#  code         :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Captcha, :type => :model do
end
