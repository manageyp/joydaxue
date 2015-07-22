# -*- encoding : utf-8 -*-

module V1
  class MessageWrapper < BaseWrapper

    class << self

      def message_detail(message)
        ret = { message_id: message.id, created_at: message.created_at }
        sender = message.sender
        if sender.present?
          ret[:sender] = V1::UserWrapper.owner_info(sender)
        end
        ret
      end

      def messages_data(messages)
        ret = []
        messages.each do |message|
          ret << message_detail(message)
        end
        ret
      end

    end

  end
end