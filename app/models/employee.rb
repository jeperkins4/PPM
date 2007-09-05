class Employee < ActiveRecord::Base
  belongs_to :facility
  has_many :employee_positions
  
    validates_existence_of :facility
end
