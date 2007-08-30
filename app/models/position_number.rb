class PositionNumber < ActiveRecord::Base
  belongs_to :position
  validates_uniqueness_of :position_num
  
end
