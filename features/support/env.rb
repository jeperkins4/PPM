require 'rubygems'

# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require File.expand_path(File.dirname(__FILE__) + "/../../spec/blueprints")

require 'cucumber/rails/world'
require 'capybara'
require 'capybara/dsl'
require 'cucumber/formatter/unicode'
require 'cucumber/rails/rspec'
require 'database_cleaner'
require 'database_cleaner/cucumber'

#Capybara.javascript_driver= :webkit

Cucumber::Rails::World.use_transactional_fixtures = false

ActionController::Base.allow_rescue = false

Webrat.configure do |config|
  include AuthenticatedTestHelper
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

begin
  DatabaseCleaner.strategy = (ENV['SELENIUM'] == 'true') ? :truncation : :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

#if Capybara.current_driver == :webkit
#  require 'headless'
#
#  headless = Headless.new
#  headless.start
#
#  at_exit do
#    headless.destroy
#  end
#end
