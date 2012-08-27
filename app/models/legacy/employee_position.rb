class Legacy::EmployeePosition < ActiveRecord::Base
  establish_connection "legacy_#{Rails.env}"
end
