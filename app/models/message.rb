# == Schema Information
#
# Table name: messages 用户消息
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null  消息发送者 ID
#  receiver_id  :integer          not null  消息接收者 ID
#  detail_type  :string(255)      not null  消息 detail 类型
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

    def build_follow_message(follow)
      message = Message.new({ sender_id: new_follow.user_id,
        receiver_id: new_follow.to_user_id,
        detail_type: 'Follow', detail_id: new_follow.id })
      message.save
      # TODO
      # increase_unread_count
      # MessageWorker.delay.xinge_user_follow_push(message.id)
    end

    def delete_unreads(detail_type, detail_id)
      where(detail_type: detail_type, detail_id: detail_id,
        status: Message::STATUS_UNREAD).update_all(status: Message::STATUS_DELETE)
    end

  end

end
