class PositionType < ActiveRecord::Base
  has_many :positions
  attr_accessible :id, :name, :description, :deductable, :deduction_days, :facility_id
end
