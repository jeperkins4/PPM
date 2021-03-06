class PositionType < ActiveRecord::Base
  belongs_to :facility
  has_many :positions
  validates_presence_of :facility_id
  attr_accessible :id, :name, :description, :deductable, :deduction_days, :facility_id
end
