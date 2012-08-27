class Legacy::PositionType < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
