module PositionNumbersHelper
  def active(position_number)
    position_number.active_flag ? 'Active position number' : 'Inactive position number'
  end
end
