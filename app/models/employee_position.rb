class EmployeePosition < ActiveRecord::Base
  belongs_to :position_number
  belongs_to :employee
  
  validates_existence_of :position_number, :employee
end
