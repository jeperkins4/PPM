class Legacy::ActionType < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
