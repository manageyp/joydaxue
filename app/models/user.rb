class User < ActiveRecord::Base

  scope :active, -> { where(status: 0) }


  ModelName = "用户"
  ColumnNames = {
    name: "名称",
    email: "邮箱",
    cellphone: "手机号",
    display_name: "姓名",
    sex: "性别",
    status: "状态",
    memo: "备注"
  }


  STATUS_CODES = {
    0 => '正常',
    1 => '锁定'
  }

  SEX_TYPES = {
    0 => "女",
    1 => "男"
  }

  def sex_word
    SEX_TYPES[sex]
  end

  def status_word
    STATUS_CODES[status]
  end

  def refresh_info(params)
    self.name = params[:name] if params[:name].present?
    self.email = params[:email] if params[:email].present?
    self.cellphone = params[:cellphone] if params[:cellphone].present?
    self.sex = params[:sex] if params[:sex].present?
    self.display_name = params[:display_name] if params[:display_name].present?
    self.status = params[:status] if params[:status].present?
    self.memo = params[:memo] if params[:memo].present?
    self.save
  end

  class << self

    def build(params)
      user = User.new(params)
      user if user.save
    end

  end

end
