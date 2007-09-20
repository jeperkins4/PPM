class Incident < ActiveRecord::Base
  belongs_to :facility
  belongs_to :incident_type
  belongs_to :incident_class
  belongs_to :action_type
  has_many :follow_ups
  
  validates_presence_of :mins
  validates_uniqueness_of :mins
  validates_presence_of  :incident_date
  validates_presence_of :reported_date
  validates_presence_of :incident_type_id unless :incident_type_other
  validates_presence_of :facility_id
  validates_presence_of :incident_class_id
  

end
