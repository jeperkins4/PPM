class InmateCount < ActiveRecord::Base
  belongs_to :facility
  belongs_to :custody_type
  attr_accessible :collected_on, :custody_type_id, :facility_id, :inmate_count
end
