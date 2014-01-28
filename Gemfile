source 'https://rubygems.org'
ruby '2.1.0'

gem 'rails', '4.0.1'
gem 'rails-api'
gem 'pg', '~> 0.17.1'
gem 'thin', '~> 1.6.1'
gem 'rabl'

#heroku
gem 'rails_12factor'

group :development, :test do
  gem 'rspec-rails', '~> 2.14.1'
  gem 'factory_girl_rails', '4.2.1'
  gem 'mocha', '~> 1.0.0'
  gem 'pry'
  gem 'pry-debugger'
  gem 'quiet_assets'
  gem 'parallel_tests'
  gem 'zeus-parallel_tests'
  gem 'guard-rspec'
  gem 'rb-fsevent'
end

group :development do 
  gem 'guard-livereload'
  gem 'rack-livereload'
  gem 'better_errors'
  gem 'terminal-notifier-guard'
end

group :test do
  gem 'launchy', '>= 2.1.2'
  gem 'database_cleaner', '~> 1.2.0'
  gem 'zeus', :require => false
  gem 'shoulda-matchers'
end
