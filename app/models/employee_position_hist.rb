class EmployeePositionHist < ActiveRecord::Base
 
  belongs_to :position_number
  belongs_to :employee

end
