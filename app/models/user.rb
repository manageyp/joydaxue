# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  email        :string(255)      not null
#  cellphone    :string(255)      not null
#  display_name :string(255)
#  sex          :integer
#  status       :integer          default(0)
#  memo         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class User < ActiveRecord::Base
  include Util::CommonFields

  has_one :user_role

  attr_accessor :captcha_number

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

  def refresh_user(params)
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

    def build_user(params)
      record = User.new(params)
      User.transaction do
        record.save
        captcha = Captcha.build_captcha(record.cellphone)
        record.captcha_number = captcha.code if captcha
      end
      record
    end

  end

end
