class Legacy::Session < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
