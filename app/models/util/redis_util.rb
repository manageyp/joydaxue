# -*- encoding : utf-8 -*-

module Util
  class RedisUtil

    class << self

      # Key
      def expire(key, ttl=60*24*3600)
        $redis.expire(key, ttl)
      end

      def del(key)
        $redis.del(key)
      end

      # String
      def get(key)
        $redis.get(key)
      end

      def set(key, value)
        $redis.set(key, value)
      end

      def setex(key, value, ttl=60*24*3600)
        $redis.setex(key, ttl, value)
      end

      # List
      def rpush(key, value)
        $redis.rpush(key, value)
      end

      def llen(key)
        $redis.llen(key)
      end

      # Set
      def sadd(key, value)
        $redis.sadd(key, value)
      end

      def smembers(key)
        $redis.smembers(key)
      end

      def srem(key, value)
        $redis.srem(key, value)
      end

      def scard(key)
        $redis.scard(key)
      end

    end
  end
end