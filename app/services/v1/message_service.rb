# -*- encoding : utf-8 -*-

module V1
  class MessageService

    class << self

      def list_messages(params)
        min_created_at = Util::DateUtil.pagination_datetime(params[:page])
        messages = Message.list_user_messages(params[:current_user_id], min_created_at)
        [messages, V1::MessageWrapper.messages_data(messages)]
      end

      def get_unread_count(params)
        Message.get_unread_count(params[:current_user_id])
      end

      def delete_message(params)
        message = Message.find_by_id(params[:message_id])
        if message.present?
          if message.can_delete?(params[:current_user_id])
            message.set_deleted
            [message, { success: true }]
          else
            ErrorCode.error_content(:message_cannot_delete)
          end
        else
          ErrorCode.error_content(:message_not_existed)
        end
      end

    end

  end
end