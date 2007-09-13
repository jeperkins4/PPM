class PositionNumber < ActiveRecord::Base
  belongs_to :position
  validates_uniqueness_of :position_num, :scope => :position_id
  has_one :employee_position
  has_many :employee_position_hists
  validates_presence_of [:position_id, :position_num, :position_type]
end
