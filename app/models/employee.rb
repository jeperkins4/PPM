class Employee < ActiveRecord::Base
  belongs_to :facility
  has_many :employee_positions
end
