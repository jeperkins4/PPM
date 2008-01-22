class EmployeePositionHist < ActiveRecord::Base
  
  validates_presence_of :position_number_id, :employee_id, :start_date, :end_date
 
  belongs_to :position_number
  belongs_to :employee
  
  force_uppercase :include_text => true

end
