class PositionNumber < ActiveRecord::Base
  attr_accessible :id, :active, :inactive_comment, :inactive_on, :position_id, :position_num, :position_type_id, :waiver_approval_date

  has_many :employee_position_histories
  belongs_to :position_type
  belongs_to :position

  delegate :title, :to => :position, :prefix => true, :allow_nil => true
  delegate :name, :to => :position_type, :prefix => true, :allow_nil => true
end
