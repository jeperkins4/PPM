<<<<<<< HEAD
module PositionTypesHelper
end
=======
module PositionTypesHelper
  def select_facility
    select :position_type, :facility_id, Facility.find(:all).collect {|fac| [fac.facility, fac.id] }
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
