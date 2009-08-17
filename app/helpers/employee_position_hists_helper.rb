module EmployeePositionHistsHelper
  def position_number_select_options
    ordered_position_numbers.collect {|pn| [ pn.position_num + "-" + pn.position.title , pn.id ] }
  end
  
  def ordered_position_numbers
    position_numbers = session[:facility].position_numbers
    PositionNumber.find(position_numbers, :order => 'position_num asc')
  end
end
