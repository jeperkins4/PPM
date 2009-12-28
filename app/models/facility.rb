class Facility < ActiveRecord::Base
  has_many :investigators
  has_many :users
  has_many :inmate_counts
  has_many :position_types
  has_many :positions, :through => :position_types
  has_many :incidents
  has_many :employees
  has_many :accountability_logs
  has_many :accountability_log_details
  has_many :pppams_categories
  has_many :notification_receivers
  has_many :notification_reports
  has_many :non_comp_issues
  has_many :pppams_issues

  named_scope :with_indicator_base, lambda { |base_ref_id| 
    { :joins => "LEFT OUTER JOIN pppams_categories ON facilities.id = pppams_categories.facility_id
                 LEFT OUTER JOIN pppams_indicators ON pppams_categories.id = pppams_indicators.pppams_category_id",
      :conditions => ["pppams_indicators.pppams_indicator_base_ref_id = ?", base_ref_id]
    }
  }

  named_scope :with_category_base, lambda { |base_ref_id| 
    { :joins =>  "LEFT OUTER JOIN pppams_categories ON pppams_categories.id = pppams_categories.pppams_category_base_ref_id",
      :conditions => ["pppams_category_base_ref_id = ?", base_ref_id]
    }
  }


  def position_numbers
    self.positions.map(&:position_numbers).flatten
  end
  
  def position_hists
    self.positions.map(&:position_hists).flatten.sort {|a,b| b.create_date <=> a.create_date}
  end

end
