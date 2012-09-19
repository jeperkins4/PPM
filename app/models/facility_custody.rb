class FacilityCustody < ActiveRecord::Base
  belongs_to :facility
  belongs_to :custody_type
end
