class Legacy::AccountabilityLog < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
