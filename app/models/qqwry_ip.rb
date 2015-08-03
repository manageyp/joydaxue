# == Schema Information
#
# Table name: qqwry_ips
# qqwry 纯真 IP 数据库，2015-03-05，445135条记录
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

class QqwryIp < ActiveRecord::Base

  class << self

    def fetch_ip_location(ip)
      cache_key = "qqwry_ip_#{ip.to_s}"
      cache_data = CacheService.get(cache_key)
      unless cache_data
        cache_data = search_ip(ip)
        CacheService.set_day_expires(cache_key, cache_data)
      end
      cache_data
    end

    def search_ip(ip)
      ret = ["未知", ""]
      return ret if ip.blank?
      return ret unless ip.to_s =~ /^\d+\.\d+\.\d+\.\d+$/
      return ["本地", ""] if ip == "127.0.0.1"

      longip = ip2long(ip)
      record = select('country,location').where("? > start_long AND ? < end_long",
        longip, longip).first
      ret = [record.country, record.location] if record.present?

      ret
    end

    def duplicated_ip(start_ip, end_ip)
      where(start_long: ip2long(start_ip), end_long: ip2long(end_ip)).first
    end

    def build_qqwry_ip(start_ip, end_ip, country, location)
      create(start_long: ip2long(start_ip),
        end_long: ip2long(end_ip),
        country: country,
        location: location,
        start_ip: start_ip,
        end_ip: end_ip)
    end

    def ip2long(value)
      long = 0
      value.split(/\./).each_with_index do |b, i|
        long += b.to_i << 8*(3-i)
      end
      long
    end

  end

end
