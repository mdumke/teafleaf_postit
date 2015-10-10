source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'bootstrap-sass', '~> 2.3.2.0'

gem 'bcrypt-ruby', '~> 3.0.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

gem 'voteable_matthias', path: "#{ system('pwd') }/../../voteable_gem"

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'quiet_assets'
  gem 'pry-rails'
  gem 'sqlite3'
  gem 'awesome_print'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
