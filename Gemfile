source 'https://rubygems.org'

ruby '3.2.2'

gem 'rails', '~> 8.0.0'
gem 'sqlite3', '>= 2.1'
gem 'puma', '>= 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'
gem 'redis', '>= 4.0.1'
gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[ mri windows ], require: 'debug/prelude'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'rails-controller-testing'
end