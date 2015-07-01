# == Schema Information
#
# Table name: schools 学校
#
#  id               :integer          not null, primary key
#  province_id      :integer          not null  所属省份
#  city_id          :integer          not null  所属城市
#  name             :string(255)      not null  名称
#  address          :string(255)                地址
#  college_type     :string(255)                院校类别
#  telephone        :string(255)                联系电话
#  avatar           :string(255)                头像
#  website          :string(255)                网址
#  found_year       :string(255)                创建年份
#  zipcode          :string(255)                邮政编码
#  affiliate        :string(255)                院校隶属于
#  latitude         :decimal(10, 6)   default(0.0)   纬度
#  longitude        :decimal(10, 6)   default(0.0)   经度
#  is_211           :boolean          default(FALSE) 是否 211
#  is_985           :boolean          default(FALSE) 是否 985
#  is_edu_affiliate :boolean          default(FALSE) 是否教育部直属院校
#  has_bachelor     :boolean          default(FALSE) 设立研究生院
#  is_independent   :boolean          default(FALSE) 独立学院
#  is_civilian_run  :boolean          default(FALSE) 民办院校
#  key_disciplines  :integer          default(0)     国家重点学科
#  master_num       :integer          default(0)     硕士点
#  phd_num          :integer          default(0)     博士点
#  academician_num  :integer          default(0)     院士人数
#  created_at       :datetime
#  updated_at       :datetime
#

class School < ActiveRecord::Base
  has_one :school_introduction
  has_many :school_photos

  def favorite_id
    "school:#{self.id}"
  end

  class << self

    def fetch_school(id)
      where(id: id).includes(:school_photos, :school_introduction).first
    end

    def paginate_schools(min_updated_at, page = 1, per_page = 10)
      if min_updated_at.present?
        where("updated_at < ?", min_updated_at).page(page).per(per_page).order("updated_at desc")
      else
        all.page(page).per(per_page).order("updated_at desc")
      end
    end

  end

end
