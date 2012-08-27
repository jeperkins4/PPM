class Legacy::Upload < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
