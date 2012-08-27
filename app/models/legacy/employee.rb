class Legacy::Employee < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
