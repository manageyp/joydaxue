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

class UserDevice < ActiveRecord::Base

  ModelName = "用户设备"
  ColumnNames = {
    user_id: "用户 ID",
    client_type: "客户端类型",
    device_id: "设备 UID",
    device_name: "设备名称",
    device_agent: "设备 Agent 信息"
  }

end
