# == Schema Information
#
# Table name: follows 用户关注
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null  用户 ID
#  to_user_id  :integer          not null  关注的用户 ID
#  created_at  :datetime
#  updated_at  :datetime

require 'rails_helper'

RSpec.describe Follow, :type => :model do
end
