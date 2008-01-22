class EmployeePositionHist < ActiveRecord::Base
  
  validates_presence_of :position_number_id
  validates_presence_of :employee_id
  validates_presence_of :start_date
  validates_presence_of :end_date  
 
  belongs_to :position_number
  belongs_to :employee
  
  force_uppercase :include_text => true

end
