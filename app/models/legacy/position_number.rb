class Legacy::PositionNumber < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
