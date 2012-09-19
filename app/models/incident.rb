class Incident < ActiveRecord::Base
  belongs_to :action_type
  belongs_to :incident_type
  belongs_to :incident_class
  belongs_to :facility
  belongs_to :investigator

  has_many :follow_ups

  delegate :name, :to => :incident_type, :prefix => true, :allow_nil => true
  delegate :name, :to => :incident_class, :prefix => true, :allow_nil => true
  delegate :name, :to => :investigator, :prefix => true, :allow_nil => true
  delegate :name, :to => :action_type, :prefix => true, :allow_nil => true
  delegate :name, :to => :facility, :prefix => true, :allow_nil => true
  
  validates_presence_of :mins
  validates_uniqueness_of :mins
  validates_presence_of  :incident_date
  validates_presence_of :reported_date
  validates_presence_of :incident_type_id unless :incident_type_other
  validates_presence_of :facility_id
  validates_presence_of :incident_class_id

  attr_accessible :action_type_id, :action_type_other, :bureau_notified, :bureau_notified_on, :contract_manager_notified, :contract_manager_notified_on, :description, :designee_name, :entity_closing, :facility_id, :facility_investigation_complete, :facility_investigation_completed_on, :incident_class_id, :incident_on, :incident_type_id, :incident_type_other, :inspector_general_on, :investigation_closed, :investigation_closed_on, :investigator_id, :mins, :reported_on, :warden_notified, :warden_notified_on

  def days_open
    (DateTime.now.to_date - self.incident_on.to_date).to_i
  end

end
