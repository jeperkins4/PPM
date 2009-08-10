class PositionType < ActiveRecord::Base
  belongs_to :facility
  has_many :positions
  validates_presence_of :facility_id
end