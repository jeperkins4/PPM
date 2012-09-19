class Investigator < ActiveRecord::Base
  belongs_to :facility

  attr_accessible :email, :entity, :facility_id, :firstname, :lastname, :phone

  delegate :name, :to => :facility, :prefix => true, :allow_nil => true
  
  def name
    [firstname,lastname].join(" ")
  end
end
