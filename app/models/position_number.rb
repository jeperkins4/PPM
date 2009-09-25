class PositionNumber < ActiveRecord::Base
  belongs_to :position
  validates_uniqueness_of :position_num, :scope => :position_id
  has_one :employee_position
  has_many :employee_position_hists
  validates_presence_of [:position_id, :position_num, :position_type]
  named_scope :for_facility, lambda {|facility_id|
    position_ids = Position.all(:select => 'pt.facility_id, positions.id', :joins => 'inner join position_types pt on positions.position_type_id = pt.id', 
                                :conditions => ['facility_id = ?', facility_id]).map(&:id)
    {:conditions => "position_id in ('#{position_ids.join('\',\'')}')"}
  }
#  default_scope :conditions => ["active_flag = ?", true]
end
