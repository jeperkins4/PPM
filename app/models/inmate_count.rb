class InmateCount < ActiveRecord::Base
  attr_accessible :collected_on, :custody_type_id, :facility_id, :inmate_count
end
