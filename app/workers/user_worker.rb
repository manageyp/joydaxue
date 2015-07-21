# -*- coding: utf-8 -*-

class UserWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  class << self

    def deliver_cellphone_captcha(captcha)
      # TODO Call Emay sms service
    end

  end

end