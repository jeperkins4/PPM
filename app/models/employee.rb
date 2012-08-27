class Employee < ActiveRecord::Base
  belongs_to :facility
  attr_accessible :id, :active, :emplid, :facility_id, :firstname, :lastname, :tea_status

  delegate :name, :to => :facility, :prefix => true, :allow_nil => true

  validates_uniqueness_of :lastname, :scope => [:emplid, :firstname, :facility_id]

  def name
    [firstname,lastname].join(" ")
  end
end
