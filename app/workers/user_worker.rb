# -*- coding: utf-8 -*-

class UserWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  class << self

    def deliver_cellphone_captcha(captcha)
      # TODO Call Emay sms service
    end

    def register_device_info(user_id, device_type, device_id, device_token)
      user = User.where(id: user_id).first
      if user.present?
        UserDevice.register_device(user.id, device_type, device_id, device_token)
      end
    end

  end

end