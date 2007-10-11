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
end
