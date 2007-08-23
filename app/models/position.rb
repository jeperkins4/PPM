class Position < ActiveRecord::Base
  belongs_to :position_type
  belongs_to :facility
end
