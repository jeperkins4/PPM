class Position < ActiveRecord::Base
  belongs_to :facility
  belongs_to :position_type
  has_many :position_numbers
  
 validates_existence_of :facility, :position_type
end
