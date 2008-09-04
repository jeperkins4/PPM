class Employee < ActiveRecord::Base
  belongs_to :facility
  has_one :employee_positon
  has_many :employee_position_hists
  validates_presence_of :first_name, :last_name
  validates_presence_of :tea_status  
  validates_uniqueness_of :first_name, :scope => [:facility_id,:last_name],:case_sensitive => false
  force_uppercase :include_text => true

end
