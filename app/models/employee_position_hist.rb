class EmployeePositionHist < ActiveRecord::Base
  belongs_to :position_number
  belongs_to :employee
  
  validates_presence_of :position_number_id
  validates_presence_of :employee_id
  validates_presence_of :start_date
  validates_presence_of :end_date  
 
  force_uppercase :include_text => true
  
  named_scope :generic_for_position_numbers, lambda {|position_number_ids|
    {:select => 'f.facility, p.title, pn.position_num, e.first_name,
                 e.last_name, eph.id, eph.start_date, eph.end_date,
                 eph.salary',
     :from => 'employee_position_hists eph',
     :joins => 'inner join position_numbers pn on eph.position_number_id = pn.id
                inner join positions p on pn.position_id = p.id
                inner join employees e on eph.employee_id = e.id
                inner join position_types pt on p.position_type_id = pt.id
                inner join facilities f on pt.facility_id = f.id',
     :conditions => ["pn.id in (?)",position_number_ids]}
  }

  def self.available_positions(facility_id)
    EmployeePosition.find(:all, 
      :select => 'ep.id as id, ep.position_number_id, ep.employee_id, ep.start_date, ep.end_date', 
      :order=>'p.title',
      :from=>'employee_positions ep, position_numbers pn, positions p, facilities f',
      :conditions=>['ep.position_number_id = pn.id and pn.position_id = p.id and p.facility_id = f.id
                          and f.id = ?', facility_id])
  end



end
