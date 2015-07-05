# == Schema Information
#
# Table name: users 用户
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null   名称
#  email        :string(255)      not null   邮箱
#  cellphone    :string(255)      not null   手机号
#  display_name :string(255)                 姓名
#  sex          :integer                     性别
#  status       :integer          default(0) 状态
#  memo         :string(255)                 备注
#  created_at   :datetime
#  updated_at   :datetime
#

class User < ActiveRecord::Base
  has_one :user_role
  has_many :user_devices

  attr_accessor :captcha_number

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :cellphone, uniqueness: true, presence: true

  scope :active, -> { where(status: 0) }

  SEX_TYPES = { 0 => "女", 1 => "男" }
  STATUS_CODES = { 0 => '正常', 1 => '锁定' }

  def status_word
    STATUS_CODES[self.status]
  end

  def sex_word
    SEX_TYPES[self.sex]
  end

  def is_active?
    self.status == 0
  end

  def valid_password?(pwd_value)
    # TODO valid password
  end

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

    def fetch_by_id(id)
      record = select(:id, :updated_at).where(id: id).first
      if record
        cache_key = "user_#{record.id}_#{record.updated_at.to_i}"
        cache_data = CacheService.get(cache_key)
        unless cache_data
          cache_data = find_by_id(id)
          CacheService.set_week_expires(cache_key, cache_data)
        end
        cache_data
      end
    end

    def fetch_by_cellphone(cellphone)
      where(cellphone: cellphone).first
    end

    def register(cellphone, password)
      # TODO do user register and set password
    end

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
