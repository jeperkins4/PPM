source 'https://rubygems.org'

#gem 'rails', '~> 4.0.0.beta', :github => 'rails/rails'
gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'decent_exposure'
gem 'haml-rails'
gem 'carrierwave'
gem 'clerk' # Adds userstamping 
gem 'kaminari'
gem 'squeel'
gem 'showoff-io'
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass', '~> 2.0.1'
  gem 'font-awesome-rails'
  gem 'haml_coffee_assets'
  gem 'execjs'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-datatables-rails', :github => 'rweng/jquery-datatables-rails'
end

group :development do
  gem 'sqlite3'
  gem 'mysql2'
  gem 'debugger'
  gem 'hpricot'  # Used to migrate erb to haml
  gem 'ruby_parser'  # Used to migrate erb to haml
end

group :test do
  gem 'fabrication'
  gem 'capybara', '~> 1.1.2'
end

group :production do
  gem 'pg'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'debugger'

gem "unicorn", ">= 4.3.1"
gem "rspec-rails", ">= 2.11.0", :group => [:development, :test]
gem "email_spec", ">= 1.2.1", :group => :test
gem "cucumber-rails", ">= 1.3.0", :group => :test, :require => false
gem "database_cleaner", ">= 0.8.0", :group => :test
gem "launchy", ">= 2.1.2", :group => :test
gem "devise", ">= 2.1.2", :git => 'git://github.com/plataformatec/devise.git'
gem 'simple_form'
gem "therubyracer", :group => :assets, :platform => :ruby
