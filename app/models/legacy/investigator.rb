class Legacy::Investigator < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
