class EmployeePosition < ActiveRecord::Base
  belongs_to :position_number
  belongs_to :employee
  validates_presence_of :position_number_id
  validates_presence_of :employee_id
  validates_uniqueness_of :employee_id, :message => "is already assigned to a Position"
  validates_uniqueness_of :position_number_id, :message => "is already assigned to an employee"
  validates_presence_of :start_date
  force_uppercase :include_text => true
    
  def self.available_positions(facility_id)
    EmployeePosition.find(:all, 
                          :select => 'ep.id as id, ep.position_number_id, ep.employee_id, ep.start_date, ep.end_date', 
                          :order=>'p.title',
                          :from=>'employee_positions ep, position_numbers pn, positions p, position_types pt, facilities f',
                          :conditions=>['ep.position_number_id = pn.id and pn.position_id = p.id and pt.id = p.position_type_id and pt.facility_id = f.id
                          and f.id = ?', facility_id])
  end
end
