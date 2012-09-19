<<<<<<< HEAD
class InmateCount < ActiveRecord::Base
  attr_accessible :collected_on, :custody_type_id, :facility_id, :inmate_count
end
=======
class InmateCount < ActiveRecord::Base
  belongs_to :facility
  belongs_to :custody_type
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
