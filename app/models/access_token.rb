# == Schema Information
#
# Table name: access_tokens 用户 Token
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null  用户 ID
#  token      :string(255)      not null  用户唯一标识 Token
#  expired_at :datetime                   Token 过期时间点
#  created_at :datetime
#  updated_at :datetime
#

class AccessToken < ActiveRecord::Base

end
