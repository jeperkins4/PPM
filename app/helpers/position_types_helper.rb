module PositionTypesHelper
  def select_facility
    select :position_type, :facility_id, Facility.find(:all).collect {|fac| [fac.facility, fac.id] }
  end
end
