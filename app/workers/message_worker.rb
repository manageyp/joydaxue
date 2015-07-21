# -*- coding: utf-8 -*-

class MessageWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  class << self

    def deliver_follow_message(message_id)
      message = Message.where(id: message_id).first
      if message.present?
        content = "您有一位新的粉丝：#{message.sender.name}，快去看看吧~"
        Xinge::Push.do_push(message.receiver_id, content)
      end
    end

  end

end