module PositionNumbersHelper
  def active(position_number)
    position_number.inactive_on ? position_number.inactive_on : 'Still active'
  end
end
