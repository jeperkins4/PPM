class Legacy::User < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
