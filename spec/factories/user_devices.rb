# == Schema Information
#
# Table name: user_devices 用户设备
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null  用户 ID
#  device_type  :string(255)                设备类型
#  device_id    :string(255)      not null  设备 ID
#  device_token :string(255)                设备推送 Token
#  status       :integer                    设备的状态
#  created_at   :datetime
#  updated_at   :datetime
#

FactoryGirl.define do
  factory :user_device do
    id 1
    user_id 1
    device_type "ios"
    device_id "device-1"
    device_token "device-token"
    status 0
  end
end
