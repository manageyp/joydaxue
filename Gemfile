source 'https://ruby.taobao.org'
#source 'https://rubygems.org'

gem 'rails', '4.1.8'

gem 'mysql2', '0.3.16'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
# gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Grape RESTful API microframework
gem 'grape', ' 0.9.0'
# gem 'active_model_serializers', ' 0.9.3'
# gem 'grape-active_model_serializers', '1.3.2'

# Use unicorn as the app server
gem 'unicorn', "4.8.3"

# search engine
gem "ransack", github: "activerecord-hackery/ransack", branch: "rails-4.1"

# paginage
gem "kaminari", '0.16.1'
gem 'kaminari-bootstrap', '3.0.1'

# Ruby client library for Redis.
gem 'redis', '3.1.0'
gem 'redis-namespace', '1.5.0'

# YAML settings
gem "settingslogic", "2.0.9"

# Exception notification
gem 'exception_notification', '4.0.1'

# New Relic Ruby Agent
gem 'newrelic_rpm', '3.9.6.257'
# gem 'newrelic-grape', '2.0.0'

group :development, :test do
  # generate model schema info
  gem "annotate", "~> 2.6.0.beta2"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '1.1.3'

  gem "rspec-rails", '3.0.1'
  gem "factory_girl", '4.4.0'
  gem "factory_girl_rails", '4.4.1'
  gem 'spork', '0.9.2'
  gem 'minitest', '5.3.5'

  # Use Capistrano for deployment
  gem 'capistrano-rails'
end

group :test do
  gem 'shoulda-matchers', '2.8.0'
  gem 'database_cleaner', '1.4.1'
end

