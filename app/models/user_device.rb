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

class UserDevice < ActiveRecord::Base
  belongs_to :user

  scope :active, -> { where(status: 0) }

  IOS = 'ios'
  ANDROID = 'android'

  STATUS = {
     0 => '正常',
     1 => '删除'
  }

  def is_ios?
    device_type.present? && device_type == IOS
  end

  class << self

    def push_device(user_id)
      where(user_id: user_id).active.order("updated_at desc").first
    end

    def register_device(user_id, device_type, device_id, device_token)
      type = valid_device_type(device_type)
      device = where(user_id: user_id, device_id: device_id).first
      if device.present?
        device.update_attributes(device_type: type, device_token: device_token)
      else
        create(user_id: user_id, device_id: device_id,
          device_token: device_token, device_type: type)
      end
    end

    def valid_device_type(value)
      if [UserDevice::IOS, UserDevice::ANDROID].include?(value.downcase)
        value.downcase
      else
        UserDevice::IOS
      end
    end

  end

end