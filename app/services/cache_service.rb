class CacheService

  class << self

    def get(key)
      Rails.cache.read(key)
    end

    def set(key, value)
      Rails.cache.write(key, value)
    end

    def set_day_expires(key, value, ttl = 60*60*24)
      Rails.cache.write(key, value, time_to_idle: ttl)
    end

    def set_week_expires(key, value, ttl = 60*60*24*7)
      Rails.cache.write(key, value, time_to_idle: ttl)
    end

    def set_month_expires(key, value, ttl = 60*60*24*30)
      Rails.cache.write(key, value, time_to_idle: ttl)
    end

  end

end