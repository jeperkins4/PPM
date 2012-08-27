class Legacy::AccountabilityLogDetail < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
