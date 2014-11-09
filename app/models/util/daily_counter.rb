module Util
  class DailyCounter

    class << self
      def get_counter(name)
        $redis.get(daily_key(name)).to_i
      end

      def set_counter(name, count, ttl = 24*3600)
        key = daily_key(name)
        $redis.setex(key, ttl, count)
      end

      def increase_counter(name, ttl = 24*3600)
        key = daily_key(name)
        num = $redis.get(key).to_i
        if num == 0
          $redis.setex(key, ttl, 1)
        else
          $redis.incr(key)
        end
      end

      private

      def daily_key(name)
        "#{name}:#{Date.today.strftime("%m%d")}"
      end

    end
  end
end