class EmployeePosition < ActiveRecord::Base
  belongs_to :position_number
  belongs_to :employee
  validates_uniqueness_of :employee_id, :scope => [:position_number_id]  
  validates_existence_of :position_number, :employee
end
