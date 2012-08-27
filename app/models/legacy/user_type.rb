class Legacy::UserType < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
