class Employee < ActiveRecord::Base
  belongs_to :facility
  has_one :employee_positon
  has_many :employee_position_hists
end
