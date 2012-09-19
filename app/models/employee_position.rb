class EmployeePosition < ActiveRecord::Base
  belongs_to :position_number
  belongs_to :employee
  validates_presence_of :position_number_id
  validates_presence_of :employee_id
  validates_uniqueness_of :employee_id, :message => "is already assigned to a Position"
  validates_uniqueness_of :position_number_id, :message => "is already assigned to an employee"
  validates_presence_of :start_date
  validate :ensure_active_position_number 
  
  force_uppercase :include_text => true
  
  named_scope :available_positions, lambda {|facility_id|
    {:select => 'ep.id as id, ep.position_number_id, ep.employee_id, ep.start_date, ep.end_date, pn.active_flag', 
     :order=>'p.title',
     :from=>'employee_positions ep, position_numbers pn, positions p, position_types pt, facilities f',
     :conditions=>['ep.position_number_id = pn.id and pn.position_id = p.id and pt.id = p.position_type_id and pt.facility_id = f.id
       and f.id = ?', facility_id]
    }
  }

  def ensure_active_position_number
      errors.add :position_number, " is inactive. Choose a different one." unless PositionNumber.send(:with_exclusive_scope) do 
        begin 
          PositionNumber.find(position_number_id).active_flag
        rescue
          false
        end
      end
  end

end
