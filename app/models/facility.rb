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
  
  def position_numbers
    self.positions.map(&:position_numbers).flatten
  end
  
  def position_hists
    self.positions.map(&:position_hists).flatten.sort {|a,b| b.create_date <=> a.create_date}
  end
end
