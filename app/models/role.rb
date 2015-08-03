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
  has_many :user_roles
  has_many :permissions

  scope :active, -> { where(status: :active) }

  STATUS_CODES = { 0 => '正常', 1 => '锁定' }

  def status_word
    STATUS_CODES[self.status]
  end

  def is_active?
    self.status == 0
  end

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
