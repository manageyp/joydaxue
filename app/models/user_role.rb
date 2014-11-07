class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  ModelName = "用户角色"
  ColumnNames = {
    user_id: "用户 ID",
    role_id: "角色 ID"
  }

  def refresh_user_role(params)
    self.user_id = params[:user_id] if params[:user_id].present?
    self.role_id = params[:role_id] if params[:role_id].present?
    self.save
  end

  class << self

    def build_user_role(params)
      record = UserRole.new(params)
      record if record.save
    end

  end

end
