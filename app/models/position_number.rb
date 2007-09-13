class PositionNumber < ActiveRecord::Base
  belongs_to :position
  validates_uniqueness_of :position_num
  has_one :employee_position
  has_many :employee_position_hists
end
