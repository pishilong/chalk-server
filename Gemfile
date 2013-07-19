source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

###################### Gems added for chalk ########################

# Use thin to replace webrick, to avoid the "HTTP response" warning.
gem 'thin', '~> 1.5.0'

group :test, :development do
  gem 'rspec-rails', '~> 2.0'
end

group :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
end

group :development do
  gem 'quiet_assets'
  gem 'rails_best_practices'
  gem "spork-rails"
  gem 'guard'
  gem 'rb-fsevent', '~> 0.9.1' # required by guard
  gem 'guard-spork'
  gem 'terminal-notifier-guard'
  gem 'guard-rspec'
  # See all routes at http://localhost:3000/rails/routes in development
  gem 'sextant'
  # Add tasks of dumping database to yaml and loading yaml to database
  gem 'yaml_db'
  # Comments document
  gem 'yard'
end

#gem 'devise', '~> 2.2.3'
#gem 'devise-encryptable'
#gem 'devise-async'
#gem 'cancan', '~> 1.6.8'
#gem 'role_model', '~> 0.8'

#gem "galetahub-simple_captcha", :require => "simple_captcha"#, git: 'git://github.com/galetahub/simple-captcha.git'

#gem 'resque', '~> 1.23'
#gem 'resque-scheduler', :require => 'resque_scheduler'

#gem 'redis-rails'

# Speed up assets:precompile
gem 'turbo-sprockets-rails3', '~> 0.3.5'

# 第三方帐号集成: QQ, 新浪微博, 人人网
#gem "oauth2"

# 分页
gem 'kaminari', '~> 0.14.1'

# 通过邮件发送服务器代码的异常错误
#gem 'exception_notification', '~> 3.0.0'

# 监控和管理关键进程
gem 'god', '~> 0.13.1'

# 用于设置model属性的默认值
gem 'default_value_for', '~> 2.0.1'

# 保存到数据库时自动将空字符作为 NULL 处理, 自动 strip
gem 'attribute_normalizer', '1.1.0'

# Serialize models to JSON
gem "active_model_serializers", "~> 0.8.1"

gem "strong_parameters", "~> 0.2.0"

# 方便统计
gem 'groupdate'

# 网站性能统计分析
gem 'newrelic_rpm'

# Excel插件
gem 'spreadsheet'
