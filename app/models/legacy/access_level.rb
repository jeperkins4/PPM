class Legacy::AccessLevel < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
