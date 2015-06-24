# == Schema Information
#
# Table name: access_tokens
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  token      :string(255)      not null
#  expired_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

class AccessToken < ActiveRecord::Base

  ModelName = "用户 Token"
  ColumnNames = {
    user_id: "用户 ID",
    token: "用户唯一标识 Token",
    expired_at: "Token 过期时间点"
  }

end
