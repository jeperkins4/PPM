module EmployeePositionHistsHelper
  def position_number_select_options
    ordered_position_numbers.
      collect { |pn| [pn.position_num+ "-" + pn.position.title , pn.id ] }
  end
  
  def ordered_position_numbers
    PositionNumber.for_facility_with_invalid(session[:facility])
  end
end
