class Legacy::EmployeePositionHist < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
