class EmployeePosition < ActiveRecord::Base
  belongs_to :position_number
  belongs_to :employee
  validates_presence_of :position_number
  validates_presence_of :employee
  validates_uniqueness_of :employee_id, :message => "is already assigned to a Position"
  validates_presence_of :start_date
 end
