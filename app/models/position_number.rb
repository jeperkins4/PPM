class PositionNumber < ActiveRecord::Base
  belongs_to :position
  validates_uniqueness_of :position_num
  has_many :employee_positions
  
  validates_existence_of :position
end
