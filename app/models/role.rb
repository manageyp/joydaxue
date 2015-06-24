# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  status      :integer          default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

class Role < ActiveRecord::Base
  include Util::CommonFields

  has_many :user_roles

  scope :active, -> { where(status: 0) }

  ModelName = "角色"
  ColumnNames = {
    name: "名称",
    description: "描述",
    status: "状态"
  }

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
