class Employee < ActiveRecord::Base
  belongs_to :facility
  has_one :employee_positon
end
