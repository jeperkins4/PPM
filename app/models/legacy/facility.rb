class Legacy::Facility < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
