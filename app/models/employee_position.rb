class EmployeePosition < ActiveRecord::Base
  belongs_to :position_number
  belongs_to :employee
  validates_presence_of :position_number_id
  validates_presence_of :employee_id
  validates_uniqueness_of :employee_id, :message => "is already assigned to a Position"
  validates_uniqueness_of :position_number_id, :message => "is already assigned to an employee"
  validates_presence_of :start_date
 end
