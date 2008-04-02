class PppamsCategory < ActiveRecord::Base
    belongs_to :facility
    validates_presence_of [:name,:description,:facility_id]
end
