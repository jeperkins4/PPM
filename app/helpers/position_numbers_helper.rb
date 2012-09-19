<<<<<<< HEAD
module PositionNumbersHelper
end
=======
module PositionNumbersHelper
  def active(position_number)
    position_number.inactive_on ? position_number.inactive_on : 'Still active'
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
