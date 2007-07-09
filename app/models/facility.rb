class Facility < ActiveRecord::Base
  belongs_to :custody_type
  has_many :investigators
  has_many :users
  has_many :inmates
end
