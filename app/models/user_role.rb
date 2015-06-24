# == Schema Information
#
# Table name: user_roles 用户角色
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null  用户 ID
#  role_id    :integer          not null  角色 ID
#  created_at :datetime
#  updated_at :datetime
#

class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

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
