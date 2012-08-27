class Legacy::Position < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
