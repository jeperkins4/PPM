class PositionNumber < ActiveRecord::Base
  belongs_to :position
  validate_on_create :ensure_active_position_num_unique
  has_one :employee_position
  has_many :employee_position_hists
  validates_presence_of [:position_id, :position_num, :position_type]
  validates_each :active_flag, :if => :changed_active_flag do |record, attr, value|
    if record.id && EmployeePosition.first(:select => 'id', :conditions => "position_number_id = #{record.id}")
      record.errors.add attr, "is set to inactive but an employee still uses this position number. Delete the employee from Employee/Position Tracking first." 
    end
  end
  
  before_validation :set_inactive_on

  default_scope :conditions => ["active_flag = ?", true]

  named_scope :for_facility, lambda {|facility_id|
    position_ids = Position.all(:select => 'pt.facility_id, positions.id', :joins => 'inner join position_types pt on positions.position_type_id = pt.id', 
                                :conditions => ['facility_id = ?', facility_id]).map(&:id)
    {:conditions => "position_id in ('#{position_ids.join('\',\'')}')"}
  }
  def ensure_active_position_num_unique
    if PositionNumber.first(:select => 'position_num', 
                            :from => 'position_numbers pn, positions p, position_types pt', 
                            :conditions => ['p.id = pn.position_id and p.position_type_id = pt.id and pt.facility_id = ? and position_num = ?', position.position_type.facility_id, position_num])
      errors.add :position_num, " is already active. Uncheck the active flag of the other position already using this position number or use a different position number."
    end
  end
  def self.for_facility_with_invalid(facility)
    with_exclusive_scope do
      PositionNumber.find(:all, :select => "position_numbers.*,
                                             if(position_numbers.active_flag = 0, 
                                                 concat(position_numbers.position_num, ' (inactive)'),
                                                 position_numbers.position_num) as position_num",
                                :joins => 'inner join positions p on p.id = position_numbers.position_id
                                           inner join position_types pt on p.position_type_id = pt.id
                                           inner join facilities f on f.id = pt.facility_id',
                                :conditions => ['f.id = ?', facility.id],
                                :order => 'position_num asc')
    end
  end

  def set_inactive_on
    if changes.keys.include?('inactive_on') && changes['inactive_on'][1]
        self.active_flag = false
    end
    true
  end

  def changed_active_flag
    changed.include? 'active_flag'
  end
end
