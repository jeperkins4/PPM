class Legacy::CustodyType < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
