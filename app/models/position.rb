class Position < ActiveRecord::Base
  belongs_to :facility
  belongs_to :position_type
  has_many :position_numbers
  has_many :position_hists
  validates_presence_of [:title,:salary,:facility_id, :position_type_id]
  validates_uniqueness_of :title, :scope => [:facility_id, :position_type_id]
  
end
