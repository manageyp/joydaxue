# == Schema Information
#
# Table name: users 用户
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null       名称
#  email        :string(255)      DEFAULT null   邮箱
#  cellphone    :string(255)      DEFAULT null   手机号
#  sex          :integer                     性别
#  status       :integer          default(0) 状态
#  memo         :string(255)                 备注
#  password         :string(255)             用户密码
#  password_salt    :string(255)             用户密码 token
#  created_at   :datetime
#  updated_at   :datetime
#

class User < ActiveRecord::Base
  has_one :user_role
  has_many :user_devices

  attr_accessor :captcha_number

  validates :name, uniqueness: true, presence: true
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
    pwd_value.present? &&
    self.password == Util::TokenUtil.generate_password(pwd_value, self.password_salt)
  end

  def set_password(pwd_value)
    password_salt = Util::TokenUtil.friendly_token
    self.password_salt = password_salt
    self.password = Util::TokenUtil.generate_password(pwd_value, password_salt)
  end

  def refresh_user(params)
    self.name = params[:name] if params[:name].present?
    self.email = params[:email] if params[:email].present?
    self.cellphone = params[:cellphone] if params[:cellphone].present?
    self.sex = params[:sex] if params[:sex].present?
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

    def register_by_cellphone(captcha, password)
      user = User.new
      User.transaction do
        user.cellphone = captcha.cellphone
        user.name = Util::TokenUtil.random_name
        user.set_password(password)
        user.save

        # TODO UserToken.create_token(user.id)
        captcha.destroy
      end
      user
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
