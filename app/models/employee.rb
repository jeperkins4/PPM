class Employee < ActiveRecord::Base
  belongs_to :facility
  has_one :employee_position
  has_many :employee_position_hists
  attr_accessible :id, :active, :emplid, :facility_id, :firstname, :lastname, :tea_status

  delegate :name, :to => :facility, :prefix => true, :allow_nil => true

  validates_presence_of :first_name, :last_name
  validates_presence_of :tea_status  
  #validates_uniqueness_of :first_name, :scope => [:facility_id,:last_name],:case_sensitive => false
  force_uppercase :include_text => true, :except => :tea_status
  validates_uniqueness_of :lastname, :scope => [:emplid, :firstname, :facility_id]

  def name
    [firstname,lastname].join(" ")
  end
end
