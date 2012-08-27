class Legacy::Incident < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
