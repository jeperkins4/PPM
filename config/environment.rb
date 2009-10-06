RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

require 'yaml'
raw_config = File.read(RAILS_ROOT + "/config/config.yml")
APP_CONFIG = YAML.load(raw_config)[RAILS_ENV]

Rails::Initializer.run do |config|
  config.action_controller.session = { :key => "_ppms_session", :secret => "a salty phrase for ppm us3rs et 411 07h3r5" }
  config.action_controller.session_store = :active_record_store
  config.active_record.observers = :user_observer
  config.gem 'mislav-will_paginate', :version => '~> 2.3.11', :lib => 'will_paginate', 
    :source => 'http://gems.github.com'
  config.gem "calendar_date_select"
end

ExceptionNotifier.exception_recipients = %w(bernardo.telles@dms.myflorida.com)
