class Legacy::Prompt < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
