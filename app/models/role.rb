# == Schema Information
#
# Table name: roles 角色
#
#  id          :integer          not null, primary key
#  name        :string(255)                 名称
#  description :string(255)                 描述
#  status      :integer          default(0) 状态
#  created_at  :datetime
#  updated_at  :datetime
#

class Role < ActiveRecord::Base
  include Util::CommonFields

  has_many :user_roles
  has_many :permissions

  scope :active, -> { where(status: 0) }

  def refresh_role(params)
    self.name = params[:name] if params[:name].present?
    self.description = params[:description] if params[:description].present?
    self.status = params[:status] if params[:status].present?
    self.save
  end

  class << self

    def build_role(params)
      record = Role.new(params)
      record if record.save
    end

  end

end
