# -*- coding: utf-8 -*-

class UserWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  class << self

    def deliver_cellphone_captcha(captcha)
      # TODO Call Emay sms service
    end

    def register_login_info(params)
      user = User.where(id: params[:user_id]).first
      if user.present?
        UserDevice.register_device(user.id, params[:device_type],
          params[:device_id], params[:device_token])
        UserLogin.build_user_login(user.id, params[:real_ip],
          params[:login_at], params[:login_type])
      end
    end

  end

end