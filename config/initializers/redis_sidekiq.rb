require "redis"
require "redis-namespace"


redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]

$redis = Redis::Namespace.new(redis_config['appname'],
  redis: Redis.new(host: redis_config['host'], port: redis_config['port']))


Sidekiq.configure_server do |config|
  config.redis = { :url => "redis://#{redis_config['host']}:#{redis_config['port']}", :namespace => redis_config['appname'] }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => "redis://#{redis_config['host']}:#{redis_config['port']}", :namespace => redis_config['appname'] }
end