class Legacy::IncidentType < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
