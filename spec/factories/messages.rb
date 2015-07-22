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

FactoryGirl.define do
  factory :message do
    id 1
    sender_id 1
    receiver_id 2
    detail_type "Follow"
    detail_id 1
    description "New follower"
    status 0
  end

  factory :pair_message, class:Message do
    id 2
    sender_id 2
    receiver_id 1
    detail_type "Follow"
    detail_id 1
    description "New follower"
    status 0
  end
end
