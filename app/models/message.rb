# == Schema Information
#
# Table name: messages 用户消息
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null  消息发送者 ID
#  receiver_id  :integer          not null  消息接收者 ID
#  detail_type  :string(255)      not null  消息 detail 类型: Follow 用户关注
#  detail_id    :integer          not null  消息 detail ID
#  description  :string(255)                消息简介
#  status       :integer                    消息的状态
#  created_at   :datetime
#  updated_at   :datetime
#

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  belongs_to :detail, polymorphic: true

  DETAIL_TYPES = { 'Follow' => 'Follow' }

  STATUS_UNREAD = 0
  STATUS_READ = 1
  STATUS_DELETE = 2
  STATUS_CODES = {
    STATUS_UNREAD => "未读",
    STATUS_READ => "已读",
    STATUS_DELETE => "删除"
  }

  def status_word
    STATUS_CODES[self.status]
  end

  def is_unread?
    self.status == STATUS_UNREAD
  end

  def can_delete?(user_id)
    self.receiver_id == user_id
  end

  def set_deleted
    self.update_attributes(status: STATUS_DELETE)
  end

  class << self

    def list_user_messages(receiver_id, min_created_at, page = 1, per_page = 20)
      query = where(receiver_id: receiver_id).where(
        status: [Message::STATUS_READ, Message::STATUS_UNREAD])
      if min_created_at.present?
        query = query.where("created_at < ?", min_created_at)
      end
      query.page(page).per(per_page).order("created_at desc")
    end

    def build_follow_message(follow)
      message = Message.new({ sender_id: follow.user_id,
        receiver_id: follow.to_user_id,
        detail_type: 'Follow', detail_id: follow.id })
      if message.save
        increase_unread_count(follow.to_user_id, 'Follow')
        MessageWorker.delay.deliver_follow_message(message.id)
      end
    end

    def delete_unreads(detail_type, detail_id)
      messages = where(detail_type: detail_type, detail_id: detail_id,
        status: Message::STATUS_UNREAD).all
      messages.each do |message|
        decrease_unread_count(message.receiver_id, message.detail_type)
        message.set_deleted
      end
    end

    def increase_unread_count(user_id, item_key)
      unread_value = get_unread_count(user_id)
      unread_value[item_key.to_s] += 1
      set_unread_count(user_id, unread_value)
    end

    def decrease_unread_count(user_id, item_key)
      unread_value = get_unread_count(user_id)
      item_count = unread_value[item_key.to_s]
      if item_count > 0
        unread_value[item_key.to_s] -= 1
        set_unread_count(user_id, unread_value)
      end
    end

    def reset_unread_count(user_id, item_key)
      unread_value = get_unread_count(user_id)
      unread_value[item_key.to_s] = 0
      set_unread_count(user_id, unread_value)
    end

    def get_unread_count(user_id)
      unread_value = Util::RedisUtil.get(message_key(user_id))
      if unread_value.present?
        unread_value = JSON.parse(unread_value)
      else
        unread_value = { "Follow" => 0 }
        set_unread_count(user_id, unread_value)
      end
      unread_value
    end

    def set_unread_count(user_id, value)
      Util::RedisUtil.set(message_key(user_id), value.to_json)
    end

    def message_key(user_id)
      "tibet:message:unread:user:#{user_id}"
    end

  end

end
