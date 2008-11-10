class Facility < ActiveRecord::Base
  has_many :investigators
  has_many :users
  has_many :inmate_counts
  has_many :positions
  has_many :position_numbers, :through => :positions
  has_many :position_hists, :through => :positions
  has_many :incidents
  has_many :employees
  has_many :accountability_logs
  has_many :accountability_log_details
  has_many :pppams_categories
  has_many :notification_receivers
  has_many :notification_reports
  has_many :non_comp_issues
  has_many :pppams_issues
end
