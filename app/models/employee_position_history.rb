class EmployeePositionHistory < ActiveRecord::Base
  attr_accessible :employee_id, :end_date, :position_number_id, :salary, :start_date
  belongs_to :employee
  belongs_to :position_number

  delegate :name, :to => :employee, :prefix => true, :allow_nil => true
end
