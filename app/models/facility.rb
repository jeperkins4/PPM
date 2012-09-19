class Facility < ActiveRecord::Base
  has_many :accountability_logs
  has_many :accountability_log_details
  has_many :employees
  has_many :incidents
  has_many :inmate_counts
  has_many :investigators
  has_many :non_comp_issues
  has_many :notification_receivers
  has_many :notification_reports
  has_many :position_types
  has_many :positions, :through => :position_types
  has_many :pppams_indicators
  has_many :pppams_indicator_base_refs, :through => :pppams_indicators
  has_many :pppams_issues
  has_many :users

  validates_presence_of :name
  validates_presence_of :facility

  attr_accessible :id, :address1, :address2, :city, :contract_monitor, :name, :phone, :pppams_started_on, :shortname, :state, :warden, :zip

  #scope :with_indicator_base, lambda {|base_ref_id| joins{:pppams_indicators}.where(:pppams_indicator_base_ref_id => base_ref_id)}

end
