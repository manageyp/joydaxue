# == Schema Information
#
# Table name: user_devices 用户设备
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null  用户 ID
#  client_type  :string(255)      not null  客户端类型
#  device_id    :integer          not null  设备 ID
#  device_name  :string(255)                设备名称
#  device_agent :string(255)                设备 Agent 信息
#  created_at   :datetime
#  updated_at   :datetime
#

class UserDevice < ActiveRecord::Base
  belongs_to :user

end
