class PppamsCategory < ActiveRecord::Base
    belongs_to :facility
    has_many :pppams_indicators
    validates_presence_of [:name,:description,:facility_id]
end
