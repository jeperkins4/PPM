class Facility < ActiveRecord::Base
<<<<<<< HEAD
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
  has_many :pppams_indicators
  has_many :pppams_issues
  has_many :users

  validates_presence_of :name

  attr_accessible :id, :address1, :address2, :city, :contract_monitor, :name, :phone, :pppams_started_on, :shortname, :state, :warden, :zip

  #scope :with_indicator_base, lambda {|base_ref_id| joins{:pppams_indicators}.where(:pppams_indicator_base_ref_id => base_ref_id)}
=======
  has_many :investigators
  has_many :users
  has_many :inmate_counts
  has_many :position_types
  has_many :positions, :through => :position_types
  has_many :incidents
  has_many :employees
  has_many :accountability_logs
  has_many :accountability_log_details
  has_many :pppams_indicators
  has_many :pppams_indicator_base_refs, :through => :pppams_indicators
  has_many :notification_receivers
  has_many :notification_reports
  has_many :non_comp_issues
  has_many :pppams_issues

  validates_presence_of :facility

  named_scope :with_indicator_base, lambda { |base_ref_id| 
    { :joins => "LEFT OUTER JOIN pppams_indicators ON pppams_indicators.facility_id = facilities.id",
      :conditions => ["pppams_indicators.pppams_indicator_base_ref_id = ?", base_ref_id]
    }
  }

  named_scope :with_category_base, lambda { |base_ref_id| 
    { :select => "DISTINCT(facilities.facility)",
    :joins =>  "LEFT OUTER JOIN pppams_indicators ON pppams_indicators.facility_id = facilities.id
                  LEFT OUTER JOIN pppams_indicator_base_refs ON pppams_indicator_base_refs.id = pppams_indicators.pppams_indicator_base_ref_id",
      :conditions => ["pppams_indicator_base_refs.pppams_category_base_ref_id = ?", base_ref_id]
    }
  }


  def position_numbers
    self.positions.map(&:position_numbers).flatten
  end
  
  def position_hists
    self.positions.map(&:position_hists).flatten.sort {|a,b| b.create_date <=> a.create_date}
  end

>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
