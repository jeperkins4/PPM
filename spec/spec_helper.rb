require 'rubygems'
require 'spork'
require 'spork/ext/ruby-debug'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  require File.dirname(__FILE__) + "/../config/environment" #unless defined?(RAILS_ROOT)
  require 'spec'
  require 'spec/autorun'
  require 'spec/rails'
  require 'machinist/active_record'
  require 'faker'
  require 'sham'


end

Spork.each_run do
  require File.expand_path(File.dirname(__FILE__) + "/blueprints")
end


Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Spec::Runner.configure do |config|

  include AuthenticatedTestHelper

  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # Reset machinist tests
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }

end
