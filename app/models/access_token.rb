class AccessToken < ActiveRecord::Base

  ModelName = "用户 Token"
  ColumnNames = {
    user_id: "用户 ID",
    token: "用户唯一标识 Token",
    expired_at: "Token 过期时间点"
  }

end
