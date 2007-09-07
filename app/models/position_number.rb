class PositionNumber < ActiveRecord::Base
  belongs_to :position
  validates_uniqueness_of :position_num
  has_one :employee_position
end
