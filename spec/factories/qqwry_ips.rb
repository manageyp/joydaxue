# == Schema Information
#
# Table name: qqwry_ips
#
#  id          :integer          not null, primary key
#  start_long  :string(255)      start_ip 的长整形值
#  end_long    :string(255)      end_ip 的长整形值
#  country     :string(255)      IP 所在国家
#  location    :string(255)      IP 所在地区
#  start_ip    :string(255)      IP 开始段
#  end_ip      :string(255)      IP 结束段
#  created_at  :datetime
#  updated_at  :datetime

FactoryGirl.define do
  factory :qqwry_ip do
    start_long "MyString"
    end_long "MyString"
    country "MyString"
    location "MyString"
    start_ip "MyString"
    end_ip "MyString"
  end
end
