class Legacy::Context < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
