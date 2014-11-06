class Role < ActiveRecord::Base
  include Util::CommonFields

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
